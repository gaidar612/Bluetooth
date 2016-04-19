//
//  TableViewController.m
//  BlueTooth
//
//  Created by Admin on 19.04.16.
//  Copyright © 2016 Georgiy Gaidarenko. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    itemArray = [NSMutableArray array];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)refresh:(id)sender {
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Button" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
    
//    [alert show];
    
  
    if (centralManager)
    {
        [centralManager stopScan];
        centralManager = nil;
    }
    
    [itemArray removeAllObjects];
    
    centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
   // [centralManager scanForPeripheralsWithServices:nil options:nil];
 /*
    [itemArray addObject:@"Test_1"];
    [itemArray addObject:@"Test_2"];
    [itemArray addObject:@"Test_3"];
    [itemArray addObject:@"Test_4"];*/
    
    [table reloadData];
}

- (void) centralManagerDidUpdateState:(CBCentralManager *)central {
    
    CBCentralManagerState state = central.state;
    
    NSLog(@"State: %ld", state);
    
    if (state == CBCentralManagerStatePoweredOn)
    {
        [centralManager scanForPeripheralsWithServices:nil options:nil];
    }
}

- (void) centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI {
    
//    NSString *id = [self getPeripheralId:peripheral];
//    self.labelText.text = id;
    
//    NSLog(@"Peripheral id: %@", id);
    
//    [centralManager stopScan];
    if (![itemArray containsObject:peripheral])
    {
        NSLog(@"Peripheral id: %@", peripheral.identifier);
        NSLog(@"Peripheral name: %@", peripheral.name);
        
        [itemArray addObject:peripheral];
        [table reloadData];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return itemArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];//] forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
 //   cell.textLabel.text = [itemArray objectAtIndex:indexPath.row];//[NSString stringWithFormat:@"Cell %d", (int)indexPath.row];
    
    CBPeripheral *peripheral = [itemArray objectAtIndex:indexPath.row];
    cell.textLabel.text = (peripheral.name ? peripheral.name : @"Not available");
    
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
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
