import type { TurboModule } from 'react-native';
import { TurboModuleRegistry } from 'react-native';

export interface Spec extends TurboModule {
  getFormTokenVersion(): number;
  initialize(
    publicKey: string,
    options: Object,
    onError: (error: Object) => void
  ): void;
  process(
    formToken: string,
    options: Object,
    onSuccess: (result: Object) => void,
    onError: (error: Object) => void
  ): void;
}

export default TurboModuleRegistry.getEnforcing<Spec>('SdkPaymentModule');
