# react-native-sdk-payment-module

A React Native module for the native (iOS and Android) Lyra Payment SDK.

## Installation & usage

> [!IMPORTANT]
> @lyracom/react-native-sdk-payment-module **1.0.18 doesn't support react-native 0.77+**.
> A new version will soon be released to address this issue

Documentation : https://payzen.io/fr-FR/mobp/integration_guide/react_native/

Integration App Example : https://github.com/lyra/react-native-sdk-payment-example

> [!IMPORTANT]
> @lyracom/react-native-sdk-payment-module **2.0.0** is now a TurboModule, and **requires the new architecture to be enabled and react-native 0.77+**.
>
> - If you want to use @lyracom/react-native-sdk-payment-module 2.x.x, you need to enable the new architecture in your app (see ["Enable the New Architecture for Apps"](https://github.com/reactwg/react-native-new-architecture/blob/main/docs/enable-apps.md)) and upgrade to React-Native 0.77.x
> - For React-Native 0.76.x and older, use @lyracom/react-native-sdk-payment-module 1.0.18

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
