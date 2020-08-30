//
//  AppDelegate.m
//  CustomScrollView
//
//  Created by Ole Begemann on 16.04.14.
//  Copyright (c) 2014 Ole Begemann. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  self.window.backgroundColor = [UIColor greenColor];
  ViewController *viewController = [[ViewController alloc] initWithNibName:nil bundle:nil];
  UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
  self.window.rootViewController = navigationController;
  [self.window makeKeyAndVisible];
  return YES;
}

@end
