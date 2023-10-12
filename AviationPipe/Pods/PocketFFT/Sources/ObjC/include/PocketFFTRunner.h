#import <Foundation/Foundation.h>

@interface PocketFFTRunner: NSObject

+ (int)execute_dct:(double *)a1 result:(double *)resultArray dctType:(int)dctType inorm:(int)inorm cols:(int)cols rows:(int)rows;


@end
