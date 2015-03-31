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
    //if(self) is designed to reenforce the above initialization.
    if (self)
    {
        self.name = [dictionary objectForKey:@"name"];
        self.attendees = [[dictionary objectForKey:@"yes_rsvp_count"] stringValue];
        self.address = [[dictionary objectForKey:@"venue"] objectForKey:@"address_1"];
        self.hostingGroup = [[dictionary objectForKey:@"group"] objectForKey:@"name"];
        self.eventDescription = [dictionary objectForKey:@"description"];
        self.webURL = [dictionary objectForKey:@"event_url"];
        self.timeSince1970 =[dictionary objectForKey:@"time"];
        
    }
    return self;
}


-(NSString *)time
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"MM/dd/yy HH:mm";
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:self.timeSince1970.doubleValue/1000];
    return [formatter stringFromDate:date];
}

+(void)eventArrayFromDictionaryArray:(void (^)(NSArray *))complete
{
    NSURL *url = [NSURL URLWithString:@"https://api.meetup.com/2/open_events.json?zip=94104&text=mobile&time=,1w&key=477d1928246a4e162252547b766d3c6d"];
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:url] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
    {
        NSDictionary *meetUpDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSMutableArray *meetUps = meetUpDict[@"results"];
        NSMutableArray *muteArray = [[NSMutableArray alloc]initWithCapacity:meetUps.count];
        for (NSDictionary *dict in meetUps)
        {
            [muteArray addObject:[[Event alloc]initWithDictionary:dict]];
        }
        complete(muteArray);
    }];
}

@end