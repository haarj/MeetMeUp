//
//  Event.m
//  MeetMeUp
//
//  Created by Justin Haar on 3/24/15.
//  Copyright (c) 2015 Justin Haar. All rights reserved.
//

#import "Event.h"

@implementation Event

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    self.name = [dictionary objectForKey:@"name"];
    self.attendees = [[dictionary objectForKey:@"yes_rsvp_count"] stringValue];
    self.address = [[dictionary objectForKey:@"venue"] objectForKey:@"address_1"];
    self.hostingGroup = [[dictionary objectForKey:@"group"] objectForKey:@"name"];
    self.eventDescription = [dictionary objectForKey:@"description"];
    self.webURL = [dictionary objectForKey:@"event_url"];

    return self;
}

+(NSArray *)eventArrayFromDictionaryArray:(NSArray *)dictArray
{
    NSMutableArray *muteArray = [NSMutableArray new];
    for (NSDictionary *dict in dictArray) {
        Event *event = [[Event alloc]initWithDictionary:dict];
        [muteArray addObject:event];
    }
    return [NSArray arrayWithArray:muteArray];
}

-(void)pullEventsFromMeetupApi
{
    NSURL *url = [NSURL URLWithString:@"https://api.meetup.com/2/open_events.json?zip=94104&text=mobile&time=,1w&key=477d1928246a4e162252547b766d3c6d"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {

        NSDictionary *meetUps = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];

        NSArray *results = [Event eventArrayFromDictionaryArray:meetUps[@"results"]];
        [self.delegate event:results];
    }];
}


@end
