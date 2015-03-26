//
//  detailViewController.m
//  MeetMeUp
//
//  Created by Justin Haar on 3/23/15.
//  Copyright (c) 2015 Justin Haar. All rights reserved.
//

#import "DetailViewController.h"
#import "WebpageViewController.h"
#import "CommentsViewController.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *rsvpLabel;
@property (weak, nonatomic) IBOutlet UILabel *hostingGroupLabel;

@end

@implementation DetailViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    self.textView.text = self.selectedEvent.eventDescription;
    self.rsvpLabel.text = self.selectedEvent.attendees;
    self.title = self.selectedEvent.name;
    self.hostingGroupLabel.text = self.selectedEvent.hostingGroup;
    NSLog(@"%@, %@", self.rsvpLabel, self.hostingGroupLabel);
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqual:@"webpage"]) {
        WebpageViewController *viewController = segue.destinationViewController;
        viewController.selectedEvent = self.selectedEvent;
    }
}

@end
