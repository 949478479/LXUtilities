//
//  NSData+LXExtension.m
//
//  Created by 从今以后 on 16/3/16.
//  Copyright © 2016年 从今以后. All rights reserved.
//

#import <CommonCrypto/CommonDigest.h>
#import "NSData+LXExtension.h"

NS_ASSUME_NONNULL_BEGIN

@implementation NSData (LXExtension)

- (NSString *)lx_MD5
{
	unsigned char digest[CC_MD5_DIGEST_LENGTH];

	CC_MD5([self bytes], (CC_LONG)[self length], digest);

	NSString *MD5String = [NSString stringWithFormat:
						   @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
						   digest[0], digest[1],
						   digest[2], digest[3],
						   digest[4], digest[5],
						   digest[6], digest[7],
						   digest[8], digest[9],
						   digest[10], digest[11],
						   digest[12], digest[13],
						   digest[14], digest[15]];
	return MD5String;
}

@end

NS_ASSUME_NONNULL_END
