package com.sdkpaymentmodule

import android.util.Log
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.module.annotations.ReactModule


@ReactModule(name = SdkPaymentModuleModule.NAME)
class SdkPaymentModuleModule(reactContext: ReactApplicationContext) :
  NativeSdkPaymentModuleSpec(reactContext) {

  override fun getName(): String {
    return NAME
  }

  override fun getFormTokenVersion(): Double {
    Log.d("========>", "getFormTokenVersion (from native)")
    return 12.0
  }

  override fun initialize(formToken: String?) {
    Log.d("========>", "initialize (from native) $formToken")
  }

  override fun process(formToken: String?) {
    Log.d("========>", "process (from native) $formToken")
  }

  companion object {
    const val NAME = "SdkPaymentModule"
  }
}
