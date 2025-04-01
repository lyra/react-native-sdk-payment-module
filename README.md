# react-native-sdk-payment-module

A React Native module for the native (iOS and Android) Lyra Payment SDK.

## Installation & usage

Documentation : https://payzen.io/fr-FR/mobp/integration_guide/react_native/

Integration App Example : https://github.com/lyra/react-native-sdk-payment-example

> [!IMPORTANT]
> @lyracom/react-native-sdk-payment-module **requires react-native 0.77+**.

## Development workflow

This project is a monorepo managed using [Yarn workspaces](https://yarnpkg.com/features/workspaces). It contains the following packages:

- The library package in the root directory.
- An example app in the `example/` directory.

To get started with the project, run `yarn` in the root directory to install the required dependencies for each package:

```sh
yarn
```

The [example app](/example/) demonstrates usage of the library. You need to run it to test any changes you make.

It is configured to use the local version of the library, so any changes you make to the library's source code will be reflected in the example app. Changes to the library's JavaScript code will be reflected in the example app without a rebuild, but native code changes will require a rebuild of the example app.

If you want to use Android Studio or XCode to edit the native code, you can open the `example/android` or `example/ios` directories respectively in those editors. To edit the Objective-C or Swift files, open `example/ios/SdkPaymentModuleExample.xcworkspace` in XCode and find the source files at `Pods > Development Pods > react-native-sdk-payment-module`.

To edit the Java or Kotlin files, open `example/android` in Android studio and find the source files at `react-native-sdk-payment-module` under `Android`.

You can use various commands from the root directory to work with the project.

To start the packager:

```sh
yarn example start
```

To run the example app on Android:

```sh
yarn example android
```

To run the example app on iOS:

```sh
yarn example ios
```

To confirm that the app is running with the new architecture, you can check the Metro logs for a message like this:

```sh
Running "SdkPaymentModuleExample" with {"fabric":true,"initialProps":{"concurrentRoot":true},"rootTag":1}
```

Note the `"fabric":true` and `"concurrentRoot":true` properties.

## License

MIT

---

Made with [create-react-native-library](https://github.com/callstack/react-native-builder-bob)
