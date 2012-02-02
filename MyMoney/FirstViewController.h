//
//  FirstViewController.h
//  MyMoney
//
//  Created by byeong cheol lim on 11. 12. 18..
//  Copyright (c) 2011년 SK M&S. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"
#import "PlistLoader.h"
#import <AudioToolbox/AudioToolbox.h>
#define wonDollar 1200
typedef enum {
    kIntervalToNow,
    kIntervalToDate
} intervalType;

@interface FirstViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,NSFetchedResultsControllerDelegate,UITextViewDelegate,UITextFieldDelegate >
{
    IBOutlet UIButton *cancelButton;
    SystemSoundID ssid;
}
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
-(IBAction)touchOutside:(id)sender;
-(NSDate *) toLocalTime:(NSDate *)date;
-(NSNumber *)sumOfAmount:(NSDate *)interval;
-(void)registerTransaction:(NSMutableArray *)array;
-(IBAction)cashUse:(id)sender;
-(IBAction)cashRegister:(id)sender;
-(IBAction)cashRegisterCancel:(id)sender;
-(float)toColorValue:(float)rgbValue;
-(BOOL)textParser:(NSString *)sms;
-(void)singleParser:(NSArray *)separator sms:(NSString *)string bank:(NSString *)bankName firstline:(NSString *)firstLine;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic,retain) IBOutlet UITextView *textView;
@property (nonatomic,retain) IBOutlet UITableView *myTableView;
@property (nonatomic,retain) IBOutlet UIButton *button;
@property (nonatomic,retain) IBOutlet UIButton *cashButton;
@property (nonatomic,retain) IBOutlet UIButton *cashRegButton;

@property (nonatomic,retain) IBOutlet UITextField *priceField;

@property (nonatomic,retain) IBOutlet UITextField *shopField;
@property (nonatomic,retain) IBOutlet UITextField *currentTextField;
@property (nonatomic,retain) IBOutlet UIView *cashView;

@property (nonatomic,retain) IBOutlet UILabel *headerLabel;
@property (nonatomic,retain) UIButton *doneButton;
@property (nonatomic,retain) id currentSender;
@end
