//
//  SmUtils.h
//  SigmaDRM
//
//  Created by DinhPhuc on 28/02/2022.
//  Copyright © 2022 NguyenVanSao. All rights reserved.
//

#ifndef SmUtils_h
#define SmUtils_h
#import <Foundation/Foundation.h>

enum PLAYER_STATE
{
    PLS_INIT = 0,
    PLS_RUNNING,
    PLS_SUSPENDED,
    PLS_LOADING,
    PLS_STOPPED,
    PLS_FREE
};

enum PHASE_STATE
{
    PHASE_INIT = 0,
    PHASE_LOAD_START,
    PHASE_LOAD_PROGRESS,
    PHASE_LOADED,
    PHASE_ENDED
};
enum PLAYER_ERROR
{
    ERR_NETWORK_ERROR,
    ERR_GET_LICENSE_FAIL,
    ERR_DECRYPT_FAIL
};
enum TaskState
{
    TS_NOT_INIT = 0,
    TS_RUNNING,
    TS_DONE
};

@interface SmUtils : NSObject
+(bool) isURL:(NSString*) path;
+(NSString*) getDocumetsDir;
+(NSData*)hexStrToData:(NSString*)hexStr;
@end

#endif /* SmUtils_h */
