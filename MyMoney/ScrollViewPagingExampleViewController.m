//
//  ScrollViewPagingExampleViewController.m
//  ScrollViewPagingExample
//
//  Created by byeong cheol lim on 11. 12. 25..
//  Copyright (c) 2011년 Byeong Cheol Lim. All rights reserved.
//
#import "ScrollViewPagingExampleViewController.h"
#import "PlistLoader.h"
@implementation ScrollViewPagingExampleViewController
@synthesize label,labelBelow;
#pragma mark -
#pragma mark Construction & Destruction

- (void)dealloc {
    AudioServicesDisposeSystemSoundID(ssid);
	[_scrollView release];
	[super dealloc];
}

#pragma mark -
#pragma mark UIViewController methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Settings", @"this is comment");
        self.tabBarItem.image = [UIImage imageNamed:@"image3456"];
    }
    return self;
}
- (void)viewDidLoad {
	_scrollView.clipsToBounds = NO;
	_scrollView.pagingEnabled = YES;
	_scrollView.showsHorizontalScrollIndicator = NO;
    PlistLoader *loader=[[[PlistLoader alloc]init]autorelease];
    NSMutableDictionary *dic= [loader PlistLoadFromFileName:@"Interval"];
	CGFloat contentOffset = 0.0f;
	NSArray *imageFilenames = [NSArray arrayWithObjects:
                               @"6.png",
                               @"0.png",
							   @"1.png",
                               @"2.png",
                               @"3.png",
                               @"4.png",
                               @"5.png",
                               
							   nil];

	for (NSString *singleImageFilename in imageFilenames) {
		CGRect imageViewFrame = CGRectMake(contentOffset, 0.0f, _scrollView.frame.size.width, _scrollView.frame.size.height);

		UIImageView *imageView = [[UIImageView alloc] initWithFrame:imageViewFrame];
		imageView.image = [UIImage imageNamed:singleImageFilename];
   
		imageView.contentMode = UIViewContentModeCenter;
		[_scrollView addSubview:imageView];
		

		contentOffset += imageView.frame.size.width;
        [imageView release];
		_scrollView.contentSize = CGSizeMake(contentOffset, _scrollView.frame.size.height);
	}
    NSString *fromWeek=[dic valueForKey:@"week"];
    [_scrollView setContentOffset:CGPointMake(kItemWidth*([fromWeek intValue]-1), positionY)];
    
    // 사운드 파일을 생성합니다.
    NSString *sndPath = [[NSBundle mainBundle] pathForResource:@"tick 3" ofType:@"aif"];
    // URL을 생성합니다
    CFURLRef sndURL = (CFURLRef)[[NSURL alloc] initFileURLWithPath:sndPath];
    // 사운드 아이디를 생성합니다.
    AudioServicesCreateSystemSoundID(sndURL, &ssid);
    
    
    // 하단 스크롤 메뉴 초기화
    _scrollViewBottom.clipsToBounds = NO;
	_scrollViewBottom.pagingEnabled = YES;
	_scrollViewBottom.showsHorizontalScrollIndicator = NO;
    //[_scrollViewBottom scrollRectToVisible:CGRectMake(200, 0, 50, 50) animated:YES];
    CGFloat contentOffsetBottom = 0.0f;
    

    //UIImage *updatedImg = [self addText:img text:text1]; 
   // NSLog(@"log text:%@",updatedImg); 
    
    
     UIImage *img = [UIImage imageNamed:@"scrollbg_item.png"];
	for (int i=0; i<30; i++) {
       
        NSString *string=[NSString stringWithFormat:@"%d",i+1];
        UIImage *image=[self addText:img text:string];
        CGRect imageViewFrameBottom = CGRectMake(contentOffsetBottom, 0.0f, _scrollViewBottom.frame.size.width, _scrollViewBottom.frame.size.height);
        
		UIImageView *imageViewBottom = [[UIImageView alloc] initWithFrame:imageViewFrameBottom];
		imageViewBottom.image = image;
        
		imageViewBottom.contentMode = UIViewContentModeCenter;
		[_scrollViewBottom addSubview:imageViewBottom];
        contentOffsetBottom += imageViewBottom.frame.size.width;
        [imageViewBottom release];
		_scrollViewBottom.contentSize = CGSizeMake(contentOffsetBottom, _scrollViewBottom.frame.size.height);
  }  
       NSString *fromMonth=[dic valueForKey:@"month"];
    [_scrollViewBottom setContentOffset:CGPointMake(kItemBelowWidth*([fromMonth intValue]-1), positionY)];
    
}
//Add text to UIImage
-(UIImage *)addText:(UIImage *)img text:(NSString *)text1{
    int w = img.size.width;
    int h = img.size.height; 
    //lon = h - lon;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
    
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), img.CGImage);
    CGContextSetRGBFillColor(context, 0.0, 0.0, 1.0, 1);
	
    char* text	= (char *)[text1 cStringUsingEncoding:NSASCIIStringEncoding];// "05/05/09";
    CGContextSelectFont(context, "Arial", 24, kCGEncodingMacRoman);
    CGContextSetTextDrawingMode(context, kCGTextFill);
    CGContextSetRGBFillColor(context, 255, 255, 255, 1);
	
    
    //rotate text
    //CGContextSetTextMatrix(context, CGAffineTransformMakeRotation( -M_PI/8 ));
	if ([text1 intValue]<10) {
        CGContextShowTextAtPoint(context, 20,20, text, strlen(text));
    } else
    {
        CGContextShowTextAtPoint(context, 12,20, text, strlen(text));
    }
    
	
	
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
	
    UIImage *retImage = [UIImage imageWithCGImage:imageMasked]; 
    CGImageRelease(imageMasked); 
    
    return retImage; 
}

-(void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"view will disappear");
    PlistLoader *loader=[[[PlistLoader alloc]init]autorelease];
    NSMutableDictionary *dic= [loader PlistLoadFromFileName:@"Interval"];
    [dic setValue:self.label.text forKey:@"week"];
    [dic setValue:self.labelBelow.text forKey:@"month"];
    NSString *documentPath=[self applicationDocumentsDirectory];
    NSString *fileName=[NSString stringWithFormat:@"Interval.plist"];
    NSString *fullPath=[documentPath stringByAppendingPathComponent:fileName];
    if ([[NSFileManager defaultManager]fileExistsAtPath:fullPath]) {
        NSLog(@"Score.plist exists");
    }
    if ([dic writeToFile:fullPath atomically:YES]) {
        NSLog(@"highest score saved");
    }
    NSLog(@"dic is changed as %@",[dic description]);
}

- (NSString *)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}
#pragma mark - scrollview delegate

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    lastScrollPosition = scrollView.contentOffset.x / kItemWidth;
    positionY=scrollView.contentOffset.y;
    //NSLog(@"lastScrollPosition is %f",lastScrollPosition);
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [scrollView setContentOffset:CGPointMake(scrollView.contentOffset.x, positionY)];//vertical스크롤을 막는다.
   // NSLog(@"current offset is  %f",_scrollView.contentSize.width); 
    int lastScrollPositionInt=(int)lastScrollPosition;
   // int lastScrollPositionInt=((lastScrollPosition - (int)lastScrollPosition) > 0.99) ? ceil(lastScrollPosition): floor(lastScrollPosition);
  //NSLog(@"current scrolll postion is %d",lastScrollPositionInt);  



    
    //NSLog(@"scrollview-scrollviewInt = %f",((scrollView.contentOffset.x / kItemWidth)-lastScrollPositionInt));
    if (scrollView==_scrollView) {
        //NSLog(@"uppper scroll activated");
            if ((int)(scrollView.contentOffset.x / kItemWidth) != lastScrollPositionInt)
            {
                if ((((scrollView.contentOffset.x / kItemWidth)-lastScrollPositionInt)>0.9)||(((scrollView.contentOffset.x / kItemWidth)-lastScrollPositionInt)<-0.9)) {
                    lastScrollPosition = scrollView.contentOffset.x / kItemWidth;
                    self.label.text=[NSString stringWithFormat:@"%d",(int)lastScrollPosition+1];
                    AudioServicesPlaySystemSound(ssid);
                }
            }

        
    }
    
    else
    {
        //NSLog(@"lower scroll activated");
        if ((int)(scrollView.contentOffset.x / kItemBelowWidth) != lastScrollPositionInt)
        {
            if ((((scrollView.contentOffset.x / kItemBelowWidth)-lastScrollPositionInt)>0.5)||(((scrollView.contentOffset.x / kItemBelowWidth)-lastScrollPositionInt)<-0.5)) {
                lastScrollPosition = scrollView.contentOffset.x / kItemBelowWidth;
                self.labelBelow.text=[NSString stringWithFormat:@"%d",(int)lastScrollPosition+1];
                AudioServicesPlaySystemSound(ssid);
            }
        }        
    }
    


    
    
}
@end
