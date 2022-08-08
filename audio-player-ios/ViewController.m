//
//  ViewController.m
//  audio-player-ios
//
//  Created by DinhPhuc on 12/07/2021.
//

#import <Foundation/Foundation.h>
#import "ViewController.h"

@interface ViewController () <NSURLSessionDataDelegate> {
    SigmaAudioPlayer *smAudioPlayer;
    int currentIndex;
    NSArray *playList;
    CGSize keyboardSize;
    NSString* otherUri;
}

- (void) handleKeyboardStateChange;
- (void) keyboardShow:(NSNotification*)notification;
- (void) keyboardHide:(NSNotification*)notification;
- (void) spinLogoView;
- (NSString*) timeToString: (int)time;
- (NSString*) getDocumentsDir;
- (void) start;
@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    playList = [NSArray arrayWithObjects:
                @"khen_mo_128kbps.mp3",
                @"other_file.mp3",
                @"https://pgdvqbnmsaobj.vcdn.cloud/mediahub/output/Kc4rW-SFUxl-C2Ddtwruh-khen-mo/mp3/128kbps.mp3",
//                @"https://pgdvqbnmsaobj.vcdn.cloud/mediahub/output/0dhE6y5f79TCDRJgmYaQG-loi-ru-ngan-xua-ho-quynh-huong/mp3/128kbps.mp3",
//                @"https://pgdvqbnmsaobj.vcdn.cloud/mediahub/output/RgrB0P9xMO51IxEmKYKuL-menh-mang-coi-thieu-anh-tho/mp3/128kbps.mp3",
//                @"https://pgdvqbnmsaobj.vcdn.cloud/mediahub/output/YIuCtGsv2c3thlX4TOYos-ninh-binh-ngay-ve-thuy-chi/mp3/128kbps.mp3",
//                @"https://pgdvqbnmsaobj.vcdn.cloud/mediahub/output/pIJy_6gG-DK_UK3EMIIGh-me-oi-con-muon-tro-ve-ngoc-anh/mp3/128kbps.mp3",
//                @"https://pgdvqbnmsaobj.vcdn.cloud/mediahub/output/w5RElq0Fr_JJBZA7eLDNd-hay-nhuom-gio-bien-khoi/mp3/128kbps.mp3",
                nil];
    
    otherUri = @"https://pgdvqbnmsaobj.vcdn.cloud/mediahub/output/0dhE6y5f79TCDRJgmYaQG-loi-ru-ngan-xua-ho-quynh-huong/mp3/128kbps.mp3";
    [self spinLogoView];
    [self handleKeyboardStateChange];
    currentIndex = -1;
    smAudioPlayer = [[SigmaAudioPlayer alloc]init];
    [smAudioPlayer setDelegate:self];
    //    smAudioPlayer.loop = TRUE;
    //    NSDictionary *appConfig = @{
    //        @"merchantId": @"sctv",
    //        @"appId": @"RedTV",
    //        @"userId": @"123456797",
    //        @"sessionId": @"12346578"};
    //
    NSDictionary *appConfig = @{
        @"merchantId": @"thudojsc",
        @"appId": @"MediaHub",
        @"userId": @"g-5F6QRRAEDK",
        @"sessionId": @"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzZGkiOiJ7XCJ1c2VyXCI6XCJnLTVGNlFSUkFFREtcIixcIm1lcmNoYW50XCI6XCJ0aHVkb2pzY1wiLFwiYXNzZXRJZFwiOlwiNjE4OGVhMmUxNDBkYmM0YmE0NmQ2MWU2XCJ9IiwiaWF0IjoxNjM5NjQzMjE3LCJleHAiOjE2Mzk2NDY4MTd9._qFz6l_3e-6tBu_D38bPrY_B9sZNqpwq9vgiIZXENrU"};
    [smAudioPlayer setAppConfig:appConfig];
}

- (void) spinLogoView{
    [UIView animateWithDuration:2.0f delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        [self.logo setTransform:CGAffineTransformRotate(self.logo.transform, M_PI)];
    }completion:^(BOOL finished){
        if (finished) {
            [self spinLogoView];
        }
    }];
}

- (void) handleKeyboardStateChange{
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardDidShowNotification object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardDidHideNotification object:nil];
}

- (void) keyboardShow:(NSNotification*)notification{
    keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    CGRect cr = [self.saveOtherFileView frame];
    CGRect rect =  CGRectMake(cr.origin.x,
                              cr.origin.y - keyboardSize.height,
                              cr.size.width,
                              cr.size.height);
    [self.saveOtherFileView setFrame:rect];
}
- (void) keyboardHide:(NSNotification*)notification{
    CGRect cr = [self.saveOtherFileView frame];
    CGRect rect =  CGRectMake(cr.origin.x,
                              cr.origin.y + keyboardSize.height,
                              cr.size.width,
                              cr.size.height);
    [self.saveOtherFileView setFrame:rect];
}


- (IBAction)seek:(id)sender {
    smAudioPlayer.currentTime = self.seekBar.value;
}

- (void) start {
    NSString* path = [playList objectAtIndex:currentIndex];
    BOOL isOnline = [smAudioPlayer isURL:path];
    [smAudioPlayer play:isOnline? path : [[self getDocumentsDir] stringByAppendingPathComponent:path]];
    [_pathLabel setText:path];
}

- (IBAction)play:(id)sender {
    if([smAudioPlayer getPlayerState] == PLS_INIT){
        [self start];
    }else if([smAudioPlayer isPlaying]){
        [smAudioPlayer pause];
    }else{
        [smAudioPlayer resume];
    }
}

- (IBAction)playPreAudio:(id)sender {
    currentIndex--;
    if(currentIndex < 0){
        currentIndex = (int)[playList count] - 1;
    }
    [self start];
}

- (IBAction)playNextAudio:(id)sender {
    currentIndex++;
    if(currentIndex >= [playList count]){
        currentIndex = 0;
    }
    [self start];
}

- (NSString*) getDocumentsDir{
    NSString *documentDir = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    return documentDir;
}

- (IBAction) saveFile:(id)sender {
    NSString* documentDir = [self getDocumentsDir];
    NSString *filePath = [documentDir stringByAppendingPathComponent:@"khen_mo_128kbps.mp3"];
    [smAudioPlayer saveFileWithPath:filePath];
}

- (IBAction)saveOtherFile:(id)sender {
    NSString* documentDir = [self getDocumentsDir];
    NSString *filePath = [documentDir stringByAppendingPathComponent:@"other_file.mp3"];
    [smAudioPlayer saveOtherFileWithUrl:otherUri andFilePath:filePath];
}

- (void) onFileSavedWithUrl:(NSString *)url andFilePath:(NSString *)filePath {
    NSLog(@" ======> filePath %@", filePath);
    NSString *message = [[NSString alloc] initWithFormat:@"Content of:\n %@\n Storage at:\n %@",url,filePath];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alert animated:YES completion:nil];
    dispatch_async(dispatch_get_main_queue(), ^{
        [alert dismissViewControllerAnimated:YES completion:nil];
    });
}

- (void) onLoadStart{
    NSLog(@"\t* LoadStart");
}

- (void) onLoaded{
    NSLog(@"\t* Loaded");
}

- (void) onStateChange:(enum PLAYER_STATE)state{
    if(state == PLS_RUNNING){
        if (@available(iOS 13.0, *)) {
            [self.playBtn setBackgroundImage:[UIImage systemImageNamed:@"pause.circle.fill"] forState:UIControlStateNormal];
        } else {
            // Fallback on earlier versions
        }
    }else if(state == PLS_LOADING){
        if (@available(iOS 13.0, *)) {
            [self.playBtn setBackgroundImage:[UIImage systemImageNamed:@"slowmo"] forState:UIControlStateNormal];
        } else {
            // Fallback on earlier versions
        }
    } else {
        if (@available(iOS 13.0, *)) {
            [self.playBtn setBackgroundImage:[UIImage systemImageNamed:@"play.circle.fill"] forState:UIControlStateNormal];
        } else {
            // Fallback on earlier versions
        }
    }
}

- (void) onProgress:(float)percent{
        NSLog(@"\t* Progress %.2f", percent);
    [self.currentProgressView setProgress:(percent / 100.0)];
    if(percent == 100){
        self.currentProgressView.progress = 0.0;
    }
}

- (void) onFileSavingWithUrl:(NSString *)url andFilePath:(NSString *)filePath withPercent:(float)percent{
    NSLog(@"\t* onFileSavingWithUrl %.2f", percent);
    [self.otherProgressView setProgress:(percent / 100.0)];
    if(percent == 100){
        self.otherProgressView.progress = 0.0;
    }
}

- (NSString*) timeToString: (int)time{
    int hours = (int)time / 3600;
    int minutes = (int)time / 60 % 60;
    int seconds = (int)time % 60;
    return !!hours ? [NSString stringWithFormat:@"%02i:%02i:%02i", hours, minutes, seconds] : [NSString stringWithFormat:@"%02i:%02i", minutes, seconds];
}

- (void) onDurationChange:(float)duration{
    NSLog(@"\t* DurationChange %f", duration);
    self.seekBar.maximumValue = duration;
    self.durationLabel.text = [self timeToString:duration];
}

- (void) onCanPlay{
    NSLog(@"\t* CanPlay");
}

- (void) onTimeUpdate:(float)currentTime{
    NSLog(@"\t* TimeUpdate %f", smAudioPlayer.currentTime);
    self.currentTimeLabel.text = [self timeToString:currentTime];
    self.seekBar.value = currentTime;
}

- (void) onEnded{
    NSLog(@"\t* Ended");
}

- (void) onError:(NSString *)errorMessage{
    NSLog(@"Error %@", errorMessage);
}
@end
