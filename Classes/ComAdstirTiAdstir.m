/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2010-2013 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "ComAdstirTiAdstir.h"
#import "AdstirWebView.h"
#import "TiApp.h"
#import "TiUtils.h"

@interface ComAdstirTiAdstir ()
@property (retain) AdstirWebView* adstir;
@end

@implementation ComAdstirTiAdstir
+(id)alloc{
	NSLog(@"ComAdstirTiAdstir alloc");
	return [super alloc];
}


#pragma mark -
#pragma mark Ad Lifecycle

-(void)refreshAd:(CGRect)bounds
{
	if (self.adstir == nil) {
		self.adstir = [[[AdstirWebView alloc] initWithFrame:CGRectMake(0, 0, 320, 50) media:[self.proxy valueForKey:@"media"] spot:[self.proxy valueForKey:@"spot"]]autorelease];
		NSString* interval = [self.proxy valueForKey:@"refreshInterval"];
		if(interval == nil){
			self.adstir.intervalTime = ADSTIRWEBVIEW_DEFAULT_INTERVAL;
		}else{
			self.adstir.intervalTime = [interval intValue];
		}
		
		[self addSubview:self.adstir];
	}
}

-(void)frameSizeChanged:(CGRect)frame bounds:(CGRect)bounds
{
	NSLog(@"ComAdstirTiAdstir frameSizeChanged;");
    [self refreshAd:bounds];
}

-(void)willMoveToSuperview:(UIView *)newSuperview{
	if(newSuperview == nil){
		if (self.adstir != nil) {
			[self.adstir removeFromSuperview];
			self.adstir = nil;
		}
	}
	[super willMoveToSuperview:newSuperview];
}

-(void)dealloc
{
    if (self.adstir != nil) {
		[self.adstir removeFromSuperview];
		self.adstir = nil;
	}
    [super dealloc];
}

@end
