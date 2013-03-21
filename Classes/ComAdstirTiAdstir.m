/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2010-2013 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "ComAdstirTiAdstir.h"
#import "AdstirView.h"
#import "TiApp.h"
#import "TiUtils.h"

@interface ComAdstirTiAdstir () <AdstirViewDelegate>
@property (retain) AdstirView* adstir;
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
		self.adstir = [[[AdstirView alloc] initWithOrigin:bounds.origin]autorelease];
		self.adstir.media = [self.proxy valueForKey:@"media"];
		self.adstir.spot = [[self.proxy valueForKey:@"spot"]intValue];
		self.adstir.rootViewController = [[TiApp app] controller];
		self.adstir.delegate = self;
		[self addSubview:self.adstir];
		[self.adstir start];
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
			[self.adstir stop];
			[self.adstir removeFromSuperview];
			self.adstir.rootViewController = nil;
			self.adstir = nil;
		}
	}
	[super willMoveToSuperview:newSuperview];
}

-(void)dealloc
{
    if (self.adstir != nil) {
		[self.adstir stop];
		[self.adstir removeFromSuperview];
		self.adstir.rootViewController = nil;
		self.adstir = nil;
	}
    [super dealloc];
}

#pragma mark Ad Delegate

- (void)adstirDidReceiveAd:(AdstirView*)adstirview{
	NSLog(@"ComAdstirTiAdstir adstirDidReceiveAd:");
    [self.proxy fireEvent:@"didReceiveAd"];
}
- (void)adstirDidFailToReceiveAd:(AdstirView*)adstirview{
	NSLog(@"ComAdstirTiAdstir adstirDidFailToReceiveAd:");
    [self.proxy fireEvent:@"didFailToReceiveAd"];
}

@end
