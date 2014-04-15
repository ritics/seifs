//
//  BNMToDoItem.m
//  ToDoList
//
//  Created by Reinis Lācis on 13/04/14.
//  Copyright (c) 2014 Brand Name. All rights reserved.
//

#import "BNMToDoItem.h"

@implementation BNMToDoItem



- (NSArray *)keysForEncoding;
{
    return [NSArray arrayWithObjects:@"itemName", @"completed", @"creationDate", @"identifier", nil];
}



- (id)initWithName:(NSString *)itemName completed:(BOOL)completed creationDate:(NSDate *)creationDate
{
    self = [super init];
    if (self)
    {
        self.itemName = itemName;
        self.completed = completed;
        self.creationDate = creationDate;
        
        // create a unique identifier for this object, helps with state restoration
        NSUUID *uuid = [[NSUUID alloc] init];
        self.identifier = [uuid UUIDString];
    }
    return self;
}



// we are being created based on what was archived earlier
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self)
    {
        for (NSString *key in self.keysForEncoding)
        {
            [self setValue:[aDecoder decodeObjectForKey:key] forKey:key];
        }
    }
    return self;
}



// we are asked to be archived, encode all our data
- (void)encodeWithCoder:(NSCoder *)aCoder
{
	for (NSString *key in self.keysForEncoding)
    {
        [aCoder encodeObject:[self valueForKey:key] forKey:key];
    }
}



@end
