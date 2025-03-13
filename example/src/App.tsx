import { Text, View, StyleSheet, Pressable, Alert } from 'react-native';
import {
  initialize,
  getFormTokenVersion,
  process,
} from '@lyracom/react-native-sdk-payment-module';
import Config from './Config';
import { useCallback } from 'react';

process(
  'key',
  {},
  () => {},
  () => {}
);

export default function App() {
  /**
   * Uses this function for get the formToken (required param in SDK process method)
   */
  const getProcessPaymentContext = async () => {
    var formTokenVersion = getFormTokenVersion();
    return fetch(Config.merchantServerUrl + '/createPayment', {
      method: 'POST',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        amount: Config.amount,
        mode: Config.paymentMode,
        customer: {
          email: Config.email,
          reference: Config.customerReference,
        },
        currency: Config.currency,
        orderId: Config.orderId,
        formTokenVersion: formTokenVersion,
      }),
    })
      .then((result) => result.json())
      .then((json) => json.answer.formToken)
      .catch((error) => {
        console.error(error);
      });
  };

  const handlePay = useCallback(async () => {
    console.log('::::> Pay');
    // 1.Initialize Payment SDK
    initialize(
      Config.publicKey,
      {
        cardScanningEnabled: true,
        nfcEnabled: true,
        apiServerName: Config.apiServerName,
      },
      async (result) => {
        // onError
        Alert.alert(result.error.errorMessage);
      }
    );

    // 2. Execute getProcessPaymentContext for get the formToken (required param in SDK process method)
    let formToken = await getProcessPaymentContext();

    console.log('Form token :', formToken);
  }, []);

  return (
    <View style={styles.container}>
      <Pressable style={styles.button} onPress={handlePay}>
        <Text style={styles.buttonLabel}>Pay</Text>
      </Pressable>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  button: {
    backgroundColor: 'blue',
    paddingHorizontal: 18,
    paddingVertical: 8,
    borderRadius: 10,
  },
  buttonLabel: {
    color: 'white',
    fontSize: 18,
  },
});
