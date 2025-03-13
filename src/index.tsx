import SdkPaymentModule from './NativeSdkPaymentModule';

export function getFormTokenVersion(): number {
  return SdkPaymentModule.getFormTokenVersion();
}

export function initialize(publicKey: string, options: Object): void {
  return SdkPaymentModule.initialize(publicKey, options);
}

export function process(formToken: string, options: Object): void {
  return SdkPaymentModule.process(formToken, options);
}
