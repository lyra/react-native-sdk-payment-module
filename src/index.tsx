import SdkPaymentModule from './NativeSdkPaymentModule';
import { Platform } from 'react-native';

export function getFormTokenVersion(): number {
  return SdkPaymentModule.getFormTokenVersion();
}

export function initialize(publicKey: string, options: Object): Promise<void> {
  return SdkPaymentModule.initialize(publicKey, options);
}

export function process(formToken: string, options: Object): Promise<any> {
  return SdkPaymentModule.process(formToken, options);
}

export function cancelProcess() {
  return SdkPaymentModule.cancelProcess();
}

export const InitializeOptions = {
  apiServerName: 'apiServerName', // Mandatory
  applePayMerchantId: Platform.OS === 'android' ? '' : 'applePayMerchantId', // iOS only
  applePayMerchantName: Platform.OS === 'android' ? '' : 'applePayMerchantName', // iOS only
};

export const ProcessOptions = {
  customPayButtonLabel:
    Platform.OS === 'android' ? 'CustomPayButtonLabel' : 'customPayButtonLabel',
  customHeaderLabel:
    Platform.OS === 'android' ? 'CustomHeaderLabel' : 'customHeaderLabel',
  customPopupLabel:
    Platform.OS === 'android' ? 'CustomPopupLabel' : 'customPopupLabel',
  paymentMethodType: Platform.OS === 'android' ? '' : 'paymentMethodType', // Not yet supported on Android, iOS only
};
