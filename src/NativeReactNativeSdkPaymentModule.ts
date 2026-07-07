import type { CodegenTypes } from 'react-native';
import { TurboModuleRegistry, type TurboModule } from 'react-native';

export interface Spec extends TurboModule {
  getFormTokenVersion(): CodegenTypes.Int32;
  getSDKVersion(): string;
  initialize(
    publicKey: string,
    apiServerName: string,
    options?: Object
  ): Promise<void>;
  process(formToken: string, options?: Object): Promise<void>;
  cancelProcess(): void;
}

export default TurboModuleRegistry.getEnforcing<Spec>(
  'ReactNativeSdkPaymentModule'
);
