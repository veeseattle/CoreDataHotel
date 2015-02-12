//
//  HotelServiceViewController.h
//  CoreDataHotel
//
//  Created by Vania Kurniawati on 2/11/15.
//  Copyright (c) 2015 Vania Kurniawati. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreDataStack.h"
#import "Reservation.h"
#import "Room.h"
#import "Guest.h"

@interface HotelService : NSObject

@property (strong,nonatomic) CoreDataStack *coreDataStack;

+(id)sharedService;
-(instancetype)initForTesting;

-(Reservation *)bookReservationForGuest:(Guest *)guest ForRoom:(Room *)room startDate:(NSDate*)startDate endDate:(NSDate *)endDate;

@end
