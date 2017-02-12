//
//  InstagramManagerDelegate.h
//

#import <Foundation/Foundation.h>

@protocol InstagramManagerDelegate
- (void)didReceiveMedias:(NSArray *)medias;
- (void)fetchingMediasFailedWithError:(NSError *)error;
@end
