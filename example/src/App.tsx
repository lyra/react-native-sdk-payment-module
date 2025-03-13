import { Text, View, StyleSheet } from 'react-native';
import {
  initialize,
  getFormTokenVersion,
  process,
} from '@lyracom/react-native-sdk-payment-module';

initialize('key', {}, () => {});
const result = getFormTokenVersion();
process(
  'key',
  {},
  () => {},
  () => {}
);

export default function App() {
  return (
    <View style={styles.container}>
      <Text>Result: {result}</Text>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
});
