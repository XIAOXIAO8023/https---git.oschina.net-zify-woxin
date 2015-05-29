//
//  YBColorDef.h
//  YearBill
//
//  Created by 陆楠 on 15/3/17.
//  Copyright (c) 2015年 lunan. All rights reserved.
//

#ifndef YearBill_YBColorDef_h
#define YearBill_YBColorDef_h

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define COMMON_PURPLE 0x56539a

#define TITLE_GREEN   0xcbea7f
#define TITLE_ORANGE  0xe26233

#define BILL_YELLOW   0xf8d35e
#define BILL_BLUE     0x4ec6e7
#define BILL_ORANGE   0xef614d
#define BILL_PURPLE   0x868ad1

#define JD_GREEN      0x98ca54
#define JD_BLUE       0x2a6ffd

#endif
