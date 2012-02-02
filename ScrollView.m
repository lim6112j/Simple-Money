//
//  ScrollView.m
//  MyMoney
//
//  Created by byeong cheol lim on 11. 12. 26..
//  Copyright (c) 2011년 SK M&S. All rights reserved.
//

#import "ScrollView.h"

@implementation ScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 /* Get the current context */
     CGContextRef context = UIGraphicsGetCurrentContext();
     CGContextSaveGState(context);/* Save the state of the context */
     CGRect drawingRect = CGRectMake(0.0, 0.0f,
      100.0f, 200.0f);
     const CGFloat *rectColorComponents = CGColorGetComponents([UIColor redColor].CGColor);
     CGContextSetFillColor(context, rectColorComponents);/* Draw with red fill color */ 
     CGContextFillRect(context, drawingRect);/* Now draw the rectangle */ 
     /* The rectangular space in which the ellipse has to be drawn */
     CGRect ellipseRect = CGRectMake(160.0f, 200.0f, 150.0f,200.0f); /* Height */
     /* The blue color's components */
     const CGFloat *ellipseColorComponents = CGColorGetComponents([UIColor blueColor].CGColor);
     CGContextSetFillColor(context, ellipseColorComponents);/* Set the blue color as the current fill color */ 
     CGContextFillEllipseInRect(context, ellipseRect);/* And finally draw the ellipse */ 

/* This is the font we want to use */
    UIFont *systemFont = [UIFont systemFontOfSize:16.0f];
    const char *fontNameAsCString = [systemFont.fontName UTF8String];/* Get the name of the font */ 
/* Using the font name, select the font into the context */ 
     CGContextSelectFont(context,fontNameAsCString, 16.0f, kCGEncodingMacRoman);

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
