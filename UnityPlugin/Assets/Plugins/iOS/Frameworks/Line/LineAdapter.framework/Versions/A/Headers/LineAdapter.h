/*
 *  LineAdapter.h
 *  LineAdapter
 *
 *  Created by han9kin on 2012-04-02.
 *  Copyright (c) 2012 NHN. All rights reserved.
 *
 */
#import <Foundation/Foundation.h>
@class LineApiClient;
extern NSString *const LineAdapterOtpIsReadyNotification;
extern NSString *const LineAdapterAuthorizationDidChangeNotification;
extern NSString *const kLineAdapterVersion;
typedef NS_ENUM(NSUInteger, LineAdapterPhase) {LineAdapterPhaseBeta,
                                               LineAdapterPhaseRC,
                                               LineAdapterPhaseReal,
                                               // Deprecated
                                               kLineBeta DEPRECATED_MSG_ATTRIBUTE("use LineAdapterPhaseBeta") NS_SWIFT_UNAVAILABLE("use LineAdapterPhase.Beta") = LineAdapterPhaseBeta,
                                               kLineRC DEPRECATED_MSG_ATTRIBUTE("use LineAdapterPhaseRC") NS_SWIFT_UNAVAILABLE("use LineAdapterPhase.RC") = LineAdapterPhaseRC,
                                               kLineReal DEPRECATED_MSG_ATTRIBUTE("use LineAdapterPhaseReal") NS_SWIFT_UNAVAILABLE("use LineAdapterPhase.Real") = LineAdapterPhaseReal};
@interface LineAdapter : NSObject
@property(nonatomic, readonly) BOOL canAuthorizeUsingLineApp;
@property(nonatomic, readonly, copy) NSString *channelID;
@property(nonatomic, readonly, copy) NSString *MID;
@property(nonatomic, readonly, getter=isAuthorizing) BOOL authorizing;
@property(nonatomic, readonly, getter=isAuthorized) BOOL authorized;
+ (instancetype)defaultAdapter;
+ (instancetype)adapterWithConfigFile NS_SWIFT_UNAVAILABLE("Use +defaultAdapter class method")DEPRECATED_MSG_ATTRIBUTE("Use +defaultAdapter class method");
- (instancetype)initWithConfigFile NS_SWIFT_UNAVAILABLE("Use +defaultAdapter class method")DEPRECATED_MSG_ATTRIBUTE("Use +defaultAdapter class method");
- (instancetype)init NS_UNAVAILABLE;
// A2A認証 ユーザーの操作結果が返ってきたときに実行されるべきメソッドです
+ (BOOL)handleLaunchOptions:(NSDictionary *)aLaunchOptions;
+ (BOOL)handleOpenURL:(NSURL *)aURL;
- (void)installLineApp;
- (void)setPhase:(LineAdapterPhase)aPhase;
- (void)authorize;     // for login
- (void)unauthorize;   // for logout
- (void)authorizeWeb;  // for login
- (void)clearLocalLoginInfo;
- (BOOL)handleLaunchOptions:(NSDictionary *)aLaunchOptions;
- (BOOL)handleOpenURL:(NSURL *)aURL;
- (LineApiClient *)getLineApiClient;
@end
