import Foundation
import LyraPaymentSDK

@objc public class SdkPaymentModuleImpl: NSObject {
  @objc public func getFormTokenVersion() -> NSNumber {
    return Lyra.getFormTokenVersion() as NSNumber
  }

  @objc public func initialize(_ publicKey: String, options: [String: Any], onError: (_ error: Any) -> Void) {
    do {
      try Lyra.initialize(publicKey, options)
    } catch {
      var result: [String: Any] = [:]
      var dictErr: [String: Any] = [:]
      if let error = error as? LyraError {
        dictErr["errorCode"] = error.errorCode
        dictErr["errorMessage"] = error.errorMessage
        dictErr["detailErrorCode"] = error.detailErrorCode
        dictErr["detailErrorMessage"] = error.detailErrorMessage
        result["error"] = dictErr
      } else {
        dictErr["errorCode"] = error
        result["error"] = dictErr
      }
      onError([result])
    }
  }

  @objc public func process(viewController: UIViewController, formToken: String, options: [String: Any], onSuccess onSuccessCallback: @escaping (_ result: Any) -> Void, onError onErrorCallback: @escaping (_ error: Any) -> Void) {
    do {
      try Lyra.process(viewController, formToken,
                       onSuccess: { (_ lyraResponse: LyraResponse) in
                         let result: [String: Any] = ["result":
                           ["responseData": lyraResponse.getResponseData()]]

                         onSuccessCallback([result])
                       },
                       onError: { (_ error: LyraError, _: LyraResponse?) in
                         let err: [String: Any] = ["error": [
                           "errorCode": error.errorCode,
                           "errorMessage": error.errorMessage,
                           "detailErrorCode": error.detailErrorCode,
                           "detailErrorMessage": error.detailErrorMessage

                         ]]
                         onErrorCallback([err])
                       },
                       options)
    } catch {
      let result: [String: Any] = ["error": ["errorCode": error]]

      onErrorCallback([result])
    }
  }
}
