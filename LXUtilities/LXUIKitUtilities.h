//
//  LXUIKitUtilities.h
//
//  Created by 从今以后 on 15/11/20.
//  Copyright © 2015年 apple. All rights reserved.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

///--------------
/// @name 设备信息
///--------------

BOOL LXDeviceIsPad();

///----------------------------
/// @name UIApplicationDelegate
///----------------------------

id<UIApplicationDelegate> LXAppDelegate();

///-----------
/// @name 屏幕
///-----------

CGSize LXScreenSize();
CGFloat LXScreenScale();

///-----------
/// @name 窗口
///-----------

UIWindow * LXKeyWindow();
UIWindow * LXTopWindow();

///------------
/// @name 控制器
///------------

UIViewController * LXTopViewController();
UIViewController * LXRootViewController();

NS_ASSUME_NONNULL_END
