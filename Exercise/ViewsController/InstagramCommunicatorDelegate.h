//
//  InstagramCommunicatorDelegate.h
//

#import <Foundation/Foundation.h>

@protocol InstagramCommunicatorDelegate
- (void)receivedMediasJSON:(NSData *)objectNotation;
- (void)fetchingMediasFailedWithError:(NSError *)error;
- (void)receivedTagsJSON:(NSData *)objectNotation;
- (void)fetchingTagsFailedWithError:(NSError *)error;
- (void)receivedLocationsJSON:(NSData *)objectNotation;
- (void)fetchingLocationsFailedWithError:(NSError *)error;

@end
