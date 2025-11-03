import type { TurboModule } from 'react-native';
import { TurboModuleRegistry } from 'react-native';
import type { Int32 } from 'react-native/Libraries/Types/CodegenTypes';

export interface Spec extends TurboModule {
  getFormTokenVersion(): Int32;
  initialize(publicKey: string, options: Object): Promise<void>;
  process(formToken: string, options: Object): Promise<void>;
  cancelProcess(): void;
  sdkVersion(): string;
}

export default TurboModuleRegistry.getEnforcing<Spec>('SdkPaymentModule');
