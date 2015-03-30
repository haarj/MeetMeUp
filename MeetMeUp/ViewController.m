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

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, EventDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property NSArray *results;
@property NSMutableArray *filteredArray;
@property BOOL *isFiltered;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

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
    if (self.isFiltered) {
        return self.filteredArray.count;
    }else
    {
    return self.results.count;
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    Event *event = [Event new];
    if (self.isFiltered)
    {
        event = [self.filteredArray objectAtIndex:indexPath.row];
    }else
    {
        event = [self.results objectAtIndex:indexPath.row];
    }
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

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (self.searchBar.text.length == 0)
    {
        self.isFiltered = NO;
    }else
    {
        self.isFiltered = YES;
        self.filteredArray = [NSMutableArray new];
        for (Event *event in self.results)
        {
            NSRange nameRange = [event.name rangeOfString:self.searchBar.text options:NSCaseInsensitiveSearch];
            if (nameRange.location != NSNotFound)
            {
                [self.filteredArray addObject:event];
            }
        }
    }
    [self.tableView reloadData];
}














@end
