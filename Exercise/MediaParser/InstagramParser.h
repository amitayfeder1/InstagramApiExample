//
//  InstagramParser.h
//

#ifndef InstagramParser_h
#define InstagramParser_h

#import <Foundation/Foundation.h>

@interface InstagramParser : NSObject

+ (NSArray *)mediaFromJSON:(NSData *)objectNotation error:(NSError **)error;

+ (NSArray *)tagFromJSON:(NSData *)objectNotation error:(NSError **)error;

+ (NSArray *)locationsFromJSON:(NSData *)objectNotation error:(NSError **)error;

@end

#endif /* InstagramParser_h */
