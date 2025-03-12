import SdkPaymentModule from './NativeSdkPaymentModule';

export function getFormTokenVersion(): number {
  return SdkPaymentModule.getFormTokenVersion();
}

export function initialize(publicKey: string): void {
  return SdkPaymentModule.initialize(publicKey);
}

export function process(formToken: string): void {
  return SdkPaymentModule.process(formToken);
}
