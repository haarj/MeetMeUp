//
//  Event.h
//  MeetMeUp
//
//  Created by Justin Haar on 3/24/15.
//  Copyright (c) 2015 Justin Haar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Event : NSObject

@property NSString *name;
@property NSString *address;
@property NSString *eventDescription;
@property NSString *attendees;
@property NSString *hostingGroup;
@property NSString *webURL;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
+(void)eventArrayFromDictionaryArray:(void(^)(NSArray *))complete;

@end
