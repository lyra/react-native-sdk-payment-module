
/**
 * This code was generated by [react-native-codegen](https://www.npmjs.com/package/react-native-codegen).
 *
 * Do not edit this file as changes may cause incorrect behavior and will be lost
 * once the code is regenerated.
 *
 * @generated by codegen project: GenerateModuleJniCpp.js
 */

#include "RNSdkPaymentModuleSpec.h"

namespace facebook::react {

static facebook::jsi::Value __hostFunction_NativeSdkPaymentModuleSpecJSI_getFormTokenVersion(facebook::jsi::Runtime& rt, TurboModule &turboModule, const facebook::jsi::Value* args, size_t count) {
  static jmethodID cachedMethodId = nullptr;
  return static_cast<JavaTurboModule &>(turboModule).invokeJavaMethod(rt, NumberKind, "getFormTokenVersion", "()D", args, count, cachedMethodId);
}

static facebook::jsi::Value __hostFunction_NativeSdkPaymentModuleSpecJSI_initialize(facebook::jsi::Runtime& rt, TurboModule &turboModule, const facebook::jsi::Value* args, size_t count) {
  static jmethodID cachedMethodId = nullptr;
  return static_cast<JavaTurboModule &>(turboModule).invokeJavaMethod(rt, VoidKind, "initialize", "(Ljava/lang/String;)V", args, count, cachedMethodId);
}

static facebook::jsi::Value __hostFunction_NativeSdkPaymentModuleSpecJSI_process(facebook::jsi::Runtime& rt, TurboModule &turboModule, const facebook::jsi::Value* args, size_t count) {
  static jmethodID cachedMethodId = nullptr;
  return static_cast<JavaTurboModule &>(turboModule).invokeJavaMethod(rt, VoidKind, "process", "(Ljava/lang/String;)V", args, count, cachedMethodId);
}

NativeSdkPaymentModuleSpecJSI::NativeSdkPaymentModuleSpecJSI(const JavaTurboModule::InitParams &params)
  : JavaTurboModule(params) {
  methodMap_["getFormTokenVersion"] = MethodMetadata {0, __hostFunction_NativeSdkPaymentModuleSpecJSI_getFormTokenVersion};
  methodMap_["initialize"] = MethodMetadata {1, __hostFunction_NativeSdkPaymentModuleSpecJSI_initialize};
  methodMap_["process"] = MethodMetadata {1, __hostFunction_NativeSdkPaymentModuleSpecJSI_process};
}

std::shared_ptr<TurboModule> RNSdkPaymentModuleSpec_ModuleProvider(const std::string &moduleName, const JavaTurboModule::InitParams &params) {
  if (moduleName == "SdkPaymentModule") {
    return std::make_shared<NativeSdkPaymentModuleSpecJSI>(params);
  }
  return nullptr;
}

} // namespace facebook::react
