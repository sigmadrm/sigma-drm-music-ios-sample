//
//  SigmaAudioPlayer.h
//  audio-player-ios
//
//  Created by DinhPhuc on 13/07/2021.
//

#ifndef Player_h
#define Player_h

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "SmUtils.h"

@protocol SigmaAudioPlayerDelegate <NSObject>
@required
@optional
// Events Listener
- (void) onLoadStart;
- (void) onProgress:(float)percent;
- (void) onLoaded;
- (void) onCanPlay;
- (void) onStateChange:(enum PLAYER_STATE)state;
- (void) onTimeUpdate:(float)currentTime;
- (void) onDurationChange:(float)duration;
- (void) onEnded;
- (void) onError:(NSString*)errorMessage;
- (void) onInterruptionBegan;
- (void) onInterruptionEnded;
- (void) onFileSavingWithUrl:(NSString*)url andFilePath:(NSString*)filePath withPercent:(float)percent;
- (void) onFileSavedWithUrl:(NSString*)url andFilePath:(NSString *)filePath;
@end

@interface SigmaAudioPlayer : NSObject
@property (nonatomic, readwrite) float currentTime;
@property (nonatomic, readwrite) float volume;
@property (nonatomic, readwrite) BOOL loop;
@property (nonatomic, readwrite) float playbackRate;
@property (nonatomic, readwrite) float duration;
@property (nonatomic, readwrite) float timePerLoop;

- (enum PLAYER_STATE) getPlayerState;
- (void) setDelegate:(id)delegate;
- (void) setAppConfig:(NSDictionary *) appConfig;
- (BOOL) isPlaying;
- (void) play:(NSString*) url;
- (void) resume;
- (void) pause;
- (void) stop;
- (void) saveFileWithPath:(NSString*)filePath;
- (void) saveOtherFileWithUrl:(NSString*)url andFilePath:(NSString*)filePath;
- (BOOL) isURL:(NSString*)path;
@end

#endif /* Player_h */
