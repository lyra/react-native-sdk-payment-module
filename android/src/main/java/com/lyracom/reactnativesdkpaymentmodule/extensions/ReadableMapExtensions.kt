package com.lyracom.reactnativesdkpaymentmodule.extensions

import com.facebook.react.bridge.ReadableMap
import com.lyra.sdk.model.InitOptions
import com.lyra.sdk.model.ProcessOptions

fun ReadableMap.toInitOptions(): InitOptions {
  val initOptions = InitOptions()

  if (hasKey("nfcEnabled")) initOptions.nfcEnabled = getBoolean("nfcEnabled")
  if (hasKey("cardScanningEnabled")) initOptions.cardScanningEnabled = getBoolean("cardScanningEnabled")
  if (hasKey("theme")) initOptions.theme = getInt("theme")

  return initOptions
}


fun ReadableMap.toProcessOptions(): ProcessOptions {
  val processOptions = ProcessOptions()

  getString("customPayButtonLabel")?.let { processOptions.customPayButtonLabel = it }
  getString("customHeaderLabel")?.let { processOptions.customHeaderLabel = it }
  getString("customPopupLabel")?.let { processOptions.customPopupLabel = it }
  if (hasKey("paymentMethodType")) {
    getInt("paymentMethodType").toLyraPaymentMethod()?.let {
      processOptions.paymentMethodType = it
    }
  }

  return processOptions
}
