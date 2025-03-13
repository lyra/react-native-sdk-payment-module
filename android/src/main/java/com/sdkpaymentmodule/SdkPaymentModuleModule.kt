package com.sdkpaymentmodule

import android.util.Log
import androidx.fragment.app.FragmentActivity
import com.facebook.react.bridge.Callback
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReadableMap
import com.facebook.react.bridge.WritableMap
import com.facebook.react.bridge.WritableNativeMap
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

  override fun initialize(publicKey: String, options: ReadableMap, onError: Callback) {
    Log.d(name, "initialize")
    try{
      lyraSDK!!.initialize(context.applicationContext, publicKey, options.toHashMap())
    } catch(lyraMobException: LyraMobException){
      val map: WritableMap = WritableNativeMap()
      try {
        val error: WritableMap = WritableNativeMap()
        error.putString("detailErrorCode", lyraMobException.detailErrorCode)
        error.putString("detailErrorMessage", lyraMobException.detailErrorMessage)
        error.putString("errorCode", lyraMobException.errorCode)
        error.putString("errorMessage", lyraMobException.errorMessage)
        lyraMobException.technicalError?.let { error.putBoolean("technicalError", it) }
        map.putMap("error", error)
      } catch (ex: JSONException) {
        Log.e(name, ex.message, ex)
      }
      onError.invoke(map)
    }
  }

  override fun process(formToken: String, options: ReadableMap, onSuccess: Callback, onError: Callback) {
    Log.d(name, "process")
    try{
      lyraSDK!!.process((context.currentActivity as FragmentActivity).supportFragmentManager,
        formToken, object : LyraHandler {
          override fun onSuccess(lyraResponse: LyraResponse) {
            var map: WritableMap? = null
            try {
              map = Util.convertJsonToMap(lyraResponse)
            } catch (ex: JSONException) {
              Log.e(name, ex.message, ex)
            }
            onSuccess.invoke(map)
          }

          override fun onError(lyraException: LyraException, lyraResponse: LyraResponse?) {
            var map: WritableMap? = null
            try {
              map = Util.convertJsonToMap(lyraResponse)
              val error: WritableMap = WritableNativeMap()
              error.putString("detailErrorCode", lyraException.detailErrorCode)
              error.putString("detailErrorMessage", lyraException.detailErrorMessage)
              error.putString("errorCode", lyraException.errorCode)
              error.putString("errorMessage", lyraException.errorMessage)
              lyraException.technicalError?.let { error.putBoolean("technicalError", it) }
              map?.putMap("error", error)
            } catch (ex: JSONException) {
              Log.e(name, ex.message, ex)
            }
            onError.invoke(map)
          }
        }, options.toHashMap()
      )
    } catch(lyraMobException: LyraMobException){
      val map: WritableMap = WritableNativeMap()
      try {
        val error: WritableMap = WritableNativeMap()
        error.putString("detailErrorCode", lyraMobException.detailErrorCode)
        error.putString("detailErrorMessage", lyraMobException.detailErrorMessage)
        error.putString("errorCode", lyraMobException.errorCode)
        error.putString("errorMessage", lyraMobException.errorMessage)
        lyraMobException.technicalError?.let { error.putBoolean("technicalError", it) }
        map.putMap("error", error)
      } catch (ex: JSONException) {
        Log.e(name, ex.message, ex)
      }
      onError.invoke(map)
    }
  }
  companion object {
    const val NAME = "SdkPaymentModule"
  }
}
