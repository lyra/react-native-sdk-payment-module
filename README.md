# react-native-sdk-payment-module

A React Native module for the native (iOS and Android) Lyra Payment SDK.

## Installation & usage

Documentation : https://payzen.io/fr-FR/mobp/integration_guide/react_native/

### iOS dependency management

LyraPaymentSDK 4.2.2 is resolved by Swift Package Manager from
https://github.com/lyra/ios-sdk.git, including its transitive dependencies.
The module uses React Native's
`spm_dependency` helper (the examples use React Native 0.83).

Load the module's helper near the top of your Podfile:

```ruby
require File.join(File.dirname(Pod::Executable.execute_command('node', ['-p',
	'require.resolve("@lyracom/react-native-sdk-payment-module/package.json", { paths: [process.argv[1]] })',
	__dir__]).strip), 'ios/lyra_payment_sdk')
```

Add the helper call after your existing `react_native_post_install` call, inside
the same `post_install` block:

```ruby
post_install do |installer|
	react_native_post_install(installer, config[:reactNativePath], :mac_catalyst_enabled => false)
	lyra_payment_post_install(installer)
end
```

Keep any other existing post-install configuration. Remove any explicit
`pod 'LyraPaymentSDK'` declaration and old Lyra-specific `pre_install` framework
overrides, then run `pod install` from the iOS directory.

React Native's helper makes the SDK available to the native module. The
`lyra_payment_post_install` helper also attaches the same SPM product to each
application target using the module, including App Clip targets, so Xcode embeds
its dynamic frameworks.
Both helpers are required: compilation alone does not confirm that the SDK can
be loaded at launch. No manual package addition in Xcode is needed. Repeated
installs do not duplicate references.

If your application already declares the same Swift package, its existing
reference is reused unchanged. The module's exact `4.2.2` requirement is not
applied to the application target, so check that your requirement allows `4.2.2`.

For Expo, add the module to the `plugins` array in your app configuration:

```json
{
  "expo": {
    "plugins": ["@lyracom/react-native-sdk-payment-module"]
  }
}
```

The plugin preserves your CocoaPods linkage and adds both the helper import and
its post-install call. It does not remove an existing `pod 'LyraPaymentSDK'`
line, so delete it manually if present. Run `yarn expo prebuild --platform ios`,
then rebuild your development client. Expo Go cannot load this native module. The
bare and Expo examples already include the corresponding configuration.

If an earlier plugin version enabled `ios.useFrameworks: dynamic` solely for
Lyra, remove that setting from `ios/Podfile.properties.json` and any corresponding
app configuration or `USE_FRAMEWORKS` environment variable. Keep it if another
dependency requires it; the plugin no longer changes this setting.

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
