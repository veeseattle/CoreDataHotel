//
//  AvailabilityViewController.m
//  CoreDataHotel
//
//  Created by Vania Kurniawati on 2/11/15.
//  Copyright (c) 2015 Vania Kurniawati. All rights reserved.
//

#import "AvailabilityViewController.h"
#import "AppDelegate.h"
#import "HotelService.h"
#import "Reservation.h"

@interface AvailabilityViewController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *startDatePicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *endDatePicker;
@property (weak, nonatomic) IBOutlet UISegmentedControl *hotelSegmentControl;
@property (strong,nonatomic) NSManagedObjectContext *context;
@end

@implementation AvailabilityViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (IBAction)checkAvailbilityPressed:(id)sender {
  
  //for hotel name = selectedHotel, return all rooms
  NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Room"];
  NSString *selectedHotel = [self.hotelSegmentControl titleForSegmentAtIndex:self.hotelSegmentControl.selectedSegmentIndex];
  
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.hotel.name MATCHES %@",selectedHotel];
  fetchRequest.predicate = predicate;
  NSError *fetchErr;
  NSArray *roomResults = [[[HotelService sharedService] coreDataStack].managedObjectContext executeFetchRequest:fetchRequest error:&fetchErr];
  NSLog(@"there are %lu rooms in this hotel", roomResults.count);
  
  //for the rooms fetched above, return reservations within the specified time period
  NSFetchRequest *reservationFetch = [NSFetchRequest fetchRequestWithEntityName:@"Reservation"];
  NSPredicate *reservationPredicate = [NSPredicate predicateWithFormat:@"room.hotel.name MATCHES %@ AND startDate <= %@ AND endDate >= %@", selectedHotel,self.endDatePicker.date, self.startDatePicker.date];
  reservationFetch.predicate = reservationPredicate;
  NSError *fetchError;
  
  NSArray *results = [[[HotelService sharedService] coreDataStack].managedObjectContext executeFetchRequest:reservationFetch error:&fetchError];
  
  NSMutableArray *rooms = [NSMutableArray new];
  for (Reservation *reservation in results) {
    [rooms addObject:reservation.room];
  }
  
  NSLog(@"number of reservation : %lu", rooms.count);
  
  NSFetchRequest *anotherFetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Room"];
  NSPredicate *roomsPredicate = [NSPredicate predicateWithFormat:@"hotel.name MATCHES %@ AND NOT (self IN %@)",selectedHotel, rooms];
  anotherFetchRequest.predicate = roomsPredicate;
  NSError *finalError;
  NSArray *finalResults = [self.context executeFetchRequest:anotherFetchRequest error:&finalError];
  if (finalError) {
    NSLog(@"%@",finalError.localizedDescription);
  }
  
  NSLog(@"results : %lu",(unsigned long)finalResults.count);
  
}

@end