//
//  InstagramParser.m
//
#import "InstagramParser.h"
#import "MediaDetails.h"
#import "TagDetails.h"
#import "LocationDetails.h"

@implementation InstagramParser
+ (NSArray *)mediaFromJSON:(NSData *)objectNotation error:(NSError **)error
{
    NSError *localError = nil;
    NSLog(@"Data: %@", [[NSString alloc] initWithData:objectNotation encoding: NSUTF8StringEncoding]);
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:objectNotation options:0 error:&localError];
    
    if (localError != nil) {
        *error = localError;
        return nil;
    }
    
    NSMutableArray *medias = [[NSMutableArray alloc] init];
    
    NSArray *results = [parsedObject valueForKey:@"data"];
    NSLog(@"Media Count %lu", (unsigned long)results.count);
    
    for (NSDictionary *groupDic in results) {
        MediaDetails *media = [[MediaDetails alloc] init];
        @try {
            for (NSString *key in groupDic) {
                if ([media respondsToSelector:NSSelectorFromString(key)]) {
                    [media setValue:[groupDic valueForKey:key] forKey:key];
                }
            }
            NSString *identifier = [groupDic objectForKey:MEDIA_ID];
            if (identifier)
            {
                [media setMediaId:identifier];
            }
            if ([media isValid])
            {
                [medias addObject:media];     
            }
           
        } @catch (NSException *exception) {
            NSLog(@"Exception In Parsing XML %@",exception);
        } @finally {
        }
    }
    
    return medias;
}

+ (NSArray *)tagFromJSON:(NSData *) objectNotation error:(NSError **)error
{
    NSError *localError = nil;
    NSLog(@"Data: %@", [[NSString alloc] initWithData:objectNotation encoding: NSUTF8StringEncoding]);
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:objectNotation options:0 error:&localError];
    
    if (localError != nil) {
        *error = localError;
        return nil;
    }
    
    NSMutableArray *tags = [[NSMutableArray alloc] init];
    
    NSArray *results = [parsedObject valueForKey:@"data"];
    NSLog(@"Tag Count %lu", (unsigned long)results.count);
    
    for (NSDictionary *groupDic in results) {
        TagDetails *tag = [[TagDetails alloc] init];
        @try {
            for (NSString *key in groupDic) {
                if ([tag respondsToSelector:NSSelectorFromString(key)]) {
                    [tag setValue:[groupDic valueForKey:key] forKey:key];
                }
            }
            if ([tag isValid])
            {
                [tags addObject:tag];
            }
            
        } @catch (NSException *exception) {
            NSLog(@"Exception In Parsing XML %@",exception);
        } @finally {
        }
    }
    return tags;
}

+ (NSArray *)locationsFromJSON:(NSData *)objectNotation error:(NSError **)error{
    NSError *localError = nil;
    NSLog(@"Data: %@", [[NSString alloc] initWithData:objectNotation encoding: NSUTF8StringEncoding]);
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:objectNotation options:0 error:&localError];
    
    if (localError != nil) {
        *error = localError;
        return nil;
    }
    
    NSMutableArray *locs = [[NSMutableArray alloc] init];
    
    NSArray *results = [parsedObject valueForKey:@"data"];
    NSLog(@"Locations Count %lu", (unsigned long)results.count);
    
    for (NSDictionary *groupDic in results) {
          LocationDetails *loc = [[LocationDetails alloc] init];
        @try {
            for (NSString *key in groupDic) {
                if ([loc respondsToSelector:NSSelectorFromString(key)]) {
                    [loc setValue:[groupDic valueForKey:key] forKey:key];
                }
            }
            NSString *identifier = [groupDic objectForKey:LOCATION_ID];
            if (identifier)
            {
                [loc setIdentifier:identifier];
            }
            if ([loc isValid])
            {
                [locs addObject:loc];
            }
        } @catch (NSException *exception) {
            NSLog(@"Exception In Parsing XML %@",exception);
        } @finally {
        }
    }
    return locs;
}

@end
