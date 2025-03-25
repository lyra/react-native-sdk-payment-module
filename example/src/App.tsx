import { Text, View, StyleSheet, Pressable, Alert } from 'react-native';
import {
  initialize,
  getFormTokenVersion,
  process,
} from '@lyracom/react-native-sdk-payment-module';
import Config from './Config';
import { useCallback } from 'react';

export default function App() {
  /**
   * Uses this function for get the formToken (required param in SDK process method)
   */
  const getProcessPaymentContext = async () => {
    var formTokenVersion = getFormTokenVersion();
    return fetch(Config.merchantServerUrl + '/createPayment/INTE01_FRANCE', {
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

  /**
   * Uses this function to validate the payment using your server: check the response integrity by verifying the hash on your server.
   * @param {*} paymentResult  The result of SDK process method
   */
  const verifyPayment = async (paymentResult: any) => {
    return fetch(Config.merchantServerUrl + '/verifyResult/INTE01_FRANCE', {
      method: 'POST',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: paymentResult,
    });
  };

  const handlePay = useCallback(async () => {
    // 1.Initialize Payment SDK
    initialize(
      Config.publicKey,
      {
        cardScanningEnabled: true,
        nfcEnabled: true,
        apiServerName: Config.apiServerName,
      },
      async (result) => {
        console.log('=======> 1111111', result);
        // onError
        Alert.alert(result.error.errorMessage);
      }
    );

    // 2. Execute getProcessPaymentContext for get the formToken (required param in SDK process method)
    let formToken = await getProcessPaymentContext();

    console.log('=======> formTOken retrieved', formToken);

    // 3. Call the PaymentSDK process method
    process(
      formToken!,
      {},
      async (result) => {
        console.log('======> result', result);
        // onSuccess
        //4. Verify the payment using your server
        verifyPayment(result.response)
          .then(() => {
            console.log('=======> 22222222222', result);
            Alert.alert('Payment success');
          })
          .catch(() => {
            console.log('=======> 333333333 ', result);
            Alert.alert('Payment verification fail');
          });
      },
      async (result) => {
        // onError
        console.log('=======> 4444444444', result);
        Alert.alert(result.error.errorMessage);
      }
    );
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
