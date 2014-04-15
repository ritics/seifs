//
//  BNMToDoItem.h
//  ToDoList
//
//  Created by Reinis Lācis on 13/04/14.
//  Copyright (c) 2014 Brand Name. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNMToDoItem : NSObject

@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, strong) NSString *itemName;
@property BOOL completed;
@property (nonatomic, strong) NSDate *creationDate;

- (id)initWithName:(NSString *)itemName completed:(BOOL)completed creationDate:(NSDate *)creationDate;

@end
