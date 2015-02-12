//
//  BookRoomViewController.h
//  CoreDataHotel
//
//  Created by Vania Kurniawati on 2/11/15.
//  Copyright (c) 2015 Vania Kurniawati. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoomViewController.h"
#import "Room.h"

@interface BookRoomViewController : UIViewController

@property (strong,nonatomic) Room *selectedRoom;

@end
