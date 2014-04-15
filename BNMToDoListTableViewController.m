//
//  BNMToDoListTableViewController.m
//  ToDoList
//
//  Created by Reinis Lācis on 12/04/14.
//  Copyright (c) 2014 Brand Name. All rights reserved.
//

#import "BNMToDoListTableViewController.h"
#import "BNMToDoItem.h"



@interface BNMToDoListTableViewController ()

@property (nonatomic, strong) NSMutableArray *toDoItems;

// <Path for the archive#>
@property NSURL *archivePath;

@end




@implementation BNMToDoListTableViewController



- (void)loadInitialData {
    
    
    BNMToDoItem *item1 = [[BNMToDoItem alloc] init];
    item1.itemName = @"Buy milk";
    [self.toDoItems addObject:item1];
    
    BNMToDoItem *item2 = [[BNMToDoItem alloc] init];
    item2.itemName = @"Buy eggs";
    [self.toDoItems addObject:item2];
    
    BNMToDoItem *item3 = [[BNMToDoItem alloc] init];
    item3.itemName = @"Read a book";
    [self.toDoItems addObject:item3];
    
    
}



- (IBAction)unwindToList:(UIStoryboardSegue *)segue
{
        BNMAddToDoItemViewController *source = [segue sourceViewController];
        BNMToDoItem *item = source.toDoItem;
        if (item != nil) {
            // Ir jauns To-Do ieraksts
            [self.toDoItems addObject:item];
            [self.tableView reloadData];
            // jāsaglabā arhīvā
            [self save];
            
        }
}



// saglabā arhīvu
- (void)save
{
    // arhīva fails
    self.archivePath = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"SavedData"];

   // NSString *testSave = @"123unTu esi brivs";
    
    if ([NSKeyedArchiver archiveRootObject:self.toDoItems toFile:[self.archivePath path]]) {
        // ir izdevies saglabāt
    } else {
        // nav izdevies saglabāt
    }
}


// returns the URL to the application's Documents directory
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


// esot konstruktoram līdzīga metode
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        // arhīva fails
        self.archivePath = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"SavedData"];
        //@"BNMToDoArchive";
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    // NSString* foofile = [documentsPath stringByAppendingPathComponent:@"foo.html"];
    
    // arhīva fails
    self.archivePath = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"SavedData"];

    
    if ([[NSFileManager defaultManager] fileExistsAtPath:[self.archivePath path]]) {
        // Ir atrasts saglabātais saraksts
        // NSString *archivePath = <Path for the archive#>;
        self.toDoItems = [[NSKeyedUnarchiver unarchiveObjectWithFile:[self.archivePath path]] mutableCopy];
        
    } else {
        self.toDoItems = [[NSMutableArray alloc] init];
        [self loadInitialData];
    }
    
    [self save];
    
    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table view data source



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.toDoItems.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    
    static NSString *CellIdentifier = @"ListPrototypeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    BNMToDoItem *toDoItem = [self.toDoItems objectAtIndex:indexPath.row];
    cell.textLabel.text = toDoItem.itemName;
    
    if (toDoItem.completed) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        // cell.accessoryType = UITableViewCellAccessoryNone;
        // cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        // cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        cell.accessoryType = UITableViewCellAccessoryDetailButton;
    }
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
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
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    BNMToDoItem *tappedItem = [self.toDoItems objectAtIndex:indexPath.row];
    tappedItem.completed = !tappedItem.completed;
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

@end
