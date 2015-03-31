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

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic)  NSArray *results;
@property (nonatomic) NSMutableArray *filteredArray;
@property BOOL isFiltered;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation ViewController
- (void)viewDidLoad
{
    [super viewDidLoad];

    [Event eventArrayFromDictionaryArray:^(NSArray *events) {
        self.results = events;
        self.filteredArray = [self.results mutableCopy];
        //reloaded tableview in settermethod
    }];
}

-(void)setFilteredArray:(NSMutableArray *)filteredArray
{
    _filteredArray = filteredArray;
    [self.tableView reloadData];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.filteredArray.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    Event *event = [self.filteredArray objectAtIndex:indexPath.row];

    cell.textLabel.text = event.name;
    cell.detailTextLabel.text = event.time;
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
    if (searchText.length == 0)
    {
        //mutable copy gives us a mutable copy of the filtered array
        self.filteredArray = [self.results mutableCopy];
    }else
    {
        [self.filteredArray removeAllObjects];
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
