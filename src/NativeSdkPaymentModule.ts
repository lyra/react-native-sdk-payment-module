import type { TurboModule } from 'react-native';
import { TurboModuleRegistry } from 'react-native';

export interface Spec extends TurboModule {
  getFormTokenVersion(): number;
  initialize(publicKey: string): void;
  process(formToken: string): void;
}

export default TurboModuleRegistry.getEnforcing<Spec>('SdkPaymentModule');
