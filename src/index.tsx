import SdkPaymentModule from './NativeSdkPaymentModule';

export function getFormTokenVersion(): number {
  return SdkPaymentModule.getFormTokenVersion();
}

export function initialize(
  publicKey: string,
  options: Object,
  onError: (error: any) => void
): void {
  return SdkPaymentModule.initialize(publicKey, options, onError);
}

export function process(
  formToken: string,
  options: Object,
  onSuccess: (result: any) => void,
  onError: (error: any) => void
): void {
  return SdkPaymentModule.process(formToken, options, onSuccess, onError);
}
