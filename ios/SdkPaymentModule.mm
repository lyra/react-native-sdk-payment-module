#import "SdkPaymentModule.h"
#import "SdkPaymentModule-Swift.h"
#import <React/RCTUtils.h>


@implementation SdkPaymentModule {
  SdkPaymentModuleImpl *moduleImpl;
}

-(instancetype) init {
  self = [super init];
  if (self) {
    moduleImpl = [SdkPaymentModuleImpl new];
  }
  
  return self;
}

RCT_EXPORT_MODULE()

- (NSNumber *) getFormTokenVersion{
  return [moduleImpl getFormTokenVersion];
}

-(void)initialize:(NSString *)publicKey options:(NSDictionary *)configurationOptions onError:(RCTResponseSenderBlock)onErrorCallback{
  [moduleImpl initialize:publicKey options: configurationOptions onError:onErrorCallback];
}

-(void)process:(NSString *)formToken options:(NSDictionary *)configurationOptions onSuccess:(RCTResponseSenderBlock)onSuccessCallback onError:(RCTResponseSenderBlock)onErrorCallback{
  UIViewController *presentedViewController = RCTPresentedViewController();
  [moduleImpl processWithViewController:presentedViewController formToken:formToken options:configurationOptions onSuccess:onSuccessCallback onError:onErrorCallback];
}

- (std::shared_ptr<facebook::react::TurboModule>)getTurboModule:
    (const facebook::react::ObjCTurboModule::InitParams &)params
{
    return std::make_shared<facebook::react::NativeSdkPaymentModuleSpecJSI>(params);
}

@end
