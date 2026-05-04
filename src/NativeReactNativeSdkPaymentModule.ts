import { TurboModuleRegistry, type TurboModule } from 'react-native';
import type { Int32 } from 'react-native/Libraries/Types/CodegenTypesNamespace';

export interface Spec extends TurboModule {
  getFormTokenVersion(): Int32;
  getSDKVersion(): string;
  initialize(publicKey: string, options: Object): Promise<void>;
  process(formToken: string, options: Object): Promise<void>;
  cancelProcess(): void;
}

export default TurboModuleRegistry.getEnforcing<Spec>(
  'ReactNativeSdkPaymentModule'
);
