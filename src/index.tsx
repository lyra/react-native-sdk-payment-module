import ReactNativeSdkPaymentModule from './NativeReactNativeSdkPaymentModule';

interface InitializeOptions {
  apiServerName: String;
  applePayMerchantId?: String; // Apple only
  applePayMerchantName?: String; // Apple only
  nfcEnabled?: boolean; // Android only
  cardScanningEnabled?: boolean;
}

export enum PaymentMethods {
  ALL = 'all',
  APPLE_PAY = 'applePay', // Apple only
  GOOGLE_PAY = 'googlePay', // Android only
  CARD = 'cardPayment',
}

interface ProcessOptions {
  customPayButtonLabel?: String;
  customHeaderLabel?: String;
  customPopupLabel?: String;
  paymentMethodType?: PaymentMethods;
}

export function getFormTokenVersion(): number {
  return ReactNativeSdkPaymentModule.getFormTokenVersion();
}

/** @deprecated replace with getSDKVersion */
export function getSdkVersion(): string {
  return ReactNativeSdkPaymentModule.getSDKVersion();
}

export function getSDKVersion(): string {
  return ReactNativeSdkPaymentModule.getSDKVersion();
}

export function initialize(
  publicKey: string,
  options: InitializeOptions
): Promise<void> {
  return ReactNativeSdkPaymentModule.initialize(publicKey, options);
}

export function process(
  formToken: string,
  options: ProcessOptions
): Promise<any> {
  return ReactNativeSdkPaymentModule.process(formToken, options);
}

export function cancelProcess() {
  return ReactNativeSdkPaymentModule.cancelProcess();
}
