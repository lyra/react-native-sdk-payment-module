require "json"
require_relative "ios/lyra_payment_sdk"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

unless respond_to?(:spm_dependency, true)
  raise Pod::Informative, "LyraPaymentSDK requires React Native 0.76 or newer with the spm_dependency helper. Upgrade React Native and load react_native_pods.rb before installing this module."
end

Pod::Spec.new do |s|
  s.name         = "ReactNativeSdkPaymentModule"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.homepage     = package["homepage"]
  s.license      = package["license"]
  s.authors      = package["author"]

  s.platforms    = { :ios => min_ios_version_supported }
  s.source       = { :git => "https://github.com/lyra/react-native-sdk-payment-module.git", :tag => "#{s.version}" }

  s.source_files = "ios/**/*.{h,m,mm,swift,cpp}"
  s.private_header_files = "ios/**/*.h"

  spm_dependency(s,
    url: LyraPaymentSDKSPM::URL,
    requirement: { kind: "exactVersion", version: LyraPaymentSDKSPM::VERSION },
    products: [LyraPaymentSDKSPM::PRODUCT]
  )

  install_modules_dependencies(s)
end
