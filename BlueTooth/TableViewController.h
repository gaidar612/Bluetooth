//
//  TableViewController.h
//  BlueTooth
//
//  Created by Admin on 19.04.16.
//  Copyright © 2016 Georgiy Gaidarenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface TableViewController : UITableViewController <CBCentralManagerDelegate> {
    CBCentralManager *centralManager;
    IBOutlet UITableView *table;
    NSMutableArray *itemArray;
}

@end
