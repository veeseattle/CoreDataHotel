//
//  HotelListViewController.m
//  CoreDataHotel
//
//  Created by Vania Kurniawati on 2/9/15.
//  Copyright (c) 2015 Vania Kurniawati. All rights reserved.
//

#import "HotelListViewController.h"
#import "AppDelegate.h"
#import "Hotel.h"
#import "RoomViewController.h"
#import "HotelService.h"

@interface HotelListViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *hotelTable;
@property (strong,nonatomic) NSArray *hotels;


@end

@implementation HotelListViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.hotelTable.dataSource = self;
  self.hotelTable.delegate = self;
  
  //NSManagedObjectContext *context = appDelegate.managedObjectContext;
  
  NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Hotel"];
  
  NSError *fetchError;
  
  //NSArray *results = [context executeFetchRequest:fetchRequest error:&fetchError];
  
  NSArray *results = [[[HotelService sharedService] coreDataStack].managedObjectContext executeFetchRequest:fetchRequest error:&fetchError];
  
  if (!fetchError) {
    self.hotels = results;
    [self.hotelTable reloadData];
  }
  
  // Do any additional setup after loading the view.
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if (self.hotels) {
    return self.hotels.count;
  }
  else {
    return 0;
  }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
  Hotel *hotel = self.hotels[indexPath.row];
  cell.textLabel.text = hotel.name;
  return cell;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:@"SHOW_ROOMS"]) {
    RoomViewController *roomVC = (RoomViewController *)segue.destinationViewController;
    NSIndexPath *indexPath = [self.hotelTable indexPathForSelectedRow];
    Hotel *selectedHotel = self.hotels[indexPath.row];
    roomVC.hotel = selectedHotel;
    
  }
}





- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
