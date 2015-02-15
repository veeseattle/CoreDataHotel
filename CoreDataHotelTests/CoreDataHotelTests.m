//
//  CoreDataHotelTests.m
//  CoreDataHotelTests
//
//  Created by Vania Kurniawati on 2/9/15.
//  Copyright (c) 2015 Vania Kurniawati. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "HotelService.h"
#import "Hotel.h"
#import "Room.h"
#import "Guest.h"

@interface CoreDataHotelTests : XCTestCase

@property (strong, nonatomic) HotelService *hotelService;
@property (strong, nonatomic) Room *room;
@property (strong, nonatomic) Guest *guest;
@property (strong, nonatomic) Hotel *hotel;


@end

@implementation CoreDataHotelTests

- (void)setUp {
    [super setUp];
  self.hotelService = [[HotelService alloc] initForTesting];
  self.hotel = [NSEntityDescription insertNewObjectForEntityForName:@"Hotel" inManagedObjectContext:self.hotelService.coreDataStack.managedObjectContext];
  self.hotel.name = @"The Plaza Hotel";
  self.hotel.location = @"New York";
  self.hotel.rating = @1;
  
  self.room = [NSEntityDescription insertNewObjectForEntityForName:@"Room" inManagedObjectContext:self.hotelService.coreDataStack.managedObjectContext];
  self.room.number = @402;
  self.room.rate = @1;
  self.room.hotel = self.hotel;
  self.room.beds = @2;
  
  self.guest = [NSEntityDescription insertNewObjectForEntityForName:@"Guest" inManagedObjectContext:self.hotelService.coreDataStack.managedObjectContext];
  self.guest.firstName = @"Vaniaaa";
  self.guest.lastName = @"Kurniawati";
}

- (void)tearDown {
  [super tearDown];
  self.hotelService = nil;
  self.hotel = nil;
  self.guest = nil;
  self.room = nil;
}

- (void)testAddReservation {
  NSDate *startDate = [NSDate date];
  NSCalendar *calendar = [NSCalendar currentCalendar];
  NSDateComponents *components = [[NSDateComponents alloc] init];
  components.day = 2;
  NSDate *endDate = [calendar dateByAddingComponents:components toDate:startDate options:0];
  
  Reservation *reservation = [self.hotelService bookReservationForGuest:self.guest ForRoom:self.room startDate:startDate endDate:endDate];
  XCTAssertNotNil(reservation,@"reservation should not be nil");
  
}

-(void)testInvalidDates {
  NSDate *startDate = [NSDate date];
  NSCalendar *calendar = [NSCalendar currentCalendar];
  NSDateComponents *components = [[NSDateComponents alloc] init];
  [components setDay:-6];
  NSDate *endDate = [calendar dateByAddingComponents:components toDate:startDate options:0];
  Reservation *reservation = [self.hotelService bookReservationForGuest:self.guest ForRoom:self.room startDate:startDate endDate:endDate];

  XCTAssertNil(reservation,@"end date should be greater than or equal to start date");
  
  
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
