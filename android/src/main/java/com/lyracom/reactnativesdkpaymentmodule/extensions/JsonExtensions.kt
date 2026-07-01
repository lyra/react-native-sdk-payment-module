package com.lyracom.reactnativesdkpaymentmodule.extensions

import com.facebook.react.bridge.WritableArray
import com.facebook.react.bridge.WritableMap
import com.facebook.react.bridge.WritableNativeArray
import com.facebook.react.bridge.WritableNativeMap
import org.json.JSONArray
import org.json.JSONException
import org.json.JSONObject

@Throws(JSONException::class)
fun JSONArray?.toWritableArray(): WritableArray? {
  val array: WritableArray = WritableNativeArray()
  if (this != null) {
    for (i in 0 until this.length()) {
      when (val value = this[i]) {
        is JSONObject -> array.pushMap(value.toWritableMap())
        is JSONArray -> array.pushArray(value.toWritableArray())
        is Boolean -> array.pushBoolean(value)
        is Int -> array.pushInt(value)
        is Double -> array.pushDouble(value)
        is String -> array.pushString(value)
        else -> array.pushString(value.toString())
      }
    }
  }
  return array
}

@Throws(JSONException::class)
fun JSONObject?.toWritableMap(): WritableMap? {
  val map: WritableMap = WritableNativeMap()
  if (this != null) {
    val iterator: Iterator<String> = this.keys()
    while (iterator.hasNext()) {
      val key = iterator.next()
      when (val value = this.get(key)) {
        is JSONObject -> map.putMap(key, value.toWritableMap())
        is JSONArray -> map.putArray(key, value.toWritableArray())
        is Boolean -> map.putBoolean(key, value)
        is Int -> map.putInt(key, value)
        is Double -> map.putDouble(key, value)
        is String -> map.putString(key, value)
        else -> map.putString(key, value.toString())
      }
    }
  }
  return map
}


