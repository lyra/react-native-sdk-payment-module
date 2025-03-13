package com.sdkpaymentmodule

import org.json.JSONArray
import org.json.JSONException
import org.json.JSONObject
import kotlin.Boolean
import kotlin.Double
import kotlin.Int
import kotlin.String
import kotlin.Throws
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.bridge.WritableArray;
import com.facebook.react.bridge.WritableNativeMap;
import com.facebook.react.bridge.WritableNativeArray;

object Util {
  @Throws(JSONException::class)
  fun convertJsonToMap(jsonObject: JSONObject?): WritableMap? {
    val map: WritableMap = WritableNativeMap()
    if (jsonObject != null) {
      val iterator: Iterator<String> = jsonObject.keys()
      while (iterator.hasNext()) {
        val key = iterator.next()
        val value = jsonObject.get(key)
        if (value is JSONObject) {
          map.putMap(key, convertJsonToMap(value))
        } else if (value is JSONArray) {
          map.putArray(key, convertJsonToArray(value))
        } else if (value is Boolean) {
          map.putBoolean(key, value)
        } else if (value is Int) {
          map.putInt(key, value)
        } else if (value is Double) {
          map.putDouble(key, value)
        } else if (value is String) {
          map.putString(key, value)
        } else {
          map.putString(key, value.toString())
        }
      }
    }
    return map
  }

  @Throws(JSONException::class)
  fun convertJsonToArray(jsonArray: JSONArray?): WritableArray? {
    val array: WritableArray = WritableNativeArray()
    if (jsonArray != null) {
      for (i in 0 until jsonArray.length()) {
        val value = jsonArray[i]
        if (value is JSONObject) {
          array.pushMap(convertJsonToMap(value))
        } else if (value is JSONArray) {
          array.pushArray(convertJsonToArray(value))
        } else if (value is Boolean) {
          array.pushBoolean(value)
        } else if (value is Int) {
          array.pushInt(value)
        } else if (value is Double) {
          array.pushDouble(value)
        } else if (value is String) {
          array.pushString(value)
        } else {
          array.pushString(value.toString())
        }
      }
    }
    return array
  }
}
