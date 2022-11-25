import { NativeModules, Platform } from 'react-native';

const LINKING_ERROR =
  `The package 'react-native-sdk-payment-module' doesn't seem to be linked. Make sure: \n\n` +
  Platform.select({ ios: "- You have run 'pod install'\n", default: '' }) +
  '- You rebuilt the app after installing the package\n' +
  '- You are not using Expo Go\n';

const SdkPaymentModule = NativeModules.SdkPaymentModule
  ? NativeModules.SdkPaymentModule
  : new Proxy(
      {},
      {
        get() {
          throw new Error(LINKING_ERROR);
        },
      }
    );

export function getFormTokenVersion(): number {
  return SdkPaymentModule.getFormTokenVersion();
}

export function initialize(
  publicKey: string,
  options: Object,
  onError: (result: any) => void
) {
  SdkPaymentModule.initialize(publicKey, options, onError);
}

export function process(
  formToken: string,
  options: Object,
  onSuccess: (result: any) => void,
  onError: (result: any) => void
) {
  SdkPaymentModule.process(formToken, options, onSuccess, onError);
}

// not working in react native because callback cannot be called multiple times
// export function cancelProcess() {
//   return SdkPaymentModule.cancelProcess();
// }
