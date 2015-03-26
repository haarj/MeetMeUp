//
//  ViewController.m
//  MeetMeUp
//
//  Created by Justin Haar on 3/23/15.
//  Copyright (c) 2015 Justin Haar. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"
#import "WebpageViewController.h"
#import "Event.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchDisplayDelegate, EventDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property NSArray *results;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    Event *apiCallEvent = [[Event alloc]init];
    apiCallEvent.delegate = self;
    [apiCallEvent pullEventsFromMeetupApi];
}

-(void)event:(NSArray *)eventsArray
{
    self.results = eventsArray;
    [self.tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.results.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    Event *event = [self.results objectAtIndex:indexPath.row];
    cell.textLabel.text = event.name;
    cell.detailTextLabel.text = event.address;

    cell.imageView.image = [UIImage imageNamed:@"Meetup"];

    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DetailViewController *viewController= segue.destinationViewController;
    //ask tableview for index path for cell.

    NSIndexPath *path = [self.tableView indexPathForCell:(UITableViewCell *)sender];
    Event *event = [self.results objectAtIndex:path.row];
    viewController.selectedEvent = event;
}

@end
