package com.lyracom.reactnativesdkpaymentmodule

import android.util.Log
import androidx.fragment.app.FragmentActivity
import com.facebook.react.bridge.Promise
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReadableMap
import com.lyra.sdk.Lyra
import com.lyra.sdk.exception.LyraException
import com.lyra.sdk.exception.LyraMobException
import com.lyra.sdk.model.InitOptions
import com.lyra.sdk.model.ProcessOptions
import com.lyracom.reactnativesdkpaymentmodule.extensions.toInitOptions
import com.lyracom.reactnativesdkpaymentmodule.extensions.toProcessOptions
import com.lyracom.reactnativesdkpaymentmodule.extensions.toWritableMap
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.launch
import org.json.JSONException

class ReactNativeSdkPaymentModuleModule(
  reactContext: ReactApplicationContext,
) : NativeReactNativeSdkPaymentModuleSpec(reactContext) {
  private var lyraSDK: Lyra? = Lyra
  private var context: ReactApplicationContext = reactContext
  private val moduleScope = CoroutineScope(SupervisorJob() + Dispatchers.Main)

  override fun getFormTokenVersion(): Double {
    Log.d(name, "getFormTokenVersion")
    return lyraSDK!!.getFormTokenVersion().toDouble()
  }

  override fun getSDKVersion(): String {
    Log.d(name, "getSDKVersion")
    return lyraSDK!!.getSDKVersion()
  }

  override fun initialize(publicKey: String, apiServerName: String, options: ReadableMap?, promise: Promise) {
    try {
      val initOptions = options?.toInitOptions() ?: InitOptions()
      lyraSDK!!.initialize(context.applicationContext, publicKey, apiServerName, initOptions)
      promise.resolve(null)
    } catch (lyraMobException: LyraMobException) {
      promise.reject(lyraMobException)
    }
  }

  override fun process(formToken: String, options: ReadableMap?, promise: Promise) {
    Log.d(name, "process")
    val processOptions = options?.toProcessOptions() ?: ProcessOptions()

    moduleScope.launch {
      try {
        val lyraResponse =
          Lyra.process(
            (context.currentActivity as FragmentActivity).supportFragmentManager,
            formToken,
            processOptions
          )

        try {
          promise.resolve(lyraResponse.toWritableMap())
        } catch (ex: JSONException) {
          Log.e(name, ex.message, ex)
        }
      } catch (lyraException: LyraException) {
        promise.reject(lyraException)
      }
    }
  }

  override fun cancelProcess() {
    lyraSDK!!.cancelProcess()
  }

  companion object {
    const val NAME = NativeReactNativeSdkPaymentModuleSpec.NAME
  }
}
