import Foundation
import LyraPaymentSDK
import React

@objc public class LyraSdkPayment: NSObject {
  @objc public func getFormTokenVersion() -> NSNumber {
    return Lyra.getFormTokenVersion() as NSNumber
  }

  @objc public func initialize(_ publicKey: String, options: [String: Any], resolver resolve: @escaping RCTPromiseResolveBlock, rejecter reject: @escaping RCTPromiseRejectBlock) {
    do {
      try Lyra.initialize(publicKey, options)
      resolve([])
    } catch {
      if let error = error as? LyraError {
        reject(error.errorCode, error.errorMessage, error)
      } else {
        reject("ERR_001", "Initialize error", error)
      }
    }
  }

  @objc public func process(viewController: UIViewController, formToken: String, options: [String: Any], resolver resolve: @escaping RCTPromiseResolveBlock, rejecter reject: @escaping RCTPromiseRejectBlock) {
    do {
      try Lyra.process(viewController, formToken,
                       onSuccess: { (_ lyraResponse: LyraResponse) in
                         let result: [String: Any] = ["result":
                           ["responseData": lyraResponse.getResponseData()]]
                         resolve([result])
                       },
                       onError: { (_ error: LyraError, _: LyraResponse?) in
                         reject(error.errorCode, error.errorMessage, error)
                       },
                       options)
    } catch {
      reject("ERR_002", "Process error", error)
    }
  }
}
