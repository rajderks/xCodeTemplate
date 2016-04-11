//
//  Mapping.m
//  IkHerstel
//
//  Created by Bob de Graaf on 15-04-15.
//  Copyright (c) 2015 GraafICT. All rights reserved.
//

#import "NSManagedObject+Mapping.h"

@implementation NSManagedObject (Mapping)

-(void)safeSetValuesForKeysWithDictionary:(NSDictionary *)keyedValues dateFormatter:(NSDateFormatter *)dateFormatter context:(NSManagedObjectContext *)context
{
    NSDictionary *attributes = [[self entity] attributesByName];
    for(NSString *attribute in attributes) {
        id value = [keyedValues objectForKey:attribute];
        if(value == nil) {
            continue;
        }
        if(value == [NSNull null]) {
            continue;
        }
        
        NSAttributeType attributeType = [[attributes objectForKey:attribute] attributeType];
        if ((attributeType == NSStringAttributeType) && ([value isKindOfClass:[NSNumber class]])) {
            value = [value stringValue];
        } else if (((attributeType == NSInteger16AttributeType) || (attributeType == NSInteger32AttributeType) || (attributeType == NSInteger64AttributeType) || (attributeType == NSBooleanAttributeType)) && ([value isKindOfClass:[NSString class]])) {
            value = [NSNumber numberWithInteger:[value integerValue]];
        } else if ((attributeType == NSFloatAttributeType) &&  ([value isKindOfClass:[NSString class]])) {
            value = [NSNumber numberWithDouble:[value doubleValue]];
        } else if ((attributeType == NSDateAttributeType) && ([value isKindOfClass:[NSString class]]) && (dateFormatter != nil)) {
            value = [dateFormatter dateFromString:value];
        }
        [self setValue:value forKey:attribute];
    }
    
    NSDictionary *relationships = [[self entity] relationshipsByName];
    for(NSString *relationship in relationships) {
        id value = [keyedValues objectForKey:relationship];
        if(![value isKindOfClass:[NSDictionary class]]) {
            continue;
        }
        if(value == nil) {
            continue;
        }
        if(value == [NSNull null]) {
            continue;
        }
        
        //If the relationship does not exist, create the object and add the relation
        NSManagedObject *relationshipObject = (NSManagedObject *)[self valueForKey:relationship];
        if(!relationshipObject) {
            NSString *relationShipClassName = [relationship capitalizedString];
            relationshipObject = [NSEntityDescription insertNewObjectForEntityForName:relationShipClassName inManagedObjectContext:context];
            [self setValue:relationshipObject forKey:relationship];
        }
        
        //Update values
        [relationshipObject safeSetValuesForKeysWithDictionary:value dateFormatter:dateFormatter context:context];
    }
}

-(void)safeSetValuesForKeysWithDictionary:(NSDictionary *)keyedValues dateFormatter:(NSDateFormatter *)dateFormatter
{
    [self safeSetValuesForKeysWithDictionary:keyedValues dateFormatter:dateFormatter context:nil];
}

-(void)safeSetValuesForKeysWithDictionary:(NSDictionary *)keyedValues context:(NSManagedObjectContext *)context
{
    [self safeSetValuesForKeysWithDictionary:keyedValues dateFormatter:nil context:context];
}

-(void)safeSetValuesForKeysWithDictionary:(NSDictionary *)keyedValues
{
    [self safeSetValuesForKeysWithDictionary:keyedValues dateFormatter:nil];
}

@end
