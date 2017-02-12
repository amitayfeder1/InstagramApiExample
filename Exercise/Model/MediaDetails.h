//
//  MediaDetails.h
//

#ifndef MediaDetails_h
#define MediaDetails_h
#define MEDIA_ID @"id"

@interface MediaDetails : NSObject
@property (strong, nonatomic) NSDictionary *user;
@property (nonatomic) NSTimeInterval created_time;
@property (strong, nonatomic) NSString *link;
@property (strong, nonatomic) NSDictionary* images;
@property (strong, nonatomic) NSDictionary *likes;
@property (nonatomic) BOOL user_has_liked;
@property (strong, nonatomic) NSString* mediaId;

-(NSString*) getUserName;
-(NSNumber*) getLikes;
-(NSString*) getLowResUrl;
-(NSString*) getStandardResUrl;
-(BOOL) isValid;
@end

#endif /* MediaDetails_h */
