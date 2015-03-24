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

@property (weak, nonatomic) IBOutlet UIScrollView *descriptionView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *rsvpLabel;
@property (weak, nonatomic) IBOutlet UILabel *hostingGroupLabel;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.textView.text = self.selectedEvent.eventDescription;
    self.rsvpLabel.text = self.selectedEvent.attendees;
//    self.hostingGroupLabel.text = self.hostingGroup;
}




-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UIButton *)sender
{
    WebpageViewController *viewController = segue.destinationViewController;
//    viewController.webURL = self.webURL;
}

@end
