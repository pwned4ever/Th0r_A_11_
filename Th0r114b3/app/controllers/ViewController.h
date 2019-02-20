#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "common.h"

#define __FILENAME__ (__builtin_strrchr(__FILE__, '/') ? __builtin_strrchr(__FILE__, '/') + 1 : __FILE__)

//static NSString *message = nil;
#define SETMESSAGE(msg) (message = msg)

#define _assert(test, message, fatal) do \
printf("__assert(%d:%s)@%s:%u[%s]", saved_errno, #test, __FILENAME__, __LINE__, __FUNCTION__); \

typedef kern_return_t (*v1ntex_cb_t)(task_t kernel_task, kptr_t kbase, void* data);



@interface ViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, AVAudioPlayerDelegate> {
    IBOutlet UIImageView *_logoView;
    IBOutlet UIStackView *_jailbreakButtonStackView;
    IBOutlet UIStackView *_creditsLabelStackView;
    IBOutlet UIView *_bottomPanelView;
    IBOutlet UIView *_tweaksContainerView;
    IBOutlet UIPickerView *myUiPickerView;
    
    SystemSoundID PlaySoundID1;
    AVAudioPlayer *audioPlayer1;
    
    
}


@property (weak, nonatomic) IBOutlet UIButton *jailbreak;
@property (weak, nonatomic) IBOutlet UIButton *setNonce;
@property (weak, nonatomic) IBOutlet UIButton *mywebsite;

@property (weak, nonatomic) IBOutlet UISwitch *enableTweaks;
@property (weak, nonatomic) IBOutlet UILabel *EndgameLabel;
@property (weak, nonatomic) IBOutlet UILabel *compatibilityLabel;

+ (instancetype)currentViewController;
- (void)removingLiberiOS;
- (void)removingJailbreak;
- (void)cyforceJailbreak;
//- (void)RemoveJBmeV;

extern bool newTFcheckofCyforce;
extern bool JUSTremovecheck;

//- (IBAction) btnLaunchNuclearStrikeClicked:(id)sender;
//- (IBAction) deleteButtonClicked:(id)sender;

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;
extern bool newTFcheckMyRemover4me;
//- (void)reinstallCydiaCyforce;
- (void)installingCydia;
- (void)removingJailbreaknotice;
- (void)newwaiting;
- (void)startdwait;
- (void)semiworkin;
- (void)canaryPwait;
- (void)canarySwait;
- (void)canarySLwait;
- (void)wait4jailbreakd;
- (void)rmounting;
int _system(const char *cmd);
int systemf(const char *cmd, ...);

- (void)checkingJUSTremovecheck;
- (void)waitupdatespring;
//- (void)newoptS;
//- (void)whatoptselected;
- (void)almostdone;
- (void)waittermkernel;
- (void)waitfaketfp;
- (void)Vouchermessage;
- (void)runningpatches;
- (void)runningexploit;
- (void)serverS;
- (void)cydiaDone;
- (void)JBremoverIsDone;
- (void)displaySnapshotNotice;
- (void)displaySnapshotWarning;
- (void)restarting;

@end

