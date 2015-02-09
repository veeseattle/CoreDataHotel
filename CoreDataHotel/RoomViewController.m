//
//  RoomViewController.m
//  CoreDataHotel
//
//  Created by Vania Kurniawati on 2/9/15.
//  Copyright (c) 2015 Vania Kurniawati. All rights reserved.
//

#import "RoomViewController.h"
#import "Room.h"
#import "AppDelegate.h"
#import "Hotel.h"

@interface RoomViewController ()
@property (strong, nonatomic) IBOutlet UITableView *roomsTable;
@property (strong,nonatomic) NSArray *rooms;

@end

@implementation RoomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  self.roomsTable.dataSource = self;
  self.roomsTable.delegate = self;
  
  self.rooms = [self.hotel.rooms allObjects];

  

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.hotel.rooms.count;
  }

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ROOM_CELL" forIndexPath:indexPath];
  Room *room = self.rooms[indexPath.row];
  cell.textLabel.text = [NSString stringWithFormat:@"%@",room.number];
  return cell;
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
