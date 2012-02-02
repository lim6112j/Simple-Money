//
//  ItemView.m
//  MyMoney
//
//  Created by byeong cheol lim on 11. 12. 26..
//  Copyright (c) 2011년 SK M&S. All rights reserved.
//

#import "ItemView.h"


@implementation ItemView
@synthesize label;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
 
    }
    return self;
}
#pragma mark Private methods


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    /* Get the current context */
    CGContextRef context = UIGraphicsGetCurrentContext();
    /* Save the state of the context */ CGContextSaveGState(context);
    
    
    /* The points of the rectangle that needs*/
     CGRect drawingRect = CGRectMake(0.0, 0.0f,
     100.0f, 200.0f);
    
    /* X */
    /* Y */
    /* Width */ /* Height */
    /* Get the red color */
    const CGFloat *rectColorComponents = CGColorGetComponents([UIColor redColor].CGColor);
    /* Draw with red fill color */ CGContextSetFillColor(context, rectColorComponents);
    /* Now draw the rectangle */ CGContextFillRect(context, drawingRect);
    /* The rectangular space in which the ellipse has to be drawn */
    CGRect ellipseRect = CGRectMake(160.0f, 200.0f, 150.0f,
                                    /* X */
                                    /* Y */
                                    /* Width */
                                    200.0f); /* Height */
    /* The blue color's components */
    const CGFloat *ellipseColorComponents = CGColorGetComponents([UIColor blueColor].CGColor);
    /* Set the blue color as the current fill color */ CGContextSetFillColor(context, ellipseColorComponents);
    /* And finally draw the ellipse */ CGContextFillEllipseInRect(context, ellipseRect);
    /* This is the font we want to use */
    UIFont *systemFont = [UIFont systemFontOfSize:16.0f];
    /* Get the name of the font */ const char *fontNameAsCString = [systemFont.fontName UTF8String];
    /* Using the font name, select the font into the context */ CGContextSelectFont(context,
                                                                                    fontNameAsCString, 16.0f, kCGEncodingMacRoman);
    /* Here is what we want to draw */
    const char *textToDraw = "Hello, World!";
    /* Now translate the context's coordinate and then rotate the context around the x-axis (-1 for y) to access the Cartesian coordinate system */
    CGContextTranslateCTM(context, 0.0f,
                          self.bounds.size.height);
    CGContextScaleCTM(context, 1.0,
                      -1.0f);
    /* Now draw at X = 200 and Y = 100 */ CGContextShowTextAtPoint(context,
                                                                   200.0f,
                                                                   100.0,
                                                                   textToDraw, strlen(textToDraw));
    /* Restore the state of the context */ CGContextRestoreGState(context);
}

@end
