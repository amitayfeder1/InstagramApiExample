//
//  InstagramCommunicator.h
//

#ifndef InstagramCommunicator_h
#define InstagramCommunicator_h

#import <CoreLocation/CoreLocation.h>
@protocol InstagramCommunicatorDelegate;

@interface InstagramCommunicator : NSObject<NSURLSessionDelegate>
{
}
@property (weak, nonatomic) id<InstagramCommunicatorDelegate> delegate;
@property (strong, nonatomic) NSString* access_token;
-(void) searchAndHandleTags:(NSString*)searchText;
-(void) searchAndHandleLocations:(CLLocationCoordinate2D)coordinate;
-(void) searchRecentUserMedia;
-(void) searchMediaFromTag:(NSString*)searchTag;
-(void) searchMediaByLocationId:(NSString*)locationId;
-(void) likeOrUnlikeMedia:(NSString*)mediaId andLike:(BOOL)like;
@end

#endif /* InstagramCommunicator_h */
