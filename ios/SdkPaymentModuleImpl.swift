import Foundation

@objc public class SdkPaymentModuleImpl: NSObject {
  @objc public func getFormTokenVersion() -> NSNumber {
    return 11.0
  }

  @objc public func initialize(_ publicKey: String, options: [String: Any], onError: () -> Void) {
    onError()
  }

  @objc public func process(formToken: String, options: [String: Any], onSuccess: () -> Void, onError: () -> Void) {
    onSuccess()
  }
}
