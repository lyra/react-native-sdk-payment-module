#import <React/RCTBridgeModule.h>
#import <LyraPaymentSDK/LyraPaymentSDK.h>


@interface RCT_EXTERN_MODULE(SdkPaymentModule, NSObject)

RCT_EXTERN_METHOD(initialize:(NSString*)publicKey options:(NSDictionary*)options 
                 onError:(RCTResponseSenderBlock) onError)    


+ (BOOL)requiresMainQueueSetup
{
  return NO;
}

RCT_EXPORT_METHOD(process: (NSString*) formToken options:(NSDictionary*) configurationOptions onSuccess:(RCTResponseSenderBlock) onSuccessCallback onError:(RCTResponseSenderBlock) onErrorCallback)
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"process");
        UIViewController *vc = [UIApplication sharedApplication].delegate.window.rootViewController;

        NSError *error = nil;
        [Lyra process:vc :formToken onSuccess:^(LyraResponse *lyraResponse) {
            // Convert lyraResponse to JSON and return it
            NSError *errorJSON = nil;
            NSMutableDictionary *result = [NSJSONSerialization JSONObjectWithData:lyraResponse.getResponseData options:kNilOptions error:&errorJSON];

            onSuccessCallback(@[result]);
        } onError:^(LyraError *lyraError, LyraResponse *lyraResponse) {
            // Convert lyraResponse to JSON
            // Complete with lyraError --> {err:...}
            // Return it
            NSError *errorJSON = nil;
            NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
            if (lyraResponse != nil) {
                result = [NSJSONSerialization JSONObjectWithData:lyraResponse.getResponseData options:NSJSONReadingMutableContainers error:&errorJSON];
            }

            NSMutableDictionary *dictErr = [[NSMutableDictionary alloc] init];
            if(lyraError != nil) {
                dictErr[@"detailErrorCode"] = lyraError.detailErrorCode;
                dictErr[@"detailErrorMessage"] = lyraError.detailErrorMessage;
                dictErr[@"errorCode"] = lyraError.errorCode;
                dictErr[@"errorMessage"] = lyraError.errorMessage;
                dictErr[@"technicalError"] = @"true"; //lyraError.isTechnicalError ;
            }
            [result setObject:dictErr forKey:@"error"];
            onErrorCallback(@[result]);
        } :configurationOptions error:&error];
        if (error != nil) {
            // Return {err:...}
            NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
            NSMutableDictionary *dictErr = [[NSMutableDictionary alloc] init];
            dictErr[@"errorCode"] = @"MOB_002";
            dictErr[@"errorMessage"] = @"SDK initialization is required before calling process";
            result[@"error"] = dictErr;
            onErrorCallback(@[result]);
        }
    });
}

RCT_EXPORT_BLOCKING_SYNCHRONOUS_METHOD(getFormTokenVersion) 
{
    NSString *formTokenVersion = [NSString stringWithFormat:@"%li", [Lyra getFormTokenVersion]];
    return formTokenVersion;
};



@end
