//
//  ViewController.h
//  audio-player-ios
//
//  Created by DinhPhuc on 12/07/2021.
//


#import <UIKit/UIKit.h>
#import <SigmaDRMAudio/SigmaAudioPlayer.h>

@interface ViewController : UIViewController <SigmaAudioPlayerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *pathLabel;
@property (weak, nonatomic) IBOutlet UIImageView *logo;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (weak, nonatomic) IBOutlet UIButton *preBtn;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@property (weak, nonatomic) IBOutlet UISlider *seekBar;
@property (weak, nonatomic) IBOutlet UIProgressView *currentProgressView;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentTimeLabel;
@property (weak, nonatomic) IBOutlet UIView *saveOtherFileView;
@property (weak, nonatomic) IBOutlet UITextField *otherUrlInput;
@property (weak, nonatomic) IBOutlet UIButton *saveOtherFileBtn;
@property (weak, nonatomic) IBOutlet UIProgressView *otherProgressView;
@end

