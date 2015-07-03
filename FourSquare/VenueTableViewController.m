//
//  VenueTableViewController.m
//  FourSquare
//
//  Created by Kevin Mun Kuang Tzer on 6/10/15.
//  Copyright (c) 2015 Kevin Mun Kuang Tzer. All rights reserved.
//

#import "VenueTableViewController.h"
#import "UIViewController+AppController.h"

@interface VenueTableViewController ()

@end

@implementation VenueTableViewController
const int limit =10;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.venueList = [[NSMutableArray alloc]init];
    self.page = 0;
    self.isLoading = FALSE;
    self.allLoaded = FALSE;
    [self loadVenueList:self.page];
}

-(void) loadVenueList:(int) page{
    int currentOffset = page*limit;
    self.page = page;
    self.isLoading = TRUE;
    __weak typeof(self)weakSelf = self;
    [self.appController getVenueData:currentOffset limit:limit completion:^(VenueList *venueList, NSError *error) {
        if(error == nil){
            if([venueList.venues count] >0){
                [weakSelf.venueList addObjectsFromArray:venueList.venues];
            } else {
                weakSelf.allLoaded = TRUE;
            }
            [weakSelf.tableView reloadData];
        } else {
            NSLog(@"%@",error);
        }
         self.isLoading = FALSE;
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(self.allLoaded)
        return [self.venueList count];
    else
        return [self.venueList count]+1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == [self.venueList count]){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MoreCell"];
        if(cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MoreCell"];
        }
        UIActivityIndicatorView *activityView =
        [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [activityView startAnimating];
        [cell setAccessoryView:activityView];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.text = NSLocalizedString(@"VenueTableView_loading", nil);
        
        if (!self.allLoaded && !self.isLoading) {
            self.page += 1;
            __weak typeof(self)weakSelf = self;
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf loadVenueList:weakSelf.page];
            });
        }

        return cell;
    }
    
    Venue *venue = [self.venueList objectAtIndex:indexPath.row];
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"VenueCell"];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"VenueCell"];
    }
    cell.textLabel.text = venue.name;
    cell.detailTextLabel.text = venue.address;
    cell.imageView.image =[UIImage imageNamed:@"dash.png"];
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
