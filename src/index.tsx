import SdkPaymentModule from './NativeSdkPaymentModule';

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
  return SdkPaymentModule.getFormTokenVersion();
}
export function sdkVersion(): string {
  return SdkPaymentModule.sdkVersion();
}

export function initialize(
  publicKey: string,
  options: InitializeOptions
): Promise<void> {
  return SdkPaymentModule.initialize(publicKey, options);
}

export function process(
  formToken: string,
  options: ProcessOptions
): Promise<any> {
  return SdkPaymentModule.process(formToken, options);
}

export function cancelProcess() {
  return SdkPaymentModule.cancelProcess();
}
