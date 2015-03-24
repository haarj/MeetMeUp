//
//  Event.h
//  MeetMeUp
//
//  Created by Justin Haar on 3/24/15.
//  Copyright (c) 2015 Justin Haar. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol EventDelegate <NSObject>

-(void)event:(NSArray *)eventsArray;

@end

@interface Event : NSObject

@property id<EventDelegate>delegate;

@property NSString *name;
@property NSString *address;
@property NSString *eventDescription;
@property NSString *attendees;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
+(NSArray *)eventArrayFromDictionaryArray:(NSArray *)dictArray;
-(void)pullEventsFromMeetupApi;


@end
