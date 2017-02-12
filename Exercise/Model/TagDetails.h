//
//  TagDetails.h
//

#ifndef TagDetails_h
#define TagDetails_h

@interface TagDetails : NSObject

@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSNumber* media_count;

-(BOOL) isValid;

@end

#endif /* TagDetails_h */
