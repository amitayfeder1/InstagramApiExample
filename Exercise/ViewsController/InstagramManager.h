//
//  InstagramManager.h
//

#ifndef InstagramManager_h
#define InstagramManager_h

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#import "InstagramManagerDelegate.h"
#import "InstagramCommunicatorDelegate.h"
@class InstagramCommunicator;

@interface InstagramManager : NSObject<InstagramCommunicatorDelegate>{
}
@property (strong, nonatomic) InstagramCommunicator *communicator;
@property (weak, nonatomic) id<InstagramManagerDelegate> delegate;

-(void) fetchRecentUserMedia;
-(void) fetchMediaFromTag:(NSString*)searchTag;
-(void) fetchMediaByLocation:(CLLocationCoordinate2D)coordinate;
-(void) likeOrUnlikeMedia:(NSString*)mediaId andLike:(BOOL)like;
@end

#endif /* InstagramManager_h */
