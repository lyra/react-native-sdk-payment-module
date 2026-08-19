# react-native-sdk-payment-module

A React Native module for the native (iOS and Android) Lyra Payment SDK.

## Installation & usage

Documentation : https://payzen.io/fr-FR/mobp/integration_guide/react_native/

## Development workflow

This project is a monorepo managed using [Yarn workspaces](https://yarnpkg.com/features/workspaces). It contains the following packages:

- The library package in the root directory.
- A bare React Native example in the `apps/example/` directory.
- An Expo example in the `apps/expoExample/` directory.

To get started with the project, run `yarn` in the root directory to install the required dependencies for each package:

```sh
yarn
```

The [example app](/apps/example/) demonstrates usage of the library. You need to run it to test any changes you make.

It is configured to use the local version of the library, so any changes you make to the library's source code will be reflected in the example app. Changes to the library's JavaScript code will be reflected in the example app without a rebuild, but native code changes will require a rebuild of the example app.

If you want to use Android Studio or XCode to edit the native code, you can open the `apps/example/android` or `apps/example/ios` directories respectively in those editors. To edit the Objective-C or Swift files, open `apps/example/ios/SdkPaymentModuleExample.xcworkspace` in XCode and find the source files at `Pods > Development Pods > react-native-sdk-payment-module`.

To edit the Java or Kotlin files, open `apps/example/android` in Android studio and find the source files at `react-native-sdk-payment-module` under `Android`.

## License

MIT

---
