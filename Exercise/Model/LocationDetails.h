//
//  LocationDetails.h
//

#ifndef LocationDetails_h
#define LocationDetails_h

#define LOCATION_ID @"id"
#define LOCATION_NAME @"name"

@interface LocationDetails : NSObject

@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* identifier;

-(BOOL) isValid;

@end

#endif /* LocationDetails_h */
