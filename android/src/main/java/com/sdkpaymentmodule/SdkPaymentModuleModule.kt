package com.sdkpaymentmodule

import android.util.Log
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReadableMap
import com.facebook.react.module.annotations.ReactModule
import com.lyra.sdk.Lyra


@ReactModule(name = SdkPaymentModuleModule.NAME)
class SdkPaymentModuleModule(reactContext: ReactApplicationContext) :
  NativeSdkPaymentModuleSpec(reactContext) {

  private var lyraSDK: Lyra? = Lyra

  override fun getName(): String {
    return NAME
  }

  override fun getFormTokenVersion(): Double {
    Log.d("========>", "getFormTokenVersion (from native)")
    return lyraSDK!!.getFormTokenVersion().toDouble()
  }

  override fun initialize(publicKey: String?, options: ReadableMap?) {
    Log.d("========>", "initialize (from native) $publicKey")
  }

  override fun process(formToken: String?, options: ReadableMap?) {
    Log.d("========>", "process (from native) $formToken")
  }

  companion object {
    const val NAME = "SdkPaymentModule"
  }
}
