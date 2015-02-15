//
//  HotelServiceViewController.m
//  CoreDataHotel
//
//  Created by Vania Kurniawati on 2/11/15.
//  Copyright (c) 2015 Vania Kurniawati. All rights reserved.
//

#import "HotelService.h"

@implementation HotelService

+(id)sharedService {
  static HotelService *mySharedService = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    mySharedService = [[self alloc] init];
  });
  return mySharedService;
}

-(instancetype)init {
  self = [super init];
  if (self) {
    self.coreDataStack = [[CoreDataStack alloc] init];
  }
  return self;
}

-(instancetype)initForTesting {
  self = [super init];
  if (self) {
    self.coreDataStack = [[CoreDataStack alloc] initForTesting];
  }
  return self;
}

-(Reservation *)bookReservationForGuest:(Guest *)guest ForRoom:(Room *)room startDate:(NSDate*)startDate endDate:(NSDate *)endDate {
  Reservation *reservation = [NSEntityDescription insertNewObjectForEntityForName:@"Reservation" inManagedObjectContext:self.coreDataStack.managedObjectContext];
  reservation.startDate = startDate;
  reservation.endDate = endDate;
  reservation.room = room;
  reservation.guest = guest;
  
  NSError *saveError;
  [self.coreDataStack.managedObjectContext save:&saveError];
  if (startDate  > endDate) {
    if (!saveError) {
      return reservation;
    }
  }
  return nil;
}


  
@end
