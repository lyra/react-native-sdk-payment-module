package com.sdkpaymentmodule

import android.util.Log
import androidx.fragment.app.FragmentActivity
import com.facebook.react.bridge.Promise
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReadableMap
import com.facebook.react.bridge.WritableMap
import com.facebook.react.module.annotations.ReactModule
import com.lyra.sdk.Lyra
import com.lyra.sdk.callback.LyraHandler
import com.lyra.sdk.callback.LyraResponse
import com.lyra.sdk.exception.LyraException
import com.lyra.sdk.exception.LyraMobException
import org.json.JSONException


@ReactModule(name = SdkPaymentModuleModule.NAME)
class SdkPaymentModuleModule(reactContext: ReactApplicationContext) :
  NativeSdkPaymentModuleSpec(reactContext) {

  private var lyraSDK: Lyra? = Lyra
  private var context: ReactApplicationContext = reactContext

  override fun getFormTokenVersion(): Double {
    Log.d(name, "getFormTokenVersion")
    return lyraSDK!!.getFormTokenVersion().toDouble()
  }

  override fun initialize(publicKey: String, options: ReadableMap, promise: Promise) {
    try {
      lyraSDK!!.initialize(context.applicationContext, publicKey, options.toHashMap())
      promise.resolve(null)
    } catch (lyraMobException: LyraMobException) {
      promise.reject(lyraMobException)
    }
  }

  override fun process(formToken: String, options: ReadableMap, promise: Promise) {
    Log.d(name, "process")
    try{
      lyraSDK!!.process((context.currentActivity as FragmentActivity).supportFragmentManager,
        formToken, object : LyraHandler {
          override fun onSuccess(lyraResponse: LyraResponse) {
            var map: WritableMap? = null
            try {
              map = Util.convertJsonToMap(lyraResponse)
              promise.resolve(map)
            } catch (ex: JSONException) {
              Log.e(name, ex.message, ex)
            }
          }

          override fun onError(lyraException: LyraException, lyraResponse: LyraResponse?) {
            promise.reject(lyraException)
          }
        }, options.toHashMap()
      )
    } catch(lyraMobException: LyraMobException){
      promise.reject(lyraMobException)
    }
  }

  companion object {
    const val NAME = "SdkPaymentModule"
  }
}
