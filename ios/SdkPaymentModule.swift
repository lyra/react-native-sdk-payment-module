@objc(SdkPaymentModule)
class SdkPaymentModule: NSObject {

  @objc(initialize:options:onError:)
    func initialize(_ publicKey: String, options: [String : Any], onError: RCTResponseSenderBlock) -> Void {
        do {
          try Lyra.initialize(publicKey, options)
        } catch {
            var result: [String : Any] = [:]
            var dictErr: [String : Any] = [:]
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
}
