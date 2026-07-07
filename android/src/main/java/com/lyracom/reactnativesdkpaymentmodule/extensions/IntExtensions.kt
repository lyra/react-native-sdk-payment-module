package com.lyracom.reactnativesdkpaymentmodule.extensions

import com.lyra.sdk.model.enums.LyraPaymentMethods

fun Int.toLyraPaymentMethod(): LyraPaymentMethods? = LyraPaymentMethods.entries.firstOrNull { it.value == this }
