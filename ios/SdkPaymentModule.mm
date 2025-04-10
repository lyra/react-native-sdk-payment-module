#import "SdkPaymentModule.h"
#import "SdkPaymentModule-Swift.h"
#import <React/RCTUtils.h>


@implementation SdkPaymentModule {
  LyraSdkPayment *lyraSdkPayment;
}

-(instancetype) init {
  self = [super init];
  if (self) {
    lyraSdkPayment = [LyraSdkPayment new];
  }
  
  return self;
}

RCT_EXPORT_MODULE()

- (NSNumber *) getFormTokenVersion{
  return [lyraSdkPayment getFormTokenVersion];
}

- (void)initialize:(nonnull NSString *)publicKey options:(nonnull NSDictionary *)configurationOptions resolve:(nonnull RCTPromiseResolveBlock)resolve reject:(nonnull RCTPromiseRejectBlock)reject {
  [lyraSdkPayment initialize:publicKey options:configurationOptions resolver:resolve rejecter:reject];
}

- (void)process:(nonnull NSString *)formToken options:(nonnull NSDictionary *)configurationOptions resolve:(nonnull RCTPromiseResolveBlock)resolve reject:(nonnull RCTPromiseRejectBlock)reject {
  UIViewController *presentedViewController = RCTPresentedViewController();
  [lyraSdkPayment processWithViewController:presentedViewController formToken:formToken options:configurationOptions resolver:resolve rejecter:reject];
}

- (std::shared_ptr<facebook::react::TurboModule>)getTurboModule:
    (const facebook::react::ObjCTurboModule::InitParams &)params
{
    return std::make_shared<facebook::react::NativeSdkPaymentModuleSpecJSI>(params);
}

@end
