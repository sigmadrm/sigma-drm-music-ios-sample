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

static NSString* CANNOT_INIT_PLAYER = @"CANNOT_INIT_PLAYER";
static NSString* CANNOT_SAVE_FILE = @"CANNOT_SAVE_FILE";
static NSString* REQUEST_LICENSE_FAIL = @"REQUEST_LICENSE_FAIL";
static NSString* UNKNOWN_ERROR = @"UNKNOWN_ERROR";
static NSString* DOWNLOAD_ERROR = @"DOWNLOAD_ERROR";
static NSString* FILE_NO_SUCH = @"FILE_NO_SUCH";
static NSString* PK_RETURN_EXPIRED = @"PK_EXPIRED";
static NSString* PK_RETURN_NOT_EXIST = @"PK_NOT_EXIST";
static NSString* DOWNLOAD_NOT_FOUND = @"DOWNLOAD_NOT_FOUND";
static NSString* DOWNLOAD_SERVER_ERROR = @"DOWNLOAD_SERVER_ERROR";

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
