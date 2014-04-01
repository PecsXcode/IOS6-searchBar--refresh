//
//  ViewController.m
//  IOS6
//
//  Created by Klacsó Péter on 2/13/13.
//  Copyright (c) 2013 Klacsó Péter. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
@private
    NSMutableArray *adat;
    NSArray *searchedData;//kereső
    BOOL isFilter;//kereső
}
@end

@implementation ViewController
@synthesize kereso;//hozzáadva

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.Title = @"IOS 6";
    
    //kereső eltüntetése
    CGRect newBounds = self.tableView.bounds;
    newBounds.origin.y = newBounds.origin.y + kereso.bounds.size.height;
    self.tableView.bounds = newBounds;
    //
    [self refresh];//refresh meghivása mivel ott van megadva a lista
    
    // IOS6 refresh rész
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.tintColor = [UIColor redColor];
    [refreshControl addTarget:self action:@selector(refreshing:) forControlEvents:UIControlEventValueChanged];
    [self setRefreshControl:refreshControl];
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    self.tableView.delegate = self;
    //self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.backgroundColor = [UIColor colorWithRed:1.000 green:0.743 blue:0.005 alpha:1.000];
}
-(UIColor*)cellszinezes:(NSInteger) index {
    NSUInteger itemCount = adat.count - 1;
    float val = ((float)index / (float)itemCount) * 0.6;
    return [UIColor colorWithRed: 1.0 green:val blue: 0.0 alpha:1.0];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0f;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = [self cellszinezes:indexPath.row];
}
-(void)refresh
{
    adat = [NSMutableArray arrayWithObjects:@"Első",@"első",@"Második",@"második",@"Harmadik",@"harmadik",@"Negyedik",@"negyedik",nil];
    
    [self.tableView reloadData];
}
//proba szöveg
-(void)refreshing:(UIRefreshControl*)refreshControl{
    
    [self refresh];
    [self.tableView reloadData];
    [refreshControl endRefreshing];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return isFilter ? searchedData.count : adat.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = isFilter ? searchedData[indexPath.row] : adat[indexPath.row];
    [cell.textLabel setFont:[UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:19.0]];
    // Configure the cell...
    
    return cell;
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    if (searchText.length == 0)
        isFilter = NO;
    else
        isFilter = YES;
    
    NSMutableArray *tmpSearched = [[NSMutableArray alloc] init];
    
    for (NSString *string in adat) {
        
        NSRange range = [string rangeOfString:searchText
                                      options:NSCaseInsensitiveSearch];
        
        if (range.location != NSNotFound)
            [tmpSearched addObject:string];
    }
    
    searchedData = tmpSearched.copy;
    
    [self.tableView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"keresés");
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [adat removeObjectAtIndex:indexPath.row];
    [tableView reloadData];
}

-(IBAction)keresogomb:(id)sender{
    [kereso becomeFirstResponder];
    

}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
    // Navigation logic may go here. Create and push another view controller.
    
    // DetailViewController *detailViewController = [[DetailViewController alloc] initWithNibName:nil bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
   //  [self.navigationController pushViewController:detailViewController animated:YES];
    
}

@end
