//
//  ViewController.h
//  IOS6
//
//  Created by Klacsó Péter on 2/13/13.
//  Copyright (c) 2013 Klacsó Péter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UITableViewController<UISearchBarDelegate>

@property IBOutlet UISearchBar *kereso;
-(IBAction)keresogomb:(id)sender;
@end
