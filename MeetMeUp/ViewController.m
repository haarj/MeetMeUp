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

//    self.searchBar.delegate = self;

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

    cell.imageView.image = [UIImage imageNamed:@"Meetup"];

    return cell;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //SET THE DESTINATION VIEW CONTROLLER
//    DetailViewController *viewController = segue.destinationViewController;
//    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];


}

//#pragma mark Content Filtering
//
//-(void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
//{
//    [self.filteredArray removeAllObjects];
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name %@",searchText];
//    self.filteredArray = [NSMutableArray arrayWithArray:[self.results filteredArrayUsingPredicate:predicate]];
//}
//
//
//#pragma mark UISearchDisplayController Delegate Methods
//
//-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
//{
//    [self filterContentForSearchText:searchString scope:
//     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
//    // Return YES to cause the search result table view to be reloaded.
//
//    return YES;
//}
//
//
//-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
//    // Tells the table data source to reload when scope bar selection changes
//    [self filterContentForSearchText:self.searchDisplayController.searchBar.text scope:
//     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
//    // Return YES to cause the search result table view to be reloaded.
//    return YES;
//}
//



@end
