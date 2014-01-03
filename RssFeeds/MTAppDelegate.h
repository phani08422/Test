//
//  MTAppDelegate.h
//  RssFeeds
//
//  Created by iappease on 11/15/13.
//  Copyright (c) 2013 iAPPease. All rights reserved.
//

#import <UIKit/UIKit.h>

/// class for delegate
@interface MTAppDelegate : UIResponder <UIApplicationDelegate>

/// window of view
@property (strong, nonatomic) UIWindow *window;

/*!
 @abstract Sets `nil` values for the selected keys.
 @discussion The value always will be overridden. It removs the from the `NSUserDefaults`.
 @param name The set of keys, which are UIResponder window affected.
 @since 1.0+
 @see MTViewController
 */
- (void)name:(NSString *)name;
@end
