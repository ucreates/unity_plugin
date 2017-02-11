//
//  LineApiClient
//  LineAdapter
//
//  Created by Ueno Kenichi on 2013/08/20.
//  Copyright (c) 2013 LINE Corporation All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/*! サーバーエラーを表します */
extern NSString *LineAdapterErrorDomain;
/*! Refresh成功時に発行されます
 * userInfo keys: mid, accessToken, refreshToken
 */
extern NSString *LineAdapterRefreshedTokenNotification;
/*! Auth Token失効時に発行されます。
 * userInfo keys:
 */
extern NSString *LineAdapterNoLongerAuthorizedNotification;
extern NSString *LineAdapterErrorStatusCode;
extern NSString *LineAdapterErrorStatusMessage;
typedef void (^LineApiClientResultBlock)(NSDictionary *aResult, NSError *aError);
NS_ENUM(NSInteger) {LineAdapterErrorNone,                      LineAdapterErrorMissingConfiguration, LineAdapterErrorAuthorizationAgentNotAvailable, LineAdapterErrorInternalInconsistency,
                    LineAdapterErrorInvalidServerResponse,     LineAdapterErrorAuthorizationDenied,  LineAdapterErrorAuthorizationFailed,            LineAdapterErrorAuthorizationExpired,
                    LineAdapterErrorAccessTokenIsNotAvailable, LineAdapterErrorNoLongerRefreshToken, LineAdapterErrorUnknownError, };
@interface LineApiClient : NSObject
@property(nonatomic, strong) NSString *accessToken;
@property(nonatomic, strong) NSString *refreshToken;
@property(nonatomic, strong) NSDate *expiresDate;
@property(nonatomic, strong) NSString *channelGatewayBaseURL;
@property(nonatomic, assign) NSTimeInterval timeoutInterval;
// login/logout
- (void)getOTPForChanneID:(NSString *)aChannelID resultBlock:(LineApiClientResultBlock)aResultBlock;
- (void)getAccessTokenForChannelID:(NSString *)aChannelID withRequestToken:(NSString *)aRequestToken andOTP:(NSString *)aOTP resultBlock:(LineApiClientResultBlock)aResultBlock;
- (void)refreshWithResultBlock:(LineApiClientResultBlock)aResultBlock;
// API
- (void)getMyProfileWithResultBlock:(LineApiClientResultBlock)aResultBlock;
- (void)getMyFriendsForRange:(NSRange)aRange resultBlock:(LineApiClientResultBlock)aResultBlock;
- (void)getMyFavoriteFriendsForRange:(NSRange)aRange resultBlock:(LineApiClientResultBlock)aResultBlock;
- (void)getProfiles:(NSArray *)aMidArray resultBlock:(LineApiClientResultBlock)aResultBlock;
- (void)getSameChannelFriendsForRange:(NSRange)aRange resultBlock:(LineApiClientResultBlock)aResultBlock;
- (void)uploadProfileImage:(UIImage *)aImage lowQuality:(BOOL)aLowQuality resultBlock:(LineApiClientResultBlock)aResultBlock;
- (void)postEventTo:(NSArray *)aMidArray toChannel:(NSString *)aChannelId eventType:(NSString *)aEventType content:(NSDictionary *)aContent push:(NSDictionary *)aPush resultBlock:(LineApiClientResultBlock)aResultBlock;
- (void)getGroupsForRange:(NSRange)aRange resultBlock:(LineApiClientResultBlock)aResultBlock;
- (void)getGroupMembers:(NSString *)aGroupMid forRange:(NSRange)aRange resultBlock:(LineApiClientResultBlock)aResultBlock;
@end
#pragma mark - Depreated
NS_ENUM(NSInteger) {
    kLineAdapterErrorNone DEPRECATED_MSG_ATTRIBUTE("use LineAdapterErrorNone") NS_SWIFT_UNAVAILABLE("use LineAdapterErrorNone") = LineAdapterErrorNone,
    kLineAdapterErrorMissingConfiguration DEPRECATED_MSG_ATTRIBUTE("use LineAdapterErrorMissingConfiguration") NS_SWIFT_UNAVAILABLE("use LineAdapterErrorMissingConfiguration") = LineAdapterErrorMissingConfiguration,
    kLineAdapterErrorAuthorizationAgentNotAvailable DEPRECATED_MSG_ATTRIBUTE("use LineAdapterErrorAuthorizationAgentNotAvailable") NS_SWIFT_UNAVAILABLE("use LineAdapterErrorAuthorizationAgentNotAvailable") =
        LineAdapterErrorAuthorizationAgentNotAvailable,
    kLineAdapterErrorInternalInconsistency DEPRECATED_MSG_ATTRIBUTE("use LineAdapterErrorInternalInconsistency") NS_SWIFT_UNAVAILABLE("use LineAdapterErrorInternalInconsistency") = LineAdapterErrorInternalInconsistency,
    kLineAdapterErrorInvalidServerResponse DEPRECATED_MSG_ATTRIBUTE("use LineAdapterErrorInvalidServerResponse") NS_SWIFT_UNAVAILABLE("use LineAdapterErrorInvalidServerResponse") = LineAdapterErrorInvalidServerResponse,
    kLineAdapterErrorAuthorizationDenied DEPRECATED_MSG_ATTRIBUTE("use LineAdapterErrorAuthorizationDenied") NS_SWIFT_UNAVAILABLE("use LineAdapterErrorAuthorizationDenied") = LineAdapterErrorAuthorizationDenied,
    kLineAdapterErrorAuthorizationFailed DEPRECATED_MSG_ATTRIBUTE("use LineAdapterErrorAuthorizationFailed") NS_SWIFT_UNAVAILABLE("use LineAdapterErrorAuthorizationFailed") = LineAdapterErrorAuthorizationFailed,
    kLineAdapterErrorAuthorizationExpired DEPRECATED_MSG_ATTRIBUTE("use LineAdapterErrorAuthorizationExpired") NS_SWIFT_UNAVAILABLE("use LineAdapterErrorAuthorizationExpired") = LineAdapterErrorAuthorizationExpired,
    kLineAdapterErrorAccessTokenIsNotAvailable DEPRECATED_MSG_ATTRIBUTE("use LineAdapterErrorAccessTokenIsNotAvailable") NS_SWIFT_UNAVAILABLE("use LineAdapterErrorAccessTokenIsNotAvailable") = LineAdapterErrorAccessTokenIsNotAvailable,
    kLineAdapterErrorNoLongerRefreshToken DEPRECATED_MSG_ATTRIBUTE("use LineAdapterErrorNoLongerRefreshToken") NS_SWIFT_UNAVAILABLE("use LineAdapterErrorNoLongerRefreshToken") = LineAdapterErrorNoLongerRefreshToken,
    kLineAdapterErrorUnknownError DEPRECATED_MSG_ATTRIBUTE("use LineAdapterErrorUnknownError") NS_SWIFT_UNAVAILABLE("use LineAdapterErrorUnknownError") = LineAdapterErrorUnknownError};
