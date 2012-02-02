//
//  FirstViewController.m
//  MyMoney
//
//  Created by byeong cheol lim on 11. 12. 18..
//  Copyright (c) 2011년 SK M&S. All rights reserved.
//

#import "FirstViewController.h"

@implementation FirstViewController
@synthesize fetchedResultsController = __fetchedResultsController;
@synthesize managedObjectContext = __managedObjectContext;
@synthesize textView,myTableView,button,headerLabel,cashButton,priceField,shopField,cashView,cashRegButton,currentTextField,doneButton,currentSender;
-(void)dealloc
{
    AudioServicesDisposeSystemSoundID(ssid);
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self setCurrentSender:nil];
    [self setCurrentTextField:nil];
    [self setCashRegButton:nil];
    [self setCashView:nil];
    [self setPriceField:nil];
    [self setShopField:nil];
    [self setButton:nil];
    [self setCashButton:nil];
    [self setMyTableView:nil];
    [self setTextView:nil];
    [self setManagedObjectContext:nil];
    [self setFetchedResultsController:nil];
    [self setHeaderLabel:nil];
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Register", @"this is comment");
        self.tabBarItem.image = [UIImage imageNamed:@"first"];

    }
    return self;
}
							
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}
#pragma mark - uitextview delegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{

    UIPasteboard *pasteBoard=[UIPasteboard generalPasteboard];
    self.currentSender=nil;
  //  [self textParser:pasteBoard.string];
    self.textView.text=pasteBoard.string;
    [self.cashButton setHidden:YES];
    [self.button setHidden:NO];
    [cancelButton setHidden:NO];
    return YES;
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    // add observer for the respective notifications (depending on the os version)

    if (textField==self.priceField) {
        self.currentTextField=self.priceField;
        [self.doneButton setHidden:NO];
    } else
    {
        self.currentTextField=self.shopField;
        [self.doneButton setHidden:YES];
    }
   
    

    
    NSLog(@"textfield begin editing");
    textField.text=@"";
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.doneButton setHidden:YES];

    [textField resignFirstResponder];
    return YES;
}
-(IBAction)cashUse:(id)sender
{
    [self.cashRegButton setEnabled:YES];
 //AudioServicesPlaySystemSound(ssid);
        CGRect cashViewTopFrame = self.cashView.frame;
        cashViewTopFrame.origin.y = 0;
        //CGRect basketBottomFrame = basketBottom.frame;
        //basketBottomFrame.origin.y = self.view.bounds.size.height;
#ifdef __IPHONE_OS_VERSION_MIN_REQUIRED
#if __IPHONE_OS_VERSION_MIN_REQUIRED > 40000
        [UIView animateWithDuration:0.5
                              delay:0.1
                            options: UIViewAnimationCurveEaseOut
                         animations:^{
                             self.cashView.frame = cashViewTopFrame;
                             //basketBottom.frame = basketBottomFrame;
                         } 
                         completion:^(BOOL finished){
                             NSLog(@"Done!");
                         }];
#else
        //Pre iOS 4
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationDelay:0.1];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        
        self.cashView.frame = cashViewTopFrame;
        //basketBottom.frame = basketBottomFrame;
        
        [UIView commitAnimations]; 
#endif
#endif
        /* 

         */
        
        // iOS4+
       
    
}
-(IBAction)cashRegister:(id)sender
{
   // AudioServicesPlaySystemSound(ssid);

    if (![self.priceField.text isEqualToString:@""]&&![self.shopField.text isEqualToString:@""]) {
        [self.cashRegButton setEnabled:NO];
        [self.priceField resignFirstResponder];
        [self.shopField resignFirstResponder];
        self.currentTextField =nil;
        CGRect cashViewTopFrame = self.cashView.frame;
        cashViewTopFrame.origin.y = -cashViewTopFrame.size.height;
        
        //CGRect basketBottomFrame = basketBottom.frame;
        //basketBottomFrame.origin.y = self.view.bounds.size.height;
#ifdef __IPHONE_OS_VERSION_MIN_REQUIRED
#if __IPHONE_OS_VERSION_MIN_REQUIRED > 40000
        [UIView animateWithDuration:0.5
                              delay:0.1
                            options: UIViewAnimationCurveEaseOut
                         animations:^{
                             self.cashView.frame = cashViewTopFrame;
                             //basketBottom.frame = basketBottomFrame;
                         } 
                         completion:^(BOOL finished){
                             NSLog(@"Done!");
                         }];
#else
        //Pre iOS 4
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationDelay:0.1];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        
        self.cashView.frame = cashViewTopFrame;
        //basketBottom.frame = basketBottomFrame;
        
        [UIView commitAnimations]; 
#endif
#endif
        /* 
         
         */
        
        // iOS4+
        NSDate *date=[NSDate date];
        NSString *price=[self.priceField text];
        NSString *shop=[self.shopField text];
        NSMutableArray *array=[NSMutableArray arrayWithObjects:NSLocalizedString(@"Cash", @"현금"),NSLocalizedString(@"Me", @"본인"),date,price,shop, nil];
        [self registerTransaction:array];
        [self.myTableView reloadData];
    }
    
        
    
    
}
-(IBAction)cashRegisterCancel:(id)sender
{

        [self.cashRegButton setEnabled:NO];
        self.currentTextField=nil;
        [self.priceField resignFirstResponder];
        [self.shopField resignFirstResponder];
        CGRect cashViewTopFrame = self.cashView.frame;
        cashViewTopFrame.origin.y = -cashViewTopFrame.size.height;
        
        //CGRect basketBottomFrame = basketBottom.frame;
        //basketBottomFrame.origin.y = self.view.bounds.size.height;
#ifdef __IPHONE_OS_VERSION_MIN_REQUIRED
#if __IPHONE_OS_VERSION_MIN_REQUIRED > 40000
        [UIView animateWithDuration:0.5
                              delay:0.1
                            options: UIViewAnimationCurveEaseOut
                         animations:^{
                             self.cashView.frame = cashViewTopFrame;
                             //basketBottom.frame = basketBottomFrame;
                         } 
                         completion:^(BOOL finished){
                             NSLog(@"Done!");
                         }];
#else
        //Pre iOS 4
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationDelay:0.1];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        
        self.cashView.frame = cashViewTopFrame;
        //basketBottom.frame = basketBottomFrame;
        
        [UIView commitAnimations]; 
#endif
#endif
        /* 
         
         */
        
        // iOS4+
    
}
-(NSDate *) toLocalTime:(NSDate *)date
{
    NSTimeZone *tz = [NSTimeZone defaultTimeZone];
    NSInteger seconds = [tz secondsFromGMTForDate:date];
    return [NSDate dateWithTimeInterval: seconds sinceDate:date];
}
-(void)registerTransaction:(NSMutableArray *)array
{
    id appDelegate=[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context=[appDelegate managedObjectContext];
    NSEntityDescription *entity=[NSEntityDescription  entityForName:@"Money" inManagedObjectContext:context];
    NSManagedObject *managedObj=[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
    [managedObj setValue:[array objectAtIndex:0] forKey:@"card"];
    [managedObj setValue:[array objectAtIndex:1] forKey:@"owner"];
    
    // Convert string to date object
    if ([[array objectAtIndex:2] isKindOfClass:[NSString class]]) {
        

    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"YYYY"];
    NSString *dateStr = [dateFormat stringFromDate:[NSDate date]]; 
    NSString *fullDate=[dateStr stringByAppendingFormat:@"%@",[array objectAtIndex:2]];
    NSLog(@"fulldate = %@",fullDate);
    [dateFormat setDateFormat:@"yyyyMM/dd HH:mm"];
    NSDate *date = [dateFormat dateFromString:fullDate];  
    //NSDate *localDate=[self toLocalTime:date];
    //NSLog(@"date : %@",[localDate description]);
    [dateFormat release];
    [managedObj setValue:date forKey:@"useDate"];
    } else
    {
        [managedObj setValue:[array objectAtIndex:2] forKey:@"useDate"];

    }
    
    NSString *newStr= [[array objectAtIndex:3] stringByReplacingOccurrencesOfString:@"원" withString:@""];
    NSString *newStrr=[newStr stringByReplacingOccurrencesOfString:@"," withString:@""];
    NSDecimalNumber *deciNum=[NSDecimalNumber decimalNumberWithString:newStrr];
    NSLog(@"money after process : %@, %@",newStrr,deciNum);
    [managedObj setValue:deciNum forKey:@"amount"];
    [managedObj setValue:[array objectAtIndex:4] forKey:@"shop"];
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         */
        
        
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    NSLog(@"core data added from detail");
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    /*
    NSString *mainStr=self.textView.text;
    if ([mainStr hasPrefix:@"하나SK"]||[mainStr hasPrefix:@"[현대"]||[mainStr hasPrefix:@"KB국민"])
    {
        
    
    NSArray *array=[mainStr componentsSeparatedByString:@"\n"];

        if ([array count]>4) 
        {
            NSMutableArray *tempArray=[NSMutableArray arrayWithCapacity:5];
            for (int i=0; i<[array count]; i++) {
                [tempArray addObject:[array objectAtIndex:i]];
                if (i%5==4) {
                    [self registerTransaction:tempArray];
                    [tempArray removeAllObjects];
                }
            }
            
        } 
        else if(![self.textView.text isEqualToString:@""])
        {
            NSArray *array=[self.textView.text componentsSeparatedByString:@"\n"];
            
            for (int i=0; i<[array count]; i++) {
                
                NSString *string=[array objectAtIndex:i];
                NSRange tempIdx=[string rangeOfString:@")"];
                NSString *cardStr=[string substringToIndex:tempIdx.location+1];
                NSLog(@"parsed string is : %@",cardStr);
                tempIdx.location+=2;
                NSRange tempIdx2=[string rangeOfString:@" "];
                NSLog(@"tempIdx2 is %d,%d",tempIdx2.location,tempIdx.length);
                NSString *ownerStr=[string substringWithRange:NSMakeRange(tempIdx.location-1, tempIdx2.location-tempIdx.location+1)];
                NSLog(@"owner is :%@, range is location %d, length is %d",ownerStr,tempIdx.location+2, tempIdx2.length-tempIdx.length);
                NSString *leftStr=[string substringFromIndex:tempIdx2.location];
                NSLog(@"leftStr is :%@",leftStr);
                NSRange tempIdx3=[leftStr rangeOfString:@":"];
                NSLog(@"tempIdx3 is : %d",tempIdx3.location);
                NSString *timeStr=[leftStr substringToIndex:tempIdx3.location+3];
                NSLog(@"date is %@",timeStr);
                NSString *leftStr2=[leftStr substringFromIndex:tempIdx3.location+3];
                NSLog(@"남은 문자열 : %@",leftStr2);
                NSArray *array=[leftStr2 componentsSeparatedByString:@"/"];
                // for (int i=0; i<[array count]; i++) {
                //    NSLog(@"array [%d] is %@",i,[array objectAtIndex:i]);
                // }
                NSMutableArray *arrayReturn;
                if ([array count]==3) {
                    NSString *temp=[array objectAtIndex:0];
                    NSLog(@"temp is %@",temp);
                    NSString *temp2=[temp stringByReplacingOccurrencesOfString:@"USD" withString:@""];
                    NSLog(@"amount is %@",temp2);
                    arrayReturn=[NSMutableArray arrayWithObjects:cardStr,ownerStr,timeStr,temp2,[array objectAtIndex:2], nil];
                    
                } else if([array count]>=4)
                {
                    arrayReturn=[NSMutableArray arrayWithObjects:cardStr,ownerStr,timeStr,[array objectAtIndex:1],[array objectAtIndex:3], nil];
                    
                }
                [self registerTransaction:arrayReturn];
            }
        }
        [self.myTableView reloadData];
        [self.button setHidden:YES];
        [cancelButton setHidden:YES];
        [self.cashButton setHidden:NO];
    } else if(self.currentSender!=cancelButton)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"잘못된 SMS 포맷" message:@"SMS포맷이 지원되지 않습니다. 국민체크카드, 현대카드, 하나SK카드만 현재 지원됩니다." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        [self.button setHidden:YES];
        [cancelButton setHidden:YES];
        [self.cashButton setHidden:NO];
        
    }

*/
    
    NSString *mainStr=self.textView.text;
    if ([self textParser:mainStr]) {
        [self.myTableView reloadData];
        [self.button setHidden:YES];
        [cancelButton setHidden:YES];
        [self.cashButton setHidden:NO];
  
    } else if(self.currentSender!=cancelButton)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"잘못된 SMS 포맷" message:@"SMS포맷이 지원되지 않습니다. 국민체크카드, 현대카드(해외포함), 하나SK카드(해외포함),SC제일BC만 현재 지원됩니다." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        [self.button setHidden:YES];
        [cancelButton setHidden:YES];
        [self.cashButton setHidden:NO];
    }

}
-(void)singleParser:(NSArray *)separator sms:(NSString *)string bank:(NSString *)bankName firstline:(NSString *)firstLine
{
    NSString *sms=string;
    PlistLoader *loader=[[[PlistLoader alloc]init]autorelease];
    NSMutableDictionary *dic= [loader PlistLoadFromFileName:@"Transaction"];
    NSString *arrayOrder;
    NSError *error;
    NSRegularExpression *regexForAll= [NSRegularExpression regularExpressionWithPattern:@"USD"
                                                                                options:NSRegularExpressionCaseInsensitive
                                                                                  error:&error];
    NSInteger numberOfMatching=[regexForAll numberOfMatchesInString:sms options:0 range:NSMakeRange(0, [sms length])];
    NSLog(@"SMS message is %@",sms);
    if (numberOfMatching==0) {
        arrayOrder=[dic valueForKey:bankName];
        NSLog(@"국내승인");
    } else
    {
        NSString *tempStr=[NSString stringWithFormat:@"%@-해외",bankName];
        arrayOrder=[dic valueForKey:tempStr];
        NSLog(@"해외승인");
    }
    // NSLog(@"last retArray is %@",[retArray description]);
    
    NSArray *arrayOrderArray=[arrayOrder componentsSeparatedByString:@","];
    


    NSMutableArray *retArray=[[NSMutableArray alloc]initWithCapacity:10];
    NSString *lastItem;
    for (int i=0; i<[separator count];i++) {
        NSRange tempIdx=[string rangeOfString:[separator objectAtIndex:i]];
        NSString *tempStr,*firstStr;
        NSLog(@"tempidx location is %d, string length is %d",tempIdx.location,[string length]);
        if (tempIdx.location<=[string length]) {
            
            if (i==0) {
                tempStr=[string substringFromIndex:tempIdx.location+1];
                 string=tempStr;
                firstStr=firstLine;
                NSLog(@"firstStr is %@",firstStr);
                [retArray addObject:firstStr];
            } else
            {
                tempStr=[string substringFromIndex:tempIdx.location+1];
                NSString *retStr=[string substringToIndex:tempIdx.location];
                [retArray addObject:retStr];
                NSLog(@"%d번째 서브스트링은 %@",i,retStr);
                string=tempStr;
                lastItem=tempStr;
                NSLog(@"idx(%d,%d) of %@ in %@",tempIdx.location,tempIdx.length,[separator objectAtIndex:i],tempStr); 
            }

        } 

    }
    if ([retArray count]>=[arrayOrderArray count]-1) {
        if (![lastItem isEqualToString:@""]) {
            [retArray addObject:lastItem];
        }
        //NSLog(@"bankname is %@",bankName);
        
        
        
        NSMutableArray *returnArray=[[[NSMutableArray alloc]initWithCapacity:10]autorelease];
        for (int i=0; i<[arrayOrderArray count]; i++) {
            if ([[arrayOrderArray objectAtIndex:i] length]==1) { // 단자리 숫자이면
                NSString *retStr=[retArray objectAtIndex:[[arrayOrderArray objectAtIndex:i] intValue]];
                NSString *trimmedStr;
                float outcome;
                if ([retStr hasPrefix:@"USD"]) {
                    trimmedStr=[retStr stringByReplacingOccurrencesOfString:@"USD" withString:@""];
                    outcome=[trimmedStr floatValue]*wonDollar;
                    trimmedStr=[NSString stringWithFormat:@"%d",(int)outcome];
                } else
                {
                    trimmedStr=retStr;
                }
                [returnArray addObject:trimmedStr];

            }
            else //복합된 문자열이면 e.g. 2-3
            {
                NSString *tempStr2=[arrayOrderArray objectAtIndex:i];
                NSArray *tempStr2Array=[tempStr2 componentsSeparatedByString:@"-"];
                NSString *temp3=[NSString stringWithFormat:@"%@ %@",[retArray objectAtIndex:[[tempStr2Array objectAtIndex:0] intValue]],[retArray objectAtIndex:[[tempStr2Array objectAtIndex:1] intValue]]];
                [returnArray addObject:temp3];
            }
        }
        // NSLog(@"return array is %@",[returnArray description]);
        [self registerTransaction:returnArray];
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"잘못된 SMS 포맷" message:@"SMS포맷이 지원되지 않습니다. 국민체크카드, 현대카드(해외포함), 하나SK카드(해외포함), SC제일BC카드만 현재 지원됩니다." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        [self.button setHidden:YES];
        [cancelButton setHidden:YES];
        [self.cashButton setHidden:NO];
    }


}
-(BOOL)textParser:(NSString *)sms
{
    NSString *mainStr=sms;
    PlistLoader *loader=[[[PlistLoader alloc]init]autorelease];
    NSMutableDictionary *dic= [loader PlistLoadFromFileName:@"Bank"];

    //여러줄을 처리함
    NSArray *smsArray=nil;
    NSArray *separator;
    NSString *bank;
    NSString *firstLine;
    NSEnumerator *e =[dic keyEnumerator];
    for (NSString *str in e) {
       
        NSArray *array=[mainStr componentsSeparatedByString:str];
        if ([array count]>1) {
            smsArray=array;
            bank=str;
            NSLog(@"array objectatindex:0 is %@",[array objectAtIndex:0]);
            firstLine=[str stringByAppendingFormat:@"%@",[array objectAtIndex:0]];
            NSString *string=[dic valueForKey:str];
            separator=[string componentsSeparatedByString:@","];
            
        }

    }
    if (smsArray!=nil) {
        NSLog(@"ARRAY  is %@, %d개",[smsArray description],[smsArray count]);
        for (int i=1; i<[smsArray count]; i++) 
        {
            [self singleParser:separator sms:[smsArray objectAtIndex:i] bank:bank firstline:firstLine];
        } 
        return YES;
    }
        else
    {
        return NO;
    }

}
-(IBAction)touchOutside:(id)sender
{
    if (sender==cancelButton) {
        self.currentSender=sender;
        self.textView.text=@"지출 입력이 취소 되었습니다.";
        [cancelButton setHidden:YES];
        [button setHidden:YES];
        [cashButton setHidden:NO];
        self.currentTextField=nil;
    }
    [self.textView resignFirstResponder];
}

#pragma mark - View lifecycle
- (void)addButtonToKeyboard {
	// create custom button
	self.doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
	self.doneButton.frame = CGRectMake(0, 163, 106, 53);
	self.doneButton.adjustsImageWhenHighlighted = NO;
	if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 3.0) {
		[self.doneButton setImage:[UIImage imageNamed:@"minus_up.png"] forState:UIControlStateNormal];
		[self.doneButton setImage:[UIImage imageNamed:@"minus_down.png"] forState:UIControlStateHighlighted];
	} else {        
		[self.doneButton setImage:[UIImage imageNamed:@"minus_up.png"] forState:UIControlStateNormal];
		[self.doneButton setImage:[UIImage imageNamed:@"minus_down.png"] forState:UIControlStateHighlighted];
	}
	[self.doneButton addTarget:self action:@selector(minusButton:) forControlEvents:UIControlEventTouchUpInside];
	// locate keyboard view
	UIWindow* tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
	UIView* keyboard;
	for(int i=0; i<[tempWindow.subviews count]; i++) {
		keyboard = [tempWindow.subviews objectAtIndex:i];
		// keyboard found, add the button
       // NSLog(@"keyboard is subviews[%d]******************* %@",i,[keyboard description]);
		if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 3.2) {
			if([[keyboard description] hasPrefix:@"<UIPeripheralHost"] == YES)
				[keyboard addSubview:self.doneButton];
		} else {
			if([[keyboard description] hasPrefix:@"<UIKeyboard"] == YES)
				[keyboard addSubview:self.doneButton];
		}
	}
    if (self.currentTextField==self.priceField) {
       
        [self.doneButton setHidden:NO];
    } else
    {
        [self.doneButton setHidden:YES];
    }
   
}

- (void)keyboardWillShow:(NSNotification *)note {
	// if clause is just an additional precaution, you could also dismiss it
	if ([[[UIDevice currentDevice] systemVersion] floatValue] < 3.2) {
		[self addButtonToKeyboard];
	}
}

- (void)keyboardDidShow:(NSNotification *)note{
	// if clause is just an additional precaution, you could also dismiss it
	if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 3.2) {
		[self addButtonToKeyboard];
    }
}


- (void)minusButton:(id)sender {
	NSLog(@"doneButton");
   // NSLog(@"Input: %@", textField.text);
    //[textField resignFirstResponder];
    NSString *string= self.priceField.text;;
    if ([string hasPrefix:@"-"]) {
        self.priceField.text= [string stringByReplacingOccurrencesOfString:@"-" withString:@""];
    } else
    {         
        self.priceField.text=@"";
        self.priceField.text=[NSString stringWithFormat:@"-%@",string];
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];

   // NSLog(@"plist's day value is %@",string);
	// Do any additional setup after loading the view, typically from a nib.
    headerLabel.text = NSLocalizedString(@"Money Expense", @"");
	headerLabel.textColor = [UIColor whiteColor];
	headerLabel.shadowColor = [UIColor blackColor];
	headerLabel.shadowOffset = CGSizeMake(0, 1);
	headerLabel.font = [UIFont boldSystemFontOfSize:22];
	headerLabel.backgroundColor = [UIColor clearColor];
    self.priceField.delegate=self;
    self.shopField.delegate=self;
    // add observer for the respective notifications (depending on the os version)
	if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 3.2) {
		[[NSNotificationCenter defaultCenter] addObserver:self 
												 selector:@selector(keyboardDidShow:) 
													 name:UIKeyboardDidShowNotification 
												   object:nil];		
	} else {
		[[NSNotificationCenter defaultCenter] addObserver:self 
												 selector:@selector(keyboardWillShow:) 
													 name:UIKeyboardWillShowNotification 
												   object:nil];
	}
    
    // 사운드 파일을 생성합니다.
    NSString *sndPath = [[NSBundle mainBundle] pathForResource:@"sound" ofType:@"aif"];
    // URL을 생성합니다
    CFURLRef sndURL = (CFURLRef)[[NSURL alloc] initFileURLWithPath:sndPath];
    // 사운드 아이디를 생성합니다.
    AudioServicesCreateSystemSoundID(sndURL, &ssid);

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;


}

- (void)viewWillAppear:(BOOL)animated
{

    [super viewWillAppear:animated];

    [self.myTableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation == UIInterfaceOrientationPortrait);
    } else {
        return YES;
    }
}
#pragma mark - tableview

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}
-(NSNumber *)sumOfAmount:(NSDate *)interval
{
    AppDelegate *appDelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    self.managedObjectContext=  [appDelegate managedObjectContext];
    
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"Money" inManagedObjectContext:self.managedObjectContext];
    NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
    [request setEntity:entityDescription];
    
    // Set example predicate and sort orderings...
    // NSDate *date= [NSDate date];
    //NSDate *currentDate= [self toLocalTime:date];

    NSPredicate *predicate = [NSPredicate predicateWithFormat:
                              @"useDate > %@", interval];
    [request setPredicate:predicate];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
                                        initWithKey:@"useDate" ascending:YES];
    [request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    [sortDescriptor release];
    
    NSError *error = nil;
    NSArray *array = [self.managedObjectContext executeFetchRequest:request error:&error];
    
    NSNumber *tempDisplayTotalNumber ;

    if (array == nil)
    {
        // Deal with error...
        NSLog(@"useDate is null");
    } else
    {
        
        

        NSInteger currentTotal = 0;
        NSEnumerator *e = [array objectEnumerator];
        //NSLog(@"Count of items we will loop through is: %d",[array count]);
        Money *money;
        while (money = [e nextObject]) {
            if ([money valueForKey:@"amount"]) {
                currentTotal = currentTotal + [[money valueForKey:@"amount"] intValue];
            }
        }
        tempDisplayTotalNumber = [NSNumber numberWithInt:currentTotal];
    }
    return tempDisplayTotalNumber;
}
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    NSDate *today = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *weekdayComponents =
    [gregorian components:(NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit | NSWeekdayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit) fromDate:today];
    NSInteger year=[weekdayComponents year];
    NSInteger mymonth=[weekdayComponents month];
    NSInteger day = [weekdayComponents day];
    
    PlistLoader *loader=[[[PlistLoader alloc]init]autorelease];
    NSMutableDictionary *dic= [loader PlistLoadFromFileName:@"Interval"];
    NSString *fromWeekday=[dic valueForKey:@"week"];
    NSString *fromMonth=[dic valueForKey:@"month"];
    if (indexPath.row==0) {
        //cell.textLabel.text=@"일간 지출액";
        cell.textLabel.text=[NSString stringWithFormat:@"%d%@",day, NSLocalizedString(@"1 Day Expense", @"하루지출")];
       // NSTimeInterval month=-24*60*60;
        //NSLog(@"kintervaltonow is %d, kintervaltodate is %d",kIntervalToNow,kIntervalToDate);

        NSDateComponents *comps=[[[NSDateComponents alloc]init]autorelease];
        [comps setDay:day];
        [comps setMonth:mymonth];
        [comps setYear:year];
        [comps setHour:0];
        [comps setMinute:0];
        NSDate *todayStart=[gregorian dateFromComponents:comps];
               NSLog(@"daystart is %@",[todayStart description]);
       // NSLog(@"month is %d,day is %d, weekday is %d, hour is %d",mymonth,day,weekday,hour);
       // NSDate *monthBefore=[NSDate dateWithTimeInterval:<#(NSTimeInterval)#> sinceDate:<#(NSDate *)#>
        //NSDate *localDate=[self toLocalTime:monthBefore];
        NSNumber *num= [self sumOfAmount:todayStart];
        cell.detailTextLabel.text=[numberFormatter stringFromNumber:num];
    }
    if (indexPath.row==1) {
        cell.textLabel.text=NSLocalizedString(@"1 Week Expense", @"일주일지출");
        
        

        NSInteger weekday = [weekdayComponents weekday];
        
     //   NSLog(@"weekday is %d",weekday);
        NSDateComponents *comps=[[[NSDateComponents alloc]init]autorelease];
        if (weekday>=[fromWeekday intValue]) 
        {
            [comps setDay:(day-weekday+[fromWeekday intValue])];
        } else
        {
            [comps setDay:(day+[fromWeekday intValue]-weekday-7)]; 
        }

        [comps setMonth:mymonth];
        [comps setYear:year];
        [comps setHour:0];
        [comps setMinute:0];
        NSDate *weekStart=[gregorian dateFromComponents:comps];
      //  NSLog(@"weekstart is %@",[weekStart description]);
        
        
        
     
       // NSDate *localDate=[self toLocalTime:monthBefore];
        NSNumber *num= [self sumOfAmount:weekStart];
        cell.detailTextLabel.text=[numberFormatter stringFromNumber:num];
    }
    if (indexPath.row==2) {

        cell.textLabel.text= [NSString stringWithFormat:@"%d%@",mymonth,  NSLocalizedString(@"1 Month Expense", @"한달지출")];
        
        NSDateComponents *comps=[[[NSDateComponents alloc]init]autorelease];
        if (day<[fromMonth intValue]) 
        {
            mymonth-=1;
        }
        [comps setDay:[fromMonth intValue]];
        [comps setMonth:mymonth];
        [comps setYear:year];
        [comps setHour:0];
        [comps setMinute:0];
        
        NSDate *monthStart=[gregorian dateFromComponents:comps];
       // NSLog(@"monthstart is %@",[monthStart description]);
       // NSLog(@"dic is %@",[dic description]);
       // NSDate *localDate=[self toLocalTime:monthBefore];
        NSNumber *num= [self sumOfAmount:monthStart];
        cell.detailTextLabel.text=[numberFormatter stringFromNumber:num];
    }

}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    if ((indexPath.row)%2==1) {
        cell.backgroundColor=[UIColor colorWithRed:[self toColorValue:168] green:[self toColorValue:168] blue:[self toColorValue:168] alpha:1.0];
    } else
    {
        cell.backgroundColor=[UIColor colorWithRed:[self toColorValue:118] green:[self toColorValue:118] blue:[self toColorValue:118] alpha:1.0];
        
    }
     */
            cell.backgroundColor=[UIColor colorWithRed:[self toColorValue:168] green:[self toColorValue:168] blue:[self toColorValue:168] alpha:1.0];
}
-(float)toColorValue:(float)rgbValue
{
    return rgbValue/255;
}
#pragma mark - fetchedResultsController
- (NSFetchedResultsController *)fetchedResultsController
{
    if (__fetchedResultsController != nil) {
        return __fetchedResultsController;
    }
    
    // Set up the fetched results controller.
    // Create the fetch request for the entity.
    // [NSFetchedResultsController deleteCacheWithName:@"Master"];
    NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
    // Edit the entity name as appropriate.
    AppDelegate *appDelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    self.managedObjectContext=  [appDelegate managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Money" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"useDate" ascending:NO] autorelease];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"Master"] autorelease];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
	NSError *error = nil;
	if (![self.fetchedResultsController performFetch:&error]) {
	    /*
	     Replace this implementation with code to handle the error appropriately.
         
	     abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
	     */
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	    abort();
	}
    
    return __fetchedResultsController;
}    
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.myTableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.myTableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.myTableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.myTableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.myTableView endUpdates];
    
}

@end
