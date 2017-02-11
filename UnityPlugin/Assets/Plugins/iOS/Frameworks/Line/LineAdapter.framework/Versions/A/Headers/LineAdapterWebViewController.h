//
//  LineAdapterWebViewController.h
//  LineAdapterUI
//
//  Created by 홍석주 on 12. 10. 15..
//  Copyright (c) 2012년 NHN. All rights reserved.
//
#import <UIKit/UIKit.h>
@class LineAdapter;
typedef NS_ENUM(NSUInteger, LineAdapterWebViewOrientation) {LineAdapterWebViewOrientationPortrait, LineAdapterWebViewOrientationLandscape, LineAdapterWebViewOrientationAll,
                                                            // Deprecated
                                                            kOrientationPortrait DEPRECATED_MSG_ATTRIBUTE("use LineAdapterWebViewOrientationPortrait") NS_SWIFT_UNAVAILABLE("use LineAdapterWebViewOrientation.Portrait") =
                                                                LineAdapterWebViewOrientationPortrait,
                                                            kOrientationLandscape DEPRECATED_MSG_ATTRIBUTE("use LineAdapterWebViewOrientationLandscape") NS_SWIFT_UNAVAILABLE("use LineAdapterWebViewOrientation.Landscape") =
                                                                LineAdapterWebViewOrientationLandscape,
                                                            kOrientationAll DEPRECATED_MSG_ATTRIBUTE("use LineAdapterWebViewOrientationAll") NS_SWIFT_UNAVAILABLE("use LineAdapterWebViewOrientation.All") = LineAdapterWebViewOrientationAll};
NS_ASSUME_NONNULL_BEGIN
@interface LineAdapterWebViewController : UIViewController
@property(nonatomic, nullable) NSLocale *authorizationLocale;
- (instancetype)initWithAdapter:(LineAdapter *)aAdapter withWebViewOrientation:(LineAdapterWebViewOrientation)aWebViewOrientation;
- (NSUInteger)supportedOrientation;
- (BOOL)supportedShouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation;
@end
NS_ASSUME_NONNULL_END