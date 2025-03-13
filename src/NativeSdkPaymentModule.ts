import type { TurboModule } from 'react-native';
import { TurboModuleRegistry } from 'react-native';

export interface Spec extends TurboModule {
  getFormTokenVersion(): number;
  initialize(
    publicKey: string,
    options: Object
    //onError: (result: any) => void
  ): void;
  process(formToken: string, options: Object): void;
}

export default TurboModuleRegistry.getEnforcing<Spec>('SdkPaymentModule');
