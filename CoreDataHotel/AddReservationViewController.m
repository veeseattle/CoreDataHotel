//
//  AddReservationViewController.m
//  CoreDataHotel
//
//  Created by Vania Kurniawati on 2/11/15.
//  Copyright (c) 2015 Vania Kurniawati. All rights reserved.
//

#import "AddReservationViewController.h"
#import "Reservation.h"
#import "Guest.h"
#import "HotelService.h"

@interface AddReservationViewController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *startDatePicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *endDatePicker;


@end

@implementation AddReservationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)bookPressed:(id)sender {
  
  if (self.startDatePicker <= self.endDatePicker) {
    NSLog(@"End date should be greater than start date");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid Dates" message:@"Your end date should be after your start date" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    [alert show]; //I feel like this should also be in the HotelService because the if startDate < endDate is also set in the bookReservation function within HotelService? 
  }
  
  else {
  Guest *guest = [NSEntityDescription insertNewObjectForEntityForName:@"Guest" inManagedObjectContext:[[HotelService sharedService] coreDataStack].managedObjectContext];
  guest.firstName = @"Vaniaaaaaaaaa";
  guest.lastName = @"Kurniawati";
  
  [[HotelService sharedService] bookReservationForGuest:guest ForRoom:self.selectedRoom startDate:self.startDatePicker.date endDate:self.endDatePicker.date];
  [self dismissViewControllerAnimated:true completion:nil];
  }
  
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
