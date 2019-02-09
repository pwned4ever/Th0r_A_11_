///modified  by Marcel C (pwned4ever) 01/08/2018

#import "ViewController.h"
#include "../../headers/codesign.h"
#include "../../post-exploit/electra.h"

#include "../../headers/reboot.h"
#include "../../exploit/multi_path/multi_path_sploit.h"
#include "../../exploit/empty_list/vfs_sploit.h"
#include "../../post-exploit/electra_objc.h"

#include "../../exploit/vouch_4ya/kernel_memory.h"
#include "../../exploit/common/offsets.h"
#include <sys/sysctl.h>
#include "../../post-exploit/utilities/file_utils.h"
#include "../../post-exploit/utilities/utils.h"
#include "../../post-exploit/utilities/amfi_utils.h"
#include "../../post-exploit/utilities/kutils.h"
#include "Foundation/Foundation.h"
#include "../../exploit/vouch_4ya/voucher_swap.h"
#include "../../post-exploit/utilities/KernelMemory.h"
@interface ViewController ()
@end
NSArray *_pickviewarray;

static ViewController *currentViewController;

@implementation ViewController
//NSArray *whatStringPickerViewOptionIsSelected = @[@"Jailbreak",@"Enable",@"Remove JB",@"Share",@"CyF0rc3"];

#define localize(key) NSLocalizedString(key, @"")
#define postProgress(prg) [[NSNotificationCenter defaultCenter] postNotificationName: @"JB" object:nil userInfo:@{@"JBProgress": prg}]

//#define pwned4ever_URL "https://www.dropbox.com/s/7ynb8eotrp2ycc3/Th0r-2.ipa"

#define pwned4ever_URL "https://www.dropbox.com/s/stnh0out4tkoces/Th0r.ipa"
#define pwned4ever_TEAM_TWITTER_HANDLE "pwned4ever"
#define K_ENABLE_TWEAKS "enableTweaks"

+ (instancetype)currentViewController {
    return currentViewController;
}

// thx DoubleH3lix - thanks t1hmstar

double uptime(){
    struct timeval boottime;
    size_t len = sizeof(boottime);
    int mib[2] = { CTL_KERN, KERN_BOOTTIME };
    if( sysctl(mib, 2, &boottime, &len, NULL, 0) < 0 )
    {
        return -1.0;
    }
    time_t bsec = boottime.tv_sec, csec = time(NULL);
    
    return difftime(csec, bsec);
}
- (IBAction)stopbtnMusic:(id)sender {
    NSString *music=[[NSBundle mainBundle]pathForResource:@"LuckyU" ofType:@"mp3"];
    audioPlayer1=[[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:music]error:NULL];
    audioPlayer1.delegate=self;
    //audioPlayer1.volume=-5;
    //audioPlayer1.numberOfLoops=-1;
    //[audioPlayer1 play];
    [audioPlayer1 stop];
}
- (IBAction)startmusic:(id)sender {
    NSString *music=[[NSBundle mainBundle]pathForResource:@"LuckyU" ofType:@"mp3"];
    audioPlayer1=[[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:music]error:NULL];
    audioPlayer1.delegate=self;
    audioPlayer1.volume=-3;
    audioPlayer1.numberOfLoops=-1;
    [audioPlayer1 play];
    //[audioPlayer1 stop];}
}

-(void)updateProgressFromNotification:(id)sender{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *prog=[sender userInfo][@"JBProgress"];
        NSLog(@"Progress: %@",prog);
        [_jailbreak setEnabled:NO];
        [_jailbreak setAlpha:1];
        [_enableTweaks setEnabled:NO];
        [_setNonce setEnabled:NO];
        [_jailbreak setTitle:prog forState:UIControlStateNormal];
    });
}

- (void)shareTh0rRemover {
    struct utsname u = { 0 };
    uname(&u);
    [self.jailbreak setEnabled:NO];
    [self.jailbreak setHidden:YES];
    [NSString stringWithUTF8String:u.machine];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul), ^{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"𝓢Ⓗ⒜𝕽ᴱ JB Remover?", nil) message:NSLocalizedString(@"Are you sure you want to Share JB Remover?💣", nil) preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *OK = [UIAlertAction actionWithTitle:NSLocalizedString(@"Sharing is caring", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[[NSString stringWithFormat:localize(@"I'm using Th0r 1.5.2-1 END GAME - Jailbreak Remover Toolkit for iOS 11.0 - 11.4(b3), Updated 01/28/19 1:20PM-EDT. By:@%@ 🍻, to remove the jailbreak on my %@ iOS %@. You can download it now @ %@" ), @pwned4ever_TEAM_TWITTER_HANDLE, [NSString stringWithUTF8String:u.machine],[[UIDevice currentDevice] systemVersion], @pwned4ever_URL]] applicationActivities:nil];
                activityViewController.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeCopyToPasteboard, UIActivityTypeAssignToContact, UIActivityTypeSaveToCameraRoll, UIActivityTypeAirDrop, UIActivityTypeOpenInIBooks, UIActivityTypeMarkupAsPDF];
                if ([activityViewController respondsToSelector:@selector(popoverPresentationController)] ) {
                    activityViewController.popoverPresentationController.sourceView = _jailbreak;
                }
                [self presentViewController:activityViewController animated:YES completion:nil];
                [self.jailbreak setEnabled:NO];
                [self.jailbreak setHidden:YES];
                unlink("/var/mobile/Media/.bootstrapped_electraremover");
            });
            
        }];
        UIAlertAction *Cancel = [UIAlertAction actionWithTitle:NSLocalizedString(@"No - I'm greedy", nil) style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            dispatch_async(dispatch_get_main_queue(), ^{
                //
                [self.jailbreak setEnabled:NO];
                [self.jailbreak setHidden:YES];
            });
        }];
        [alertController addAction:OK];
        [alertController addAction:Cancel];
        [alertController setPreferredAction:Cancel];
        [self presentViewController:alertController animated:YES completion:nil];
    });
}

- (void)shareTh0r {
    struct utsname u = { 0 };
    uname(&u);
    //[self.jailbreak setEnabled:NO];
    //[self.jailbreak setHidden:YES];
    [NSString stringWithUTF8String:u.machine];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul), ^{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Wanna Share Th0r Jailbreak", nil) message:NSLocalizedString(@"𝓢Ⓗ⒜𝕽ᴱ Th0r 👍🏽 Jailbreak?", nil) preferredStyle:UIAlertControllerStyleAlert];UIAlertAction *OK = [UIAlertAction actionWithTitle:NSLocalizedString(@"Ya of course", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.jailbreak setEnabled:YES];
                UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[[NSString stringWithFormat:localize(@"I'm using Th0r 1.5.2-1 END GAME - Jailbreak Toolkit for iOS 11.0 - 11.4(b3), Updated 01/28/19 1:20PM-EDT. By:@%@ 🍻, to jailbreak my %@ iOS %@. You can download it now @ %@" ), @pwned4ever_TEAM_TWITTER_HANDLE, [NSString stringWithUTF8String:u.machine],[[UIDevice currentDevice] systemVersion], @pwned4ever_URL]] applicationActivities:nil];
                activityViewController.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeCopyToPasteboard, UIActivityTypeAssignToContact, UIActivityTypeSaveToCameraRoll, UIActivityTypeAirDrop, UIActivityTypeOpenInIBooks, UIActivityTypeMarkupAsPDF];
                if ([activityViewController respondsToSelector:@selector(popoverPresentationController)] ) {
                    activityViewController.popoverPresentationController.sourceView = _jailbreak;
                }
                [self presentViewController:activityViewController animated:YES completion:nil];
                [self.jailbreak setEnabled:NO];
                [self.jailbreak setHidden:YES];
            });
        }];
        UIAlertAction *Cancel = [UIAlertAction actionWithTitle:NSLocalizedString(@"Nah, don't want anyone to know", nil) style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.jailbreak setEnabled:YES];
                //[self.jailbreak setHidden:YES];
            });
        }];
        [alertController addAction:OK];
        [alertController addAction:Cancel];
        [alertController setPreferredAction:Cancel];
        [self presentViewController:alertController animated:YES completion:nil];
    });
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    myUiPickerView.delegate = self;
    myUiPickerView.dataSource = self;
   // newTFcheckMyRemover4me =0;
    NSString *music=[[NSBundle mainBundle]pathForResource:@"LuckyU" ofType:@"mp3"];
    audioPlayer1=[[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:music]error:NULL];
    audioPlayer1.delegate=self;
    audioPlayer1.volume=-3;
    audioPlayer1.numberOfLoops=-1;
    [audioPlayer1 play];
    /**/
    uint32_t flags;
    csops(getpid(), CS_OPS_STATUS, &flags, 0);
    //"/var/mobile/Media/.bootstrapped_electraremover"
    //int rv = open("/var/mobile/Media/.bootstrapped_electraremover", O_RDWR|O_CREAT);
    //close(rv);
    //printf("hey CREATED testremover?: %d", rv);
    int checkuncovermarker = (file_exists("/.installed_unc0ver"));
    int checkth0rmarker = (file_exists("/.bootstrapped_Th0r"));
    int checkelectramarker = (file_exists("/.bootstrapped_electra"));
    int checkJBRemoverMarker = (file_exists("/var/mobile/Media/.bootstrapped_electraremover"));
    int checkjailbreakdRun = (file_exists("/var/run/jailbreakd.pid"));
    int checkpspawnhook = (file_exists("/var/run/pspawn_hook.ts"));
    
    printf("Uncover marker exists?: %d\n",checkuncovermarker);
    printf("Uncover marker exists?: %d\n",checkuncovermarker);
    printf("JBRemover marker exists?: %d\n",checkJBRemoverMarker);
    printf("Th0r marker exists?: %d\n",checkth0rmarker);
    printf("Electra marker exists?: %d\n",checkelectramarker);
    printf("Jailbreakd Run marker exists?: %d\n",checkjailbreakdRun);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateProgressFromNotification:) name:@"JB" object:nil];
    
    
    NSNotificationCenter* notificationCenter = [NSNotificationCenter defaultCenter];
    
    BOOL enable3DTouch = YES;
    
    switch (offsets_init()) {
        case ERR_NOERR: {
            break;
        }
        case ERR_VERSION: {
            [_jailbreak setEnabled:NO];
            [_jailbreak setAlpha:0.5];
            [_enableTweaks setEnabled:NO];
            [_jailbreak setTitle:localize(@"Version Error😡") forState:UIControlStateNormal];
            
            enable3DTouch = NO;
            break;
        }
        default: {
            [_jailbreak setEnabled:NO];
            [_jailbreak setAlpha:0.5];
            [_enableTweaks setEnabled:NO];
            [_jailbreak setTitle:localize(@"Error: offsets😡") forState:UIControlStateNormal];
            enable3DTouch = NO;
            break;
        }
    }
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults objectForKey:@K_ENABLE_TWEAKS] == nil) {
        [userDefaults setBool:YES forKey:@K_ENABLE_TWEAKS];
        [userDefaults synchronize];
    }
    BOOL enableTweaks = [userDefaults boolForKey:@K_ENABLE_TWEAKS];
    [_enableTweaks setOn:enableTweaks];

    if (enable3DTouch) {
        [notificationCenter addObserver:self selector:@selector(doit:) name:@"Journey 2 gRoot?" object:nil];
    }
    //(checkjailbreakdRun == 1) && (checkpspawnhook == 1) &&
    if ((checkjailbreakdRun == 1) && (checkpspawnhook == 0) && (checkth0rmarker == 1) && (checkJBRemoverMarker == 0) && (checkuncovermarker == 0) && (checkelectramarker == 0)){
        [_jailbreak setHidden:NO];
        [_jailbreak setTitle:localize(@"𝓢Ⓗ⒜𝕽ᴱ Th0r?") forState:UIControlStateNormal];
        _pickviewarray = @[@"𝓢Ⓗ⒜𝕽ᴱ Th0r👍🏽"];
        [self shareTh0r];
        goto end;
    }
    if ((checkjailbreakdRun == 1) && (checkpspawnhook == 0) && (checkJBRemoverMarker == 1) && (checkth0rmarker == 0) && (checkuncovermarker == 0) && (checkelectramarker == 0)){
        [_jailbreak setTitle:localize(@"𝓢Ⓗ⒜𝕽ᴱ JB Remover?") forState:UIControlStateNormal];
        _pickviewarray = @[@"𝓢Ⓗ⒜𝕽ᴱ JB Remover"];
        [_jailbreak setHidden:NO];
        goto end;
    }
    if ((checkjailbreakdRun == 0) && (checkpspawnhook == 1) && (checkJBRemoverMarker == 1) && (checkth0rmarker == 0) && (checkuncovermarker == 0) && (checkelectramarker == 0)){
        [_jailbreak setTitle:localize(@"𝓢Ⓗ⒜𝕽ᴱ JB Remover?") forState:UIControlStateNormal];
        _pickviewarray = @[@"𝓢Ⓗ⒜𝕽ᴱ JB Remover"];
        [_jailbreak setHidden:NO];
        goto end;
    }
    if ((checkjailbreakdRun == 1) && (checkpspawnhook == 0) && ((CS_PLATFORM_BINARY) && (checkJBRemoverMarker == 1) && (checkth0rmarker == 0) && (checkuncovermarker == 0) && (checkelectramarker == 0))){
        newTFcheckMyRemover4me = TRUE;
        [_jailbreak setTitle:localize(@"𝓢Ⓗ⒜𝕽ᴱ JB Remover?") forState:UIControlStateNormal];
        _pickviewarray = @[@"𝓢Ⓗ⒜𝕽ᴱ JB Remover"];
        [_jailbreak setHidden:NO];
        [self shareTh0rRemover];
        goto end;
    }
    if ((checkjailbreakdRun == 0) && (checkpspawnhook == 1) && ((CS_PLATFORM_BINARY) && (checkJBRemoverMarker == 1) && (checkth0rmarker == 0) && (checkuncovermarker == 0) && (checkelectramarker == 0))){
        newTFcheckMyRemover4me = TRUE;
        [_jailbreak setTitle:localize(@"𝓢Ⓗ⒜𝕽ᴱ JB Remover?") forState:UIControlStateNormal];
        _pickviewarray = @[@"𝓢Ⓗ⒜𝕽ᴱ JB Remover"];
        [_jailbreak setHidden:NO];
        [self shareTh0rRemover];
        goto end;
    }
    if ((checkjailbreakdRun == 0) && (checkpspawnhook == 0) && (newTFcheckMyRemover4me) && (checkJBRemoverMarker == 1)){
        newTFcheckMyRemover4me = TRUE;
        [_jailbreak setTitle:localize(@"Remove JB?") forState:UIControlStateNormal];
        goto end;
    }

    if ((checkjailbreakdRun == 1) && (checkpspawnhook == 0) && (checkth0rmarker == 1) && (checkuncovermarker == 1 )){
        _pickviewarray = @[@"Reboot"];
        [_jailbreak setTitle:localize(@"Reboot Please") forState:UIControlStateNormal];
        enable3DTouch = NO;
        testRebootcheck = TRUE;
        goto end;
    }
    if ((checkjailbreakdRun == 0) && (checkpspawnhook == 1) && (checkth0rmarker == 1) && (checkuncovermarker == 1 )){
        _pickviewarray = @[@"Reboot"];
        [_jailbreak setTitle:localize(@"Reboot Please") forState:UIControlStateNormal];
        enable3DTouch = NO;
        testRebootcheck = TRUE;
        goto end;
    }
    if ((checkjailbreakdRun == 0) && (checkpspawnhook == 1) && (checkth0rmarker == 0) && (checkuncovermarker == 1 )){
        _pickviewarray = @[@"Reboot"];
        testRebootcheck = TRUE;
        [_jailbreak setTitle:localize(@"Reboot unc0ver 1st") forState:UIControlStateNormal];
        enable3DTouch = NO;
        goto end;
    }
    if ((checkjailbreakdRun == 1) && (checkpspawnhook == 0) && (checkth0rmarker == 0) && (checkuncovermarker == 1 )){
        _pickviewarray = @[@"Reboot"];
        testRebootcheck = TRUE;
        [_jailbreak setTitle:localize(@"Reboot unc0ver 1st") forState:UIControlStateNormal];
        enable3DTouch = NO;
        goto end;
    }
    if ((checkjailbreakdRun == 1) && (checkpspawnhook == 1) && (checkth0rmarker == 0) && (checkuncovermarker == 1 )){
        _pickviewarray = @[@"Reboot"];
        testRebootcheck = TRUE;
        [_jailbreak setTitle:localize(@"Reboot unc0ver 1st") forState:UIControlStateNormal];
        enable3DTouch = NO;
        goto end;
    }
    if ((checkjailbreakdRun == 1) && (checkpspawnhook == 0) && (checkth0rmarker == 1) && (checkelectramarker == 1 )){
        _pickviewarray = @[@"Reboot"];
        testRebootcheck = TRUE;
        [_jailbreak setTitle:localize(@"Reboot Please") forState:UIControlStateNormal];
        enable3DTouch = NO;
        goto end;
    }
    if ((checkjailbreakdRun == 0) && (checkpspawnhook == 1) && (checkth0rmarker == 1) && (checkelectramarker == 1 )){
        _pickviewarray = @[@"Reboot"];
        testRebootcheck = TRUE;
        [_jailbreak setTitle:localize(@"Reboot Please") forState:UIControlStateNormal];
        enable3DTouch = NO;
        goto end;
    }
    if ((checkjailbreakdRun == 1) && (checkpspawnhook == 1) && (checkth0rmarker == 1) && (checkelectramarker == 1 )){
        _pickviewarray = @[@"Reboot"];
        testRebootcheck = TRUE;
        [_jailbreak setTitle:localize(@"Reboot Please") forState:UIControlStateNormal];
        enable3DTouch = NO;
        goto end;
    }
    if ((checkjailbreakdRun == 1) && (checkpspawnhook == 0) && (checkth0rmarker == 0) && (checkelectramarker == 1 )){
        _pickviewarray = @[@"Reboot"];
        testRebootcheck = TRUE;
        [_jailbreak setTitle:localize(@"Reboot electra 1st") forState:UIControlStateNormal];
        enable3DTouch = NO;
        goto end;
    }
    if ((checkjailbreakdRun == 0) && (checkpspawnhook == 1) && (checkth0rmarker == 0) && (checkelectramarker == 1 )){
        _pickviewarray = @[@"Reboot"];
        testRebootcheck = TRUE;
        [_jailbreak setTitle:localize(@"Reboot electra 1st") forState:UIControlStateNormal];
        enable3DTouch = NO;
        goto end;
    }
    if ((checkjailbreakdRun == 1) && (checkpspawnhook == 1) && (checkth0rmarker == 0) && (checkelectramarker == 1 )){
        _pickviewarray = @[@"Reboot"];
        testRebootcheck = TRUE;
        [_jailbreak setTitle:localize(@"Reboot electra 1st") forState:UIControlStateNormal];
        enable3DTouch = NO;
        goto end;
    }
    if (((checkjailbreakdRun == 0) && (checkpspawnhook == 0) && (checkth0rmarker == 1) && (checkuncovermarker == 1)) || ((checkjailbreakdRun == 0) && (checkpspawnhook == 0) && (checkth0rmarker == 1) && (checkelectramarker == 1))){
        _pickviewarray = @[@"Remove JB"];
        [_jailbreak setTitle:localize(@"Remove Jailbreak?") forState:UIControlStateNormal];
        newTFcheckMyRemover4me = TRUE;
        goto end;
    }
    
    if ((checkth0rmarker == 1) && (checkuncovermarker == 0) && (checkelectramarker == 0) && (checkjailbreakdRun == 0) && (checkpspawnhook == 0)){
        _pickviewarray = @[@"Enable JB",@"Remove JB",@"CyF0rc3"];
        [_jailbreak setTitle:localize(@"Enable gRoot?") forState:UIControlStateNormal];
        goto end;
    }
    if ((flags & CS_PLATFORM_BINARY) && (checkJBRemoverMarker ==1) && (checkuncovermarker ==1) && (checkjailbreakdRun == 1) && (checkpspawnhook == 0)){
        [_enableTweaks setEnabled:NO];
        testRebootcheck = TRUE;
        [_jailbreak setTitle:localize(@"Reboot unc0ver?") forState:UIControlStateNormal];
        printf("[*] Please reboot first\n");
        goto end;
        return;
    }
    if ((flags & CS_PLATFORM_BINARY) && (checkJBRemoverMarker ==1) && (checkuncovermarker ==1) && (checkjailbreakdRun == 0) && (checkpspawnhook == 1)){
        [_enableTweaks setEnabled:NO];
        testRebootcheck = TRUE;
        [_jailbreak setTitle:localize(@"Reboot unc0ver?") forState:UIControlStateNormal];
        printf("[*] Please reboot first\n");
        goto end;
        return;
    }
    if ((flags & CS_PLATFORM_BINARY) && (checkJBRemoverMarker ==1) && (checkuncovermarker ==1) && (checkjailbreakdRun == 1) && (checkpspawnhook == 1)){
        [_enableTweaks setEnabled:NO];
        testRebootcheck = TRUE;
        [_jailbreak setTitle:localize(@"Reboot unc0ver?") forState:UIControlStateNormal];
        printf("[*] Please reboot first\n");
        goto end;
        return;
    }
    
    if ((flags & CS_PLATFORM_BINARY) && (checkJBRemoverMarker ==1) && (checkelectramarker ==1) && (checkjailbreakdRun == 1) && (checkpspawnhook == 0)){
        [_enableTweaks setEnabled:NO];
        testRebootcheck = TRUE;
        [_jailbreak setTitle:localize(@"Reboot electra?") forState:UIControlStateNormal];
        goto end;
        return;
    }
    if ((flags & CS_PLATFORM_BINARY) && (checkJBRemoverMarker ==1) && (checkelectramarker ==1) && (checkjailbreakdRun == 0) && (checkpspawnhook == 1)){
        [_enableTweaks setEnabled:NO];
        testRebootcheck = TRUE;
        [_jailbreak setTitle:localize(@"Reboot electra?") forState:UIControlStateNormal];
        goto end;
        return;
    }
    if ((flags & CS_PLATFORM_BINARY) && (checkJBRemoverMarker ==1) && (checkelectramarker ==1) && (checkjailbreakdRun == 1) && (checkpspawnhook == 1)){
        [_enableTweaks setEnabled:NO];
        testRebootcheck = TRUE;
        [_jailbreak setTitle:localize(@"Reboot electra?") forState:UIControlStateNormal];
        goto end;
        return;
    }
    
    if ((flags & CS_PLATFORM_BINARY) && (checkJBRemoverMarker ==1) && (checkjailbreakdRun == 1) && (checkpspawnhook == 0)){
        [_enableTweaks setEnabled:NO];
        [_jailbreak setTitle:localize(@"Share JB Remover?") forState:UIControlStateNormal];
        [self shareTh0rRemover];
        return;
    }
    if ((flags & CS_PLATFORM_BINARY) && (checkJBRemoverMarker ==1) && (checkjailbreakdRun == 0) && (checkpspawnhook == 1)){
        [_enableTweaks setEnabled:NO];
        [_jailbreak setTitle:localize(@"Share JB Remover?") forState:UIControlStateNormal];
        [self shareTh0rRemover];
        return;
    }
    if ((flags & CS_PLATFORM_BINARY) && (checkJBRemoverMarker ==1) && (checkjailbreakdRun == 1) && (checkpspawnhook == 1)){
        [_enableTweaks setEnabled:NO];
        [_jailbreak setTitle:localize(@"Share JB Remover?") forState:UIControlStateNormal];
        [self shareTh0rRemover];
        return;
    }
    if ((flags & CS_PLATFORM_BINARY) && (checkuncovermarker ==1) && (checkjailbreakdRun == 1) && (checkpspawnhook == 0)){
        [_enableTweaks setEnabled:NO];
        testRebootcheck = TRUE;
        [_jailbreak setTitle:localize(@"Reboot unc0ver JB?") forState:UIControlStateNormal];
        goto end;
        return;
    }
    if ((flags & CS_PLATFORM_BINARY) && (checkuncovermarker ==1) && (checkjailbreakdRun == 0) && (checkpspawnhook == 1)){
        [_enableTweaks setEnabled:NO];
        testRebootcheck = TRUE;
        [_jailbreak setTitle:localize(@"Reboot unc0ver JB?") forState:UIControlStateNormal];
        goto end;
        return;
    }
    if ((flags & CS_PLATFORM_BINARY) && (checkuncovermarker ==1) && (checkjailbreakdRun == 1) && (checkpspawnhook == 1)){
        [_enableTweaks setEnabled:NO];
        testRebootcheck = TRUE;
        [_jailbreak setTitle:localize(@"Reboot unc0ver JB?") forState:UIControlStateNormal];
        goto end;
        return;
    }
    if ((flags & CS_PLATFORM_BINARY) && (checkelectramarker ==1) && (checkjailbreakdRun == 1) && (checkpspawnhook == 0)){
        [_enableTweaks setEnabled:NO];
        testRebootcheck = TRUE;
        [_jailbreak setTitle:localize(@"Reboot electra JB?") forState:UIControlStateNormal];
        goto end;
        return;
    }
    if ((flags & CS_PLATFORM_BINARY) && (checkelectramarker ==1) && (checkjailbreakdRun == 0) && (checkpspawnhook == 1)){
        [_enableTweaks setEnabled:NO];
        testRebootcheck = TRUE;
        [_jailbreak setTitle:localize(@"Reboot electra JB?") forState:UIControlStateNormal];
        goto end;
        return;
    }
    if ((flags & CS_PLATFORM_BINARY) && (checkelectramarker ==1) && (checkjailbreakdRun == 1) && (checkpspawnhook == 1)){
        [_enableTweaks setEnabled:NO];
        testRebootcheck = TRUE;
        [_jailbreak setTitle:localize(@"Reboot electra JB?") forState:UIControlStateNormal];
        goto end;
        return;
    }
    
    if ((checkpspawnhook == 0) && (checkth0rmarker == 0) && (checkuncovermarker == 1 ) && (checkjailbreakdRun == 1)){
        _pickviewarray = @[@"Reboot"];
        testRebootcheck = TRUE;
        [_jailbreak setTitle:localize(@"Reboot unc0ver 1st") forState:UIControlStateNormal];
        [_enableTweaks setEnabled:NO];
        goto end;
        return;
    }
    if ((checkpspawnhook == 1) && (checkth0rmarker == 0) && (checkuncovermarker == 1 ) && (checkjailbreakdRun == 0)){
        _pickviewarray = @[@"Reboot"];
        testRebootcheck = TRUE;
        [_jailbreak setTitle:localize(@"Reboot unc0ver 1st") forState:UIControlStateNormal];
        [_enableTweaks setEnabled:NO];
        goto end;
        return;
    }
    if ((checkpspawnhook == 1) && (checkth0rmarker == 0) && (checkuncovermarker == 1 ) && (checkjailbreakdRun == 1)){
        _pickviewarray = @[@"Reboot"];
        testRebootcheck = TRUE;
        [_jailbreak setTitle:localize(@"Reboot unc0ver 1st") forState:UIControlStateNormal];
        [_enableTweaks setEnabled:NO];
        goto end;
        return;
    }
    
    if ((checkuncovermarker == 1) && (checkpspawnhook == 0) && (checkth0rmarker == 0) && (checkjailbreakdRun == 0)){
        [_enableTweaks setEnabled:NO];
        [_jailbreak setTitle:localize(@"Remove unc0ver JB?") forState:UIControlStateNormal];
        _pickviewarray = @[@"Remove JB"];
        goto end;
        return;
    }
    if ((checkuncovermarker == 0) && (checkpspawnhook == 1) && (checkth0rmarker == 1) && (checkjailbreakdRun == 1)){
        [_enableTweaks setEnabled:NO];
        [_jailbreak setTitle:localize(@"Please Reboot 1st") forState:UIControlStateNormal];
        testRebootcheck = TRUE;
        _pickviewarray = @[@"Reboot"];
        goto end;
        return;
    }
    if ((checkuncovermarker == 1) && (checkpspawnhook == 1) && (checkth0rmarker == 1) && (checkjailbreakdRun == 0)){
        [_enableTweaks setEnabled:NO];
        [_jailbreak setTitle:localize(@"Please Reboot 1st") forState:UIControlStateNormal];
        testRebootcheck = TRUE;
        _pickviewarray = @[@"Reboot"];
        goto end;
        return;
    }
    if ((checkuncovermarker == 1) && (checkpspawnhook == 1) && (checkth0rmarker == 1) && (checkjailbreakdRun == 1)){
        [_enableTweaks setEnabled:NO];
        [_jailbreak setTitle:localize(@"Please Reboot 1st") forState:UIControlStateNormal];
        testRebootcheck = TRUE;
        _pickviewarray = @[@"Reboot"];
        goto end;
        return;
    }
    
    
    if ((checkpspawnhook == 0) && (checkuncovermarker == 1) && (checkelectramarker == 1) && (checkth0rmarker == 1) && (checkjailbreakdRun == 1)){
        _pickviewarray = @[@"Reboot"];
        testRebootcheck = TRUE;
        [_jailbreak setTitle:localize(@"Please Reboot 1st") forState:UIControlStateNormal];
        [_enableTweaks setEnabled:NO];
        [_enableTweaks setHidden:YES];
        goto end;
    }
    if ((checkpspawnhook == 1) && (checkuncovermarker == 1) && (checkelectramarker == 1) && (checkth0rmarker == 1) && (checkjailbreakdRun == 0)){
        _pickviewarray = @[@"Reboot"];
        testRebootcheck = TRUE;
        [_jailbreak setTitle:localize(@"Please Reboot 1st") forState:UIControlStateNormal];
        [_enableTweaks setEnabled:NO];
        [_enableTweaks setHidden:YES];
        goto end;
    }
    if ((checkpspawnhook == 1) && (checkuncovermarker == 1) && (checkelectramarker == 1) && (checkth0rmarker == 1) && (checkjailbreakdRun == 1)){
        _pickviewarray = @[@"Reboot"];
        testRebootcheck = TRUE;
        [_jailbreak setTitle:localize(@"Please Reboot 1st") forState:UIControlStateNormal];
        [_enableTweaks setEnabled:NO];
        [_enableTweaks setHidden:YES];
        goto end;
    }

    if ((checkpspawnhook == 0) && (checkjailbreakdRun == 1) && (checkuncovermarker == 0) && (checkelectramarker == 1) && (checkth0rmarker == 1)){
        _pickviewarray = @[@"Reboot"];
        testRebootcheck = TRUE;
        [_jailbreak setTitle:localize(@"Please Reboot 1st") forState:UIControlStateNormal];
        [_enableTweaks setEnabled:NO];
        [_enableTweaks setHidden:YES];
        goto end;
    }
    if ((checkpspawnhook == 1) && (checkjailbreakdRun == 0) && (checkuncovermarker == 0) && (checkelectramarker == 1) && (checkth0rmarker == 1)){
        _pickviewarray = @[@"Reboot"];
        testRebootcheck = TRUE;
        [_jailbreak setTitle:localize(@"Please Reboot 1st") forState:UIControlStateNormal];
        [_enableTweaks setEnabled:NO];
        [_enableTweaks setHidden:YES];
        goto end;
    }
    if ((checkpspawnhook == 1) && (checkjailbreakdRun == 1) && (checkuncovermarker == 0) && (checkelectramarker == 1) && (checkth0rmarker == 1)){
        _pickviewarray = @[@"Reboot"];
        testRebootcheck = TRUE;
        [_jailbreak setTitle:localize(@"Please Reboot 1st") forState:UIControlStateNormal];
        [_enableTweaks setEnabled:NO];
        [_enableTweaks setHidden:YES];
        goto end;
    }
    
    
    
    if ((checkpspawnhook == 0) && (checkjailbreakdRun == 1) && (checkuncovermarker == 1) && (checkelectramarker == 1) && (checkth0rmarker == 1)){
        _pickviewarray = @[@"Reboot"];
        testRebootcheck = TRUE;
        [_jailbreak setTitle:localize(@"Please Reboot 1st") forState:UIControlStateNormal];
        [_enableTweaks setEnabled:NO];
        [_enableTweaks setHidden:YES];
        goto end;
    }
    if ((checkpspawnhook == 1) && (checkjailbreakdRun == 0) && (checkuncovermarker == 1) && (checkelectramarker == 1) && (checkth0rmarker == 1)){
        _pickviewarray = @[@"Reboot"];
        testRebootcheck = TRUE;
        [_jailbreak setTitle:localize(@"Please Reboot 1st") forState:UIControlStateNormal];
        [_enableTweaks setEnabled:NO];
        [_enableTweaks setHidden:YES];
        goto end;
    }
    
    if ((checkpspawnhook == 1) && (checkjailbreakdRun == 1) && (checkuncovermarker == 1) && (checkelectramarker == 1) && (checkth0rmarker == 1)){
        _pickviewarray = @[@"Reboot"];
        testRebootcheck = TRUE;
        [_jailbreak setTitle:localize(@"Please Reboot 1st") forState:UIControlStateNormal];
        [_enableTweaks setEnabled:NO];
        [_enableTweaks setHidden:YES];
        goto end;
    }
    
    if ((checkpspawnhook == 0) && (checkjailbreakdRun == 1) && (checkuncovermarker == 0) && (checkelectramarker == 1) && (checkth0rmarker == 1)){
        _pickviewarray = @[@"Reboot"];
        testRebootcheck = TRUE;
        [_jailbreak setTitle:localize(@"Please Reboot 1st") forState:UIControlStateNormal];
        [_enableTweaks setEnabled:NO];
        [_enableTweaks setHidden:YES];
        goto end;
    }
    if ((checkpspawnhook == 1) && (checkjailbreakdRun == 0) && (checkuncovermarker == 0) && (checkelectramarker == 1) && (checkth0rmarker == 1)){
        _pickviewarray = @[@"Reboot"];
        testRebootcheck = TRUE;
        [_jailbreak setTitle:localize(@"Please Reboot 1st") forState:UIControlStateNormal];
        [_enableTweaks setEnabled:NO];
        [_enableTweaks setHidden:YES];
        goto end;
    }
    if ((checkpspawnhook == 1) && (checkjailbreakdRun == 1) && (checkuncovermarker == 0) && (checkelectramarker == 1) && (checkth0rmarker == 1)){
        _pickviewarray = @[@"Reboot"];
        testRebootcheck = TRUE;
        [_jailbreak setTitle:localize(@"Please Reboot 1st") forState:UIControlStateNormal];
        [_enableTweaks setEnabled:NO];
        [_enableTweaks setHidden:YES];
        goto end;
    }
    
    if ((checkpspawnhook == 0) && (checkjailbreakdRun == 1) && (checkuncovermarker == 1) && (checkelectramarker == 1) && (checkth0rmarker == 1)){
        _pickviewarray = @[@"Reboot"];
        testRebootcheck = TRUE;
        [_jailbreak setTitle:localize(@"Please Reboot 1st") forState:UIControlStateNormal];
        [_enableTweaks setEnabled:NO];
        [_enableTweaks setHidden:YES];
        goto end;
    }
    if ((checkpspawnhook == 1) && (checkjailbreakdRun == 0) && (checkuncovermarker == 1) && (checkelectramarker == 1) && (checkth0rmarker == 1)){
        _pickviewarray = @[@"Reboot"];
        testRebootcheck = TRUE;
        [_jailbreak setTitle:localize(@"Please Reboot 1st") forState:UIControlStateNormal];
        [_enableTweaks setEnabled:NO];
        [_enableTweaks setHidden:YES];
        goto end;
    }
    
    if ((checkpspawnhook == 1) && (checkjailbreakdRun == 1) && (checkuncovermarker == 1) && (checkelectramarker == 1) && (checkth0rmarker == 1)){
        _pickviewarray = @[@"Reboot"];
        testRebootcheck = TRUE;
        [_jailbreak setTitle:localize(@"Please Reboot 1st") forState:UIControlStateNormal];
        [_enableTweaks setEnabled:NO];
        [_enableTweaks setHidden:YES];
        goto end;
    }
    
    if ((checkpspawnhook == 0) && (checkjailbreakdRun == 1) && (checkuncovermarker == 1) && (checkelectramarker == 0) && (checkth0rmarker == 1)){
        _pickviewarray = @[@"Reboot"];
        testRebootcheck = TRUE;
        [_jailbreak setTitle:localize(@"Please Reboot 1st") forState:UIControlStateNormal];
        [_enableTweaks setEnabled:NO];
        [_enableTweaks setHidden:YES];
        goto end;
    }
    if ((checkpspawnhook == 1) && (checkjailbreakdRun == 0) && (checkuncovermarker == 1) && (checkelectramarker == 0) && (checkth0rmarker == 1)){
        _pickviewarray = @[@"Reboot"];
        testRebootcheck = TRUE;
        [_jailbreak setTitle:localize(@"Please Reboot 1st") forState:UIControlStateNormal];
        [_enableTweaks setEnabled:NO];
        [_enableTweaks setHidden:YES];
        goto end;
    }
    
    if ((checkpspawnhook == 1) && (checkjailbreakdRun == 1) && (checkuncovermarker == 1) && (checkelectramarker == 0) && (checkth0rmarker == 1)){
        _pickviewarray = @[@"Reboot"];
        testRebootcheck = TRUE;
        [_jailbreak setTitle:localize(@"Please Reboot 1st") forState:UIControlStateNormal];
        [_enableTweaks setEnabled:NO];
        [_enableTweaks setHidden:YES];
        goto end;
    }

    if ((checkpspawnhook == 0) && (checkjailbreakdRun == 1) && (checkuncovermarker == 0) && (checkelectramarker == 1) && (checkth0rmarker == 0)){
        _pickviewarray = @[@"Reboot"];
        testRebootcheck = TRUE;
        [_jailbreak setTitle:localize(@"Reboot electra 1st") forState:UIControlStateNormal];
        [_enableTweaks setEnabled:NO];
        [_enableTweaks setHidden:YES];
        goto end;
    }
    if ((checkpspawnhook == 1) && (checkjailbreakdRun == 0) && (checkuncovermarker == 0) && (checkelectramarker == 1) && (checkth0rmarker == 0)){
        _pickviewarray = @[@"Reboot"];
        testRebootcheck = TRUE;
        [_jailbreak setTitle:localize(@"Reboot electra 1st") forState:UIControlStateNormal];
        [_enableTweaks setEnabled:NO];
        [_enableTweaks setHidden:YES];
        goto end;
    }
    
    if ((checkpspawnhook == 1) && (checkjailbreakdRun == 1) && (checkuncovermarker == 0) && (checkelectramarker == 1) && (checkth0rmarker == 0)){
        _pickviewarray = @[@"Reboot"];
        testRebootcheck = TRUE;
        [_jailbreak setTitle:localize(@"Reboot electra 1st") forState:UIControlStateNormal];
        [_enableTweaks setEnabled:NO];
        [_enableTweaks setHidden:YES];
        goto end;
    }
    if ((checkpspawnhook == 0) && (checkjailbreakdRun == 1) && (checkuncovermarker == 0) && (checkelectramarker == 1) && (checkth0rmarker == 1)){
        _pickviewarray = @[@"Reboot"];
        testRebootcheck = TRUE;
        [_jailbreak setTitle:localize(@"Please Reboot 1st") forState:UIControlStateNormal];
        [_enableTweaks setEnabled:NO];
        [_enableTweaks setHidden:YES];
        goto end;
    }
    if ((checkpspawnhook == 1) && (checkjailbreakdRun == 0) && (checkuncovermarker == 0) && (checkelectramarker == 1) && (checkth0rmarker == 1)){
        _pickviewarray = @[@"Reboot"];
        testRebootcheck = TRUE;
        [_jailbreak setTitle:localize(@"Please Reboot 1st") forState:UIControlStateNormal];
        [_enableTweaks setEnabled:NO];
        [_enableTweaks setHidden:YES];
        goto end;
    }
    if ((checkpspawnhook == 1) && (checkjailbreakdRun == 1) && (checkuncovermarker == 0) && (checkelectramarker == 1) && (checkth0rmarker == 1)){
        _pickviewarray = @[@"Reboot"];
        testRebootcheck = TRUE;
        [_jailbreak setTitle:localize(@"Please Reboot 1st") forState:UIControlStateNormal];
        [_enableTweaks setEnabled:NO];
        [_enableTweaks setHidden:YES];
        goto end;
    }
    
    if ((checkth0rmarker == 1) && (checkuncovermarker == 0) && (checkelectramarker == 0) && (checkjailbreakdRun == 0) && (checkpspawnhook == 1)) {
        _pickviewarray = @[@"Reboot"];
        testRebootcheck = TRUE;
        [_jailbreak setTitle:localize(@"Please Reboot 1st") forState:UIControlStateNormal];
        [_enableTweaks setEnabled:NO];
        [_enableTweaks setHidden:YES];
        goto end;
    }
    if  ((checkpspawnhook == 0) && (checkjailbreakdRun == 1) && (checkuncovermarker == 0) && (checkelectramarker == 0) && (checkJBRemoverMarker == 1) && (checkth0rmarker == 0)){
        [_enableTweaks setEnabled:NO];
        [_jailbreak setTitle:localize(@"Share JB Remover?👍🏽") forState:UIControlStateNormal];
        [self shareTh0rRemover];
        newTFcheckMyRemover4me = TRUE;
        goto end;
        return;
    }
    if  ((checkpspawnhook == 1) && (checkjailbreakdRun == 0) && (checkuncovermarker == 0) && (checkelectramarker == 0) && (checkJBRemoverMarker == 1) && (checkth0rmarker == 0)){
        [_enableTweaks setEnabled:NO];
        [_jailbreak setTitle:localize(@"Share JB Remover?👍🏽") forState:UIControlStateNormal];
        [self shareTh0rRemover];
        newTFcheckMyRemover4me = TRUE;
        goto end;
        return;
    }
    if  ((checkpspawnhook == 1) && (checkjailbreakdRun == 1) && (checkuncovermarker == 0) && (checkelectramarker == 0) && (checkJBRemoverMarker == 1) && (checkth0rmarker == 0)){
        [_enableTweaks setEnabled:NO];
        [_jailbreak setTitle:localize(@"Share JB Remover?👍🏽") forState:UIControlStateNormal];
        [self shareTh0rRemover];
        newTFcheckMyRemover4me = TRUE;
        goto end;
        return;
    }

    if ((flags & CS_PLATFORM_BINARY) && (checkuncovermarker == 0) && (checkelectramarker == 0) && (checkJBRemoverMarker == 1) && (checkth0rmarker == 0)){
        [_enableTweaks setEnabled:NO];
        [_jailbreak setTitle:localize(@"Share JB Remover?👍🏽") forState:UIControlStateNormal];
        [self shareTh0rRemover];
        goto end;
        return;
    }
    if (newTFcheckMyRemover4me & CS_PLATFORM_BINARY){
        [_enableTweaks setEnabled:NO];
        [_jailbreak setTitle:localize(@"𝓢Ⓗ⒜𝕽ᴱ JB Remover?") forState:UIControlStateNormal];
        [self shareTh0rRemover];
        goto end;
        return;
    }
    if ((checkjailbreakdRun == 1) && (checkth0rmarker == 1) && (checkuncovermarker == 0) && (checkelectramarker == 0)) {
        [_enableTweaks setEnabled:NO];
        [_jailbreak setTitle:localize(@"𝓢Ⓗ⒜𝕽ᴱ Th0r?👍🏽") forState:UIControlStateNormal];
        [self shareTh0r];
        goto end;
        return;
        
    }
    if ((checkth0rmarker == 1) && (checkuncovermarker == 0) && (checkelectramarker == 0) && (checkjailbreakdRun == 0) && (checkpspawnhook == 0)) {
        newTFcheckofCyforce = FALSE;
        newTFcheckMyRemover4me = FALSE;
        [_enableTweaks setEnabled:YES];
        [_jailbreak setTitle:localize(@"Enable gRoot?") forState:UIControlStateNormal];
        
        enable3DTouch = NO;
        goto end;
    }
    if (((checkuncovermarker == 1) && (checkjailbreakdRun == 0) && (checkpspawnhook == 0)) || ((checkelectramarker == 1) && (checkjailbreakdRun == 0) && (checkpspawnhook == 0))){
        [_enableTweaks setEnabled:YES];
        [_enableTweaks setHidden:YES];
        newTFcheckofCyforce = FALSE;
        newTFcheckMyRemover4me = TRUE;
        _pickviewarray = @[@"Remove JB"];
        [_jailbreak setTitle:localize(@"Remove Jailbreak?") forState:UIControlStateNormal];
        enable3DTouch = NO;
        goto end;
        
    }
    if(((checkjailbreakdRun == 0) && (checkpspawnhook == 0) && (checkth0rmarker == 0) && (checkuncovermarker == 0)) && (checkelectramarker == 0) && (checkJBRemoverMarker == 1)){
        newTFcheckofCyforce = FALSE;
        newTFcheckMyRemover4me = FALSE;
        [_enableTweaks setEnabled:YES];
        checkJBRemoverMarker = TRUE;
        _pickviewarray = @[@"Jailbreak",@"𝓢Ⓗ⒜𝕽ᴱ JB Remover"];

        //[_jailbreak setTitleColor:localize(GL_BLUE) forState:UIControlStateNormal];
        [_jailbreak setTitle:localize(@"Please select below") forState:UIControlStateNormal];
        [_jailbreak setEnabled:NO];
        
        enable3DTouch = NO;
    }else {
        _pickviewarray = @[@"Remove JB"];
        [_jailbreak setTitle:localize(@"Remove JB?") forState:UIControlStateNormal];
        [_enableTweaks setEnabled:YES];
        [_enableTweaks setHidden:YES];
        newTFcheckofCyforce = FALSE;
        newTFcheckMyRemover4me = TRUE;
        
    }
end:
    printf("wtf\n");
}


bool newTFcheckofCyforce;
bool testRebootcheck;
bool newTFcheckMyRemover4me;

void iosurface_die() {
    kern_return_t err;
    
    io_service_t service = IOServiceGetMatchingService(kIOMasterPortDefault, IOServiceMatching("IOSurfaceRoot"));
    
    if (service == IO_OBJECT_NULL){
        printf("unable to find service\n");
        return;
    }
    
    printf("got service port\n");
    
    io_connect_t conn = MACH_PORT_NULL;
    err = IOServiceOpen(service, mach_task_self(), 0, &conn);
    if (err != KERN_SUCCESS){
        printf("unable to get user client connection\n");
        return;
    }
    
    printf("got user client: 0x%x\n", conn);
    
    uint64_t inputScalar[16];
    uint64_t inputScalarCnt = 0;
    
    char inputStruct[4096];
    size_t inputStructCnt = 0x18;
    
    
    uint64_t* ivals = (uint64_t*)inputStruct;
    ivals[0] = 1;
    ivals[1] = 2;
    ivals[2] = 3;
    
    uint64_t outputScalar[16];
    uint32_t outputScalarCnt = 0;
    
    char outputStruct[4096];
    size_t outputStructCnt = 0;
    
    mach_port_t port = MACH_PORT_NULL;
    err = mach_port_allocate(mach_task_self(), MACH_PORT_RIGHT_RECEIVE, &port);
    if (err != KERN_SUCCESS) {
        printf("failed to allocate new port\n");
        return;
    }
    printf("got wake port 0x%x\n", port);
    mach_port_insert_right(mach_task_self(), port, port, MACH_MSG_TYPE_MAKE_SEND);
    
    uint64_t reference[8] = {0};
    uint32_t referenceCnt = 1;
    
    /*for (int i = 0; i < 10; i++) {
        err = IOConnectCallAsyncMethod(
                                       conn,
                                       17,
                                       port,
                                       reference,
                                       referenceCnt,
                                       inputScalar,
                                       (uint32_t)inputScalarCnt,
                                       inputStruct,
                                       inputStructCnt,
                                       outputScalar,
                                       &outputScalarCnt,
                                       outputStruct,
                                       &outputStructCnt);
        
        printf("%x\n", err);
    };
     */
    
    return;
}

int vfs_die() {
    int fd = open("/", O_RDONLY);
    if (fd == -1) {
        perror("unable to open fs root\n");
        return 0;
    }
    
    struct attrlist al = {0};
    
    al.bitmapcount = ATTR_BIT_MAP_COUNT;
    al.volattr = 0xfff;
    al.commonattr = ATTR_CMN_RETURNED_ATTRS;
    
    size_t attrBufSize = 16;
    void* attrBuf = malloc(attrBufSize);
    int options = 0;
    
    int err = fgetattrlist(fd, &al, attrBuf, attrBufSize, options);
    printf("err: %d\n", err);
    return 0;
}

- (void)Th0rSelfReboot {
    struct utsname u = { 0 };
    uname(&u);
    [self.jailbreak setEnabled:YES];
    //[self.jailbreak setHidden:YES];
    [NSString stringWithUTF8String:u.machine];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul), ^{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Reboot Last chance💣", nil) message:NSLocalizedString(@"I would first recommend you save all your tweaks/apps you've installed from cydia in a list using Flame. Are you sure you want to Reboot?", nil) preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *OK = [UIAlertAction actionWithTitle:NSLocalizedString(@"YES - Reboot💣", nil) style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            dispatch_async(dispatch_get_main_queue(), ^{
                //
                
                //newTFcheckMyRemover4me = TRUE;
                printf("what newcheck force install is showing :%d\n", newTFcheckofCyforce);
                printf("what testremover wannacheckforme is showing :%d\n", newTFcheckMyRemover4me);

                printf("Restarting\n");
                /*
                NSString *msg = [NSString stringWithFormat:localize(@"FUCK REBOOT")];
                dispatch_async(dispatch_get_main_queue(), ^{
                    postProgress(msg);
                });
                sleep(1);
                */
                [self.jailbreak setEnabled:YES];
               /* postProgress(localize(@"Rebooting please 3"));
                restarting();
                [_jailbreak setTitle:localize(@"Rebooting wait 3") forState:UIControlStateNormal];
                sleep(1);
                postProgress(localize(@"Rebooting please 2"));
                [_jailbreak setTitle:localize(@"Rebooting please 2") forState:UIControlStateNormal];
                sleep(1);
                NSString *msg1 = [NSString stringWithFormat:localize(@"FUCK 123 REBOOT")];
                dispatch_async(dispatch_get_main_queue(), ^{
                    postProgress(msg1);
                });
                postProgress(localize(@"Rebooting please 1"));
                [_jailbreak setTitle:localize(@"Rebooting please 1") forState:UIControlStateNormal];
                */
                
                vfs_die();
               // iosurface_die();
                sleep(0.5);
                
                postProgress(localize(@"Rebooting."));
                [_jailbreak setTitle:localize(@"Rebooting.") forState:UIControlStateNormal];
                while (ERR_NOERR == 0){
                //iosurface_die();
                    vfs_die();
                    iosurface_die();
                    sleep(0.1);
                    postProgress(localize(@"Rebooting are we.."));
                    [_jailbreak setTitle:localize(@"Rebooting 1..") forState:UIControlStateNormal];
                    sleep(0.5);
                    postProgress(localize(@"Rinse reboot."));
                    [_jailbreak setTitle:localize(@"Rinse Repeat") forState:UIControlStateNormal];

                }
                //usleep(10);
                ///sleep(1);
                postProgress(localize(@"Rebooting.."));
                [_jailbreak setTitle:localize(@"Rebooting..") forState:UIControlStateNormal];

                vfs_die();
                //iosurface_die();
 
                //usleep(10);
                sleep(1);
                postProgress(localize(@"Rebooting..."));
                [_jailbreak setTitle:localize(@"Rebooting...") forState:UIControlStateNormal];

                //vfs_die();
                //iosurface_die();
                sleep(1);
                postProgress(localize(@"Reboot failed?"));
                [_jailbreak setTitle:localize(@"Reboot failure...") forState:UIControlStateNormal];
                sleep(2);
                exit(0);
                //return -1;
            });
            
        }];
        UIAlertAction *Cancel = [UIAlertAction actionWithTitle:NSLocalizedString(@"No - Quack Quack", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            dispatch_async(dispatch_get_main_queue(), ^{
                //
                [self.jailbreak setEnabled:YES];
                
                
            });
        }];
        [alertController addAction:OK];
        [alertController addAction:Cancel];
        [alertController setPreferredAction:Cancel];
        
        [self presentViewController:alertController animated:YES completion:nil];
    });

}




- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    NSString *optionSelected = [_pickviewarray objectAtIndex:row];
    
    uint32_t flags;
    csops(getpid(), CS_OPS_STATUS, &flags, 0);
    
    int PVcheckuncovermarker = (file_exists("/.installed_unc0ver"));
    int PVcheckth0rmarker = (file_exists("/.bootstrapped_Th0r"));
    int PVcheckelectramarker = (file_exists("/.bootstrapped_electra"));
    int PVcheckJBRemoverMarker = (file_exists("/var/mobile/Media/.bootstrapped_electraremover"));
    
    printf("PICKER View - Uncover marker exists?: %d\n",PVcheckuncovermarker);
    printf("PICKER View - JBRemover marker exists?: %d\n",PVcheckJBRemoverMarker);
    printf("PICKER View - Th0r marker exists?: %d\n",PVcheckth0rmarker);
    printf("PICKER View - Electra marker exists?: %d\n",PVcheckelectramarker);
    
    //(((PVcheckth0rmarker = 0) && (PVcheckuncovermarker = 0)) && (PVcheckelectramarker = 0))
    //= UIColor.blueColor;
    if ([optionSelected  isEqualToString:@"Jailbreak"] || [optionSelected  isEqualToString:@"Enable JB"] ){
        
        if(((PVcheckth0rmarker == 1) && (PVcheckuncovermarker == 0)) && (PVcheckelectramarker == 0)){
            [_enableTweaks setEnabled:YES];
            [_jailbreak setTitle:localize(@"Enable gRoot?") forState:UIControlStateNormal];
            [_jailbreak setEnabled:YES];
            [_jailbreak setHidden:NO];
            [_enableTweaks setHidden:NO];
            newTFcheckofCyforce = FALSE;
            
            newTFcheckMyRemover4me = FALSE;
            printf("what newcheck force install is showing :%d\n", newTFcheckofCyforce);
            printf("what testremover wannacheckforme is showing :%d\n", newTFcheckMyRemover4me);
        }else{
            newTFcheckofCyforce = FALSE;
            newTFcheckMyRemover4me = FALSE;
            [_enableTweaks setEnabled:YES];
            [_jailbreak setEnabled:YES];
            [_jailbreak setHidden:NO];
            [_jailbreak setTitle:localize(@"Journey 2 gRoot?") forState:UIControlStateNormal];
        }
    }
    
    if ([optionSelected  isEqualToString:@"𝓢Ⓗ⒜𝕽ᴱ Th0r👍🏽"]){
        if(((PVcheckth0rmarker == 1) && (PVcheckuncovermarker == 0)) && (PVcheckelectramarker == 0)){
            [_enableTweaks setEnabled:NO];
            [_jailbreak setEnabled:YES];
            [_jailbreak setHidden:NO];

            [_jailbreak setTitle:localize(@"𝓢Ⓗ⒜𝕽ᴱ Th0r?👍🏽") forState:UIControlStateNormal];
            [self shareTh0r];
            return;
        }
    }
    
    if ([optionSelected  isEqualToString:@"𝓢Ⓗ⒜𝕽ᴱ JB Remover"]){
        if(((PVcheckth0rmarker == 1) && (PVcheckuncovermarker == 1)) && (PVcheckelectramarker == 1)){
            [_enableTweaks setEnabled:NO];
            [_jailbreak setEnabled:YES];
            [_jailbreak setHidden:NO];
            [_jailbreak setTitle:localize(@"𝓢Ⓗ⒜𝕽ᴱ JB Remover?") forState:UIControlStateNormal];
            [self shareTh0rRemover];
            return;

        }
    }
    if ([optionSelected  isEqualToString:@"𝓢Ⓗ⒜𝕽ᴱ JB Remover"]){
        if(PVcheckJBRemoverMarker == 1){
            [_enableTweaks setEnabled:NO];
            [_jailbreak setEnabled:YES];
            [_jailbreak setHidden:NO];
            [_jailbreak setTitle:localize(@"𝓢Ⓗ⒜𝕽ᴱ JB Remover?") forState:UIControlStateNormal];
            [self shareTh0rRemover];
            return;
            
        }
    }
    if ([optionSelected  isEqualToString:@"𝓢Ⓗ⒜𝕽ᴱ JB Remover"]){
        
        [_enableTweaks setEnabled:NO];
        [_jailbreak setEnabled:YES];
        [_jailbreak setHidden:NO];
        [_jailbreak setTitle:localize(@"𝓢Ⓗ⒜𝕽ᴱ JB Remover?") forState:UIControlStateNormal];
        [self shareTh0rRemover];
        return;
        
    }
    if ([optionSelected  isEqualToString:@"Reboot"]){
        if ((PVcheckuncovermarker == 1) && (PVcheckth0rmarker == 0)) {
            [_enableTweaks setEnabled:YES];
            [_enableTweaks setHidden:YES];
            [_jailbreak setEnabled:YES];
            [_jailbreak setTitle:localize(@"Reboot unc0ver?") forState:UIControlStateNormal];
            [self Th0rSelfReboot];
        }else if((PVcheckelectramarker == 1) && (PVcheckth0rmarker == 0)){
            [_enableTweaks setEnabled:YES];
            [_enableTweaks setHidden:YES];
            [_jailbreak setEnabled:YES];
            [_jailbreak setTitle:localize(@"Reboot electra?") forState:UIControlStateNormal];
            [self Th0rSelfReboot];
        }else if((PVcheckelectramarker == 0) && (PVcheckth0rmarker == 1)){
            [_enableTweaks setEnabled:YES];
            [_enableTweaks setHidden:YES];
            [_jailbreak setEnabled:YES];
            [_jailbreak setTitle:localize(@"Reboot...?") forState:UIControlStateNormal];
            [self Th0rSelfReboot];
        }else {
            [_enableTweaks setEnabled:YES];
            [_enableTweaks setHidden:YES];
            [_jailbreak setEnabled:YES];
            [_jailbreak setTitle:localize(@"Reboot?") forState:UIControlStateNormal];
            [self Th0rSelfReboot];
        }
    }
    if ([optionSelected  isEqualToString:@"Remove JB"]){
        if(((PVcheckth0rmarker == 1) || (PVcheckuncovermarker == 1)) || (PVcheckelectramarker == 1)){
            [_enableTweaks setEnabled:YES];
            [_enableTweaks setHidden:YES];
            //[_jailbreak setEnabled:YES];
            [_jailbreak setTitle:localize(@"Remove Jailbreak?") forState:UIControlStateNormal];
            newTFcheckofCyforce = FALSE;
            newTFcheckMyRemover4me = TRUE;
            printf("what newcheck force install is showing :%d\n", newTFcheckofCyforce);
            printf("what testremover wannacheckforme is showing :%d\n", newTFcheckMyRemover4me);
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul), ^{
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Jailbreak Remover Last chance💣", nil) message:NSLocalizedString(@"Are you sure you want to remove your Jailbreak?💣", nil) preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *OK = [UIAlertAction actionWithTitle:NSLocalizedString(@"YES - I'm Brave💣", nil) style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                    dispatch_async(dispatch_get_main_queue(), ^{
  //
                        newTFcheckMyRemover4me = TRUE;
                        printf("what newcheck force install is showing :%d\n", newTFcheckofCyforce);
                        printf("what testremover wannacheckforme is showing :%d\n", newTFcheckMyRemover4me);
                        [self.jailbreak setEnabled:YES];
                    });

                }];
                UIAlertAction *Cancel = [UIAlertAction actionWithTitle:NSLocalizedString(@"No - Duck Out", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //
                        [self.jailbreak setEnabled:NO];

                        newTFcheckofCyforce = FALSE;
                        newTFcheckMyRemover4me = FALSE;
                        
                        printf("finally cancelling\n");
                        printf("what newcheck force install is showing :%d\n", newTFcheckofCyforce);
                        printf("what testremover wannacheckforme is showing :%d\n", newTFcheckMyRemover4me);

                        
                    });
                }];
                [alertController addAction:OK];
                [alertController addAction:Cancel];
                [alertController setPreferredAction:Cancel];
                
                [self presentViewController:alertController animated:YES completion:nil];
            });
        }
    }
    
    if ([optionSelected  isEqualToString:@"CyF0rc3"]){
        
        if (PVcheckth0rmarker == 1){
            [_enableTweaks setHidden:YES];
            [_enableTweaks setEnabled:YES];
            [_jailbreak setEnabled:YES];
            [_jailbreak setTitle:localize(@"Force install Cydia?") forState:UIControlStateNormal];
            newTFcheckofCyforce = FALSE;
            newTFcheckMyRemover4me = FALSE;
            printf("what newcheck force install is showing :%d\n", newTFcheckofCyforce);
            printf("what testremover wannacheckforme is showing :%d\n", newTFcheckMyRemover4me);
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul), ^{
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Force install Cydia? Confirmation", nil) message:NSLocalizedString(@"Are you sure you want to force install Cydia?", nil) preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *OK = [UIAlertAction actionWithTitle:NSLocalizedString(@"YES - My Cydia is Fucked", nil) style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //
                        //myUiPickerView.frame = CGRectMake(5000, -4200, 0, 0);
                        [self.jailbreak setEnabled:YES];
                        newTFcheckofCyforce = TRUE;
                        printf("what newcheck force install is showing :%d\n", newTFcheckofCyforce);
                        printf("what testremover wannacheckforme is showing :%d\n", newTFcheckMyRemover4me);
                    });
                }];
                UIAlertAction *Cancel = [UIAlertAction actionWithTitle:NSLocalizedString(@"No - I'm good", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //
                        printf("Cancelling force cydia install\n");
                        newTFcheckofCyforce = FALSE;
                        newTFcheckMyRemover4me = FALSE;
                        printf("what newcheck force install is showing :%d\n", newTFcheckofCyforce);
                        printf("what testremover wannacheckforme is showing :%d\n", newTFcheckMyRemover4me);
                        [self.jailbreak setEnabled:NO];
                    });
                }];
                [alertController addAction:OK];
                [alertController addAction:Cancel];
                [alertController setPreferredAction:Cancel];
                
                [self presentViewController:alertController animated:YES completion:nil];
            });
        }
    }
}


-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return _pickviewarray.count;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    
    return 1;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* lbl = (UILabel*)view;
    // Customise Font
    if (lbl == nil) {
        //label size
        CGRect frame = CGRectMake(300.0, 500.0, 200, 80);

        lbl = [[UILabel alloc] initWithFrame:frame];
        
        [lbl setTextAlignment:NSTextAlignmentCenter];
        [lbl setTextColor:[UIColor redColor]];

        //[lbl setBackgroundColor:[UIColor blueColor]];
        
        //[lbl setText:[UIColor blueColor]];
        //here you can play with fonts
        [lbl setFont:[UIFont fontWithName:@"Times New Roman" size:24.0]];
        
    }
    //picker view array is the datasource
    [lbl setText:[_pickviewarray objectAtIndex:row]];
    
    
    return lbl;
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return _pickviewarray[row];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)credits:(id)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:localize(@"Credits") message:localize(@"Thanks to Ian Beer, theninjaprawn, stek29, Siguza, xerub, JayWalker, Coolstar, SparkZheng, bxl1989, umanghere, Jakeashacks and yes I also thank Nullriver A.K.A Nullpixel(Jamie Bishop) & pwn20wnd although to me they are both dicks... credit is due.\n\nTh0r includes the following software:\nCydia & Filza\nAPFS snapshot mitigation bypass by CoolStar\nliboffsetfinder64 & libimg4tool by tihmstar\nlibplist by libimobiledevice\namfid patch by theninjaprawn\njailbreakd & tweak injection by CoolStar\nunlocknvram & sandbox fixes by stek29\vFinal vfs(empty_list) exploit modified & project mixed together by pwned4ever") preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:localize(@"OK") style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (IBAction)websiteButtonPressed:(UIButton *)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://pwned4ever.ca"]
                                       options:@{}
                             completionHandler:nil];
}

- (IBAction)doit:(id)sender {
    uint32_t flags;
    csops(getpid(), CS_OPS_STATUS, &flags, 0);
    [_jailbreak setEnabled:NO];
    
    int DIcheckuncovermarker = (file_exists("/.installed_unc0ver"));
    int DIcheckth0rmarker = (file_exists("/.bootstrapped_Th0r"));
    int DIcheckelectramarker = (file_exists("/.bootstrapped_electra"));
    int DIcheckJBRemoverMarker = (file_exists("/var/mobile/Media/.bootstrapped_electraremover"));
    int DIcheckpspawnhook = (file_exists("/var/run/pspawn_hook.ts"));
    int DIjailbreakdpid = (file_exists("/var/run/jailbreakd.pid"));
    
    printf("PICKER View - jailbreakd.pid marker exists?: %d\n",DIjailbreakdpid);
    printf("PICKER View - Uncover marker exists?: %d\n",DIcheckuncovermarker);
    printf("PICKER View - JBRemover marker exists?: %d\n",DIcheckJBRemoverMarker);
    printf("PICKER View - Th0r marker exists?: %d\n",DIcheckth0rmarker);
    printf("PICKER View - Electra marker exists?: %d\n",DIcheckelectramarker);
    printf("PICKER View - pspawnhook marker exists?: %d\n",DIcheckpspawnhook);

    
    //myUiPickerView.hidden = TRUE;
    if ((DIcheckpspawnhook == 0) && (DIjailbreakdpid == 1) && (DIcheckJBRemoverMarker == 1) && (DIcheckelectramarker == 0) && (DIcheckuncovermarker == 0) && (DIcheckth0rmarker == 0) & (CS_PLATFORM_BINARY)){
        [_enableTweaks setEnabled:NO];
        [_jailbreak setTitle:localize(@"𝓢Ⓗ⒜𝕽ᴱ JB Remover?") forState:UIControlStateNormal];
        [self shareTh0rRemover];
        
        return;
        
    }
    
    if ((DIcheckpspawnhook == 1) && (DIjailbreakdpid == 0) && (DIcheckJBRemoverMarker == 0) && (DIcheckuncovermarker ==0) && (DIcheckth0rmarker == 1) && (DIcheckelectramarker ==0)){
        [_enableTweaks setEnabled:NO];
        [_jailbreak setTitle:localize(@"Reboot👍🏽") forState:UIControlStateNormal];
        
        [self Th0rSelfReboot];
        return;
        
    }
    if ((DIcheckpspawnhook == 0) && (DIjailbreakdpid == 1) && (DIcheckJBRemoverMarker == 0) && (DIcheckuncovermarker ==0) && (DIcheckth0rmarker == 1) && (DIcheckelectramarker ==0)){
        [_enableTweaks setEnabled:NO];
        [_jailbreak setTitle:localize(@"𝓢Ⓗ⒜𝕽ᴱ Th0r?👍🏽") forState:UIControlStateNormal];
        
        [self shareTh0r];
        return;
        
    }
    if ((DIjailbreakdpid == 1) && (DIcheckpspawnhook = 0) && (DIcheckuncovermarker ==0) && (DIcheckth0rmarker ==0) && (DIcheckelectramarker ==0) && (DIcheckJBRemoverMarker ==1)){
        [_enableTweaks setEnabled:NO];
        [_jailbreak setTitle:localize(@"𝓢Ⓗ⒜𝕽ᴱ JB Remover?") forState:UIControlStateNormal];
        [self shareTh0rRemover];
        return;
        
    }
    if ((DIjailbreakdpid == 1) && (DIcheckpspawnhook = 0) && (flags & CS_PLATFORM_BINARY) && (DIcheckJBRemoverMarker ==1) && (DIcheckuncovermarker ==1)){
        [_enableTweaks setEnabled:NO];
        //[_jailbreak setTitle:localize(@"Reboot unc0ver?") forState:UIControlStateNormal];
        
        [self Th0rSelfReboot];
        return;
    }
    if ((DIjailbreakdpid == 0) && (DIcheckpspawnhook = 1) && (flags & CS_PLATFORM_BINARY) && (DIcheckJBRemoverMarker ==1) && (DIcheckuncovermarker ==1)){
        [_enableTweaks setEnabled:NO];
        //[_jailbreak setTitle:localize(@"Reboot unc0ver?") forState:UIControlStateNormal];
        
        [self Th0rSelfReboot];
        return;
    }
    if ((DIjailbreakdpid == 0) && (DIcheckpspawnhook = 1) && (flags & CS_PLATFORM_BINARY) && (DIcheckth0rmarker ==1) && (DIcheckuncovermarker == 0)){
        [_enableTweaks setEnabled:NO];
        //[_jailbreak setTitle:localize(@"Reboot unc0ver?") forState:UIControlStateNormal];
        
        [self Th0rSelfReboot];
        return;
    }
    if ((DIjailbreakdpid == 1) && (DIcheckpspawnhook = 1) && (flags & CS_PLATFORM_BINARY) && (DIcheckJBRemoverMarker ==1) && (DIcheckuncovermarker ==1)){
        [_enableTweaks setEnabled:NO];
        //[_jailbreak setTitle:localize(@"Reboot unc0ver?") forState:UIControlStateNormal];
        
        [self Th0rSelfReboot];
        return;
    }
    if ((DIjailbreakdpid == 1) && (DIcheckpspawnhook = 0) && (flags & CS_PLATFORM_BINARY) && (DIcheckJBRemoverMarker ==1) && (DIcheckelectramarker ==1)){
        [_enableTweaks setEnabled:NO];
       // [_jailbreak setTitle:localize(@"Reboot electra?") forState:UIControlStateNormal];
        [self Th0rSelfReboot];
        return;
    }
    if ((DIjailbreakdpid == 0) && (DIcheckpspawnhook = 1) && (flags & CS_PLATFORM_BINARY) && (DIcheckJBRemoverMarker ==1) && (DIcheckelectramarker ==1)){
        [_enableTweaks setEnabled:NO];
        // [_jailbreak setTitle:localize(@"Reboot electra?") forState:UIControlStateNormal];
        [self Th0rSelfReboot];
        return;
    }
    if ((DIjailbreakdpid == 1) && (DIcheckpspawnhook = 1) && (flags & CS_PLATFORM_BINARY) && (DIcheckJBRemoverMarker ==1) && (DIcheckelectramarker ==1)){
        [_enableTweaks setEnabled:NO];
        // [_jailbreak setTitle:localize(@"Reboot electra?") forState:UIControlStateNormal];
        [self Th0rSelfReboot];
        return;
    }
    if ((DIjailbreakdpid == 0) && (DIcheckpspawnhook = 0) && (flags & CS_PLATFORM_BINARY) && (DIcheckJBRemoverMarker ==1)){
        [_enableTweaks setEnabled:NO];
        [_jailbreak setTitle:localize(@"Share JB Remover?") forState:UIControlStateNormal];
        [self shareTh0rRemover];
        return;
    }
    if ((DIjailbreakdpid == 1) && (DIcheckpspawnhook = 0) && (flags & CS_PLATFORM_BINARY) && (DIcheckuncovermarker ==1)){
        [_enableTweaks setEnabled:NO];
        //[_jailbreak setTitle:localize(@"Rebooting...") forState:UIControlStateNormal];
        [self Th0rSelfReboot];
        return;
    }
    if ((DIjailbreakdpid == 0) && (DIcheckpspawnhook = 1) && (flags & CS_PLATFORM_BINARY) && (DIcheckuncovermarker ==1)){
        [_enableTweaks setEnabled:NO];
        //[_jailbreak setTitle:localize(@"Rebooting...") forState:UIControlStateNormal];
        [self Th0rSelfReboot];
        return;
    }
    if ((DIjailbreakdpid == 1) && (DIcheckpspawnhook = 1) && (flags & CS_PLATFORM_BINARY) && (DIcheckuncovermarker ==1)){
        [_enableTweaks setEnabled:NO];
        //[_jailbreak setTitle:localize(@"Rebooting...") forState:UIControlStateNormal];
        [self Th0rSelfReboot];
        return;
    }
    if ((DIjailbreakdpid == 1) && (DIcheckpspawnhook = 0) && (flags & CS_PLATFORM_BINARY) && (DIcheckelectramarker ==1)){
        [_enableTweaks setEnabled:NO];
        //[_jailbreak setTitle:localize(@"Rebooting...") forState:UIControlStateNormal];
        [self Th0rSelfReboot];
        return;
    }
    if ((DIjailbreakdpid == 0) && (DIcheckpspawnhook = 1) && (flags & CS_PLATFORM_BINARY) && (DIcheckelectramarker ==1)){
        [_enableTweaks setEnabled:NO];
        //[_jailbreak setTitle:localize(@"Rebooting...") forState:UIControlStateNormal];
        [self Th0rSelfReboot];
        return;
    }
    if ((DIjailbreakdpid == 1) && (DIcheckpspawnhook = 1) && (flags & CS_PLATFORM_BINARY) && (DIcheckelectramarker ==1)){
        [_enableTweaks setEnabled:NO];
        //[_jailbreak setTitle:localize(@"Rebooting...") forState:UIControlStateNormal];
        [self Th0rSelfReboot];
        return;
    }
    if ((DIjailbreakdpid == 0) && (DIcheckpspawnhook = 1) && (flags & CS_PLATFORM_BINARY) && (DIcheckth0rmarker ==1)){
        [_enableTweaks setEnabled:NO];
        //[_jailbreak setTitle:localize(@"Rebooting...") forState:UIControlStateNormal];
        [self Th0rSelfReboot];
        return;
    }
    if ((DIjailbreakdpid == 1) && (DIcheckpspawnhook = 1) && (flags & CS_PLATFORM_BINARY) && (DIcheckth0rmarker ==1)){
        [_enableTweaks setEnabled:NO];
        //[_jailbreak setTitle:localize(@"Rebooting...") forState:UIControlStateNormal];
        [self Th0rSelfReboot];
        return;
    }
    if ((DIjailbreakdpid == 0) && (DIcheckpspawnhook = 0) && (DIcheckJBRemoverMarker == 1) && (DIcheckuncovermarker ==1)){
        [_enableTweaks setEnabled:NO];

    }
    if ((DIjailbreakdpid == 0) && (DIcheckpspawnhook = 0) && (newTFcheckMyRemover4me) && (DIcheckuncovermarker ==1)){
        [_enableTweaks setEnabled:YES];
        [_enableTweaks setHidden:YES];
    }
    if ((DIjailbreakdpid == 0) && (DIcheckpspawnhook = 0) && (newTFcheckMyRemover4me) && (DIcheckelectramarker ==1)){
        [_enableTweaks setEnabled:YES];
        [_enableTweaks setHidden:YES];

    }
    if ( (DIjailbreakdpid == 1) && (DIcheckpspawnhook = 0) && (testRebootcheck == TRUE) && (DIcheckuncovermarker ==1)){
        [_enableTweaks setEnabled:YES];
        [_enableTweaks setHidden:YES];
        [self Th0rSelfReboot];
        return;
        
    }
    if ((DIjailbreakdpid == 0) && (DIcheckpspawnhook = 1) && (testRebootcheck == TRUE) && (DIcheckuncovermarker ==1)){
        [_enableTweaks setEnabled:YES];
        [_enableTweaks setHidden:YES];
        [self Th0rSelfReboot];
        return;
        
    }
    if ((DIjailbreakdpid == 1) && (DIcheckpspawnhook = 1) && (testRebootcheck == TRUE) && (DIcheckuncovermarker ==1)){
        [_enableTweaks setEnabled:YES];
        [_enableTweaks setHidden:YES];
        [self Th0rSelfReboot];
        return;
        
    }
    
    if ((DIjailbreakdpid == 1) && (DIcheckpspawnhook = 0) && (testRebootcheck == TRUE) && (DIcheckelectramarker ==1)){
        [_enableTweaks setEnabled:YES];
        [_enableTweaks setHidden:YES];
        [self Th0rSelfReboot];
        //[_jailbreak setTitle:localize(@"Removing Th0r") forState:UIControlStateNormal];
        return;
        
    }
    if ((DIjailbreakdpid == 0) && (DIcheckpspawnhook = 1) && (testRebootcheck == TRUE) && (DIcheckth0rmarker ==1)){
        [_enableTweaks setEnabled:YES];
        [_enableTweaks setHidden:YES];
        [self Th0rSelfReboot];
        //[_jailbreak setTitle:localize(@"Removing Th0r") forState:UIControlStateNormal];
        return;
        
    }
    if ((DIjailbreakdpid == 1) && (DIcheckpspawnhook = 0) && (testRebootcheck == TRUE) && (DIcheckth0rmarker ==1)){
        [_enableTweaks setEnabled:YES];
        [_enableTweaks setHidden:YES];
        [self Th0rSelfReboot];
        //[_jailbreak setTitle:localize(@"Removing Th0r") forState:UIControlStateNormal];
        return;
        
    }
    if ((DIjailbreakdpid == 1) && (DIcheckpspawnhook = 1) && (testRebootcheck == TRUE) && (DIcheckth0rmarker ==1)){
        [_enableTweaks setEnabled:YES];
        [_enableTweaks setHidden:YES];
        [self Th0rSelfReboot];
        //[_jailbreak setTitle:localize(@"Removing Th0r") forState:UIControlStateNormal];
        return;
        
    }
    if ((DIjailbreakdpid == 0) && (DIcheckpspawnhook = 1) && (testRebootcheck == TRUE) && (DIcheckelectramarker ==1)){
        [_enableTweaks setEnabled:YES];
        [_enableTweaks setHidden:YES];
        [self Th0rSelfReboot];
        //[_jailbreak setTitle:localize(@"Removing Th0r") forState:UIControlStateNormal];
        return;
        
    }
    if ((DIjailbreakdpid == 1) && (DIcheckpspawnhook = 1) && (testRebootcheck == TRUE) && (DIcheckelectramarker ==1)){
        [_enableTweaks setEnabled:YES];
        [_enableTweaks setHidden:YES];
        [self Th0rSelfReboot];
        //[_jailbreak setTitle:localize(@"Removing Th0r") forState:UIControlStateNormal];
        return;
        
    }
    if ((DIjailbreakdpid == 1) && (DIcheckpspawnhook == 0) && (DIcheckuncovermarker ==1)){
        [_enableTweaks setEnabled:YES];
        [_enableTweaks setHidden:YES];
        [self Th0rSelfReboot];
        return;
        //[_jailbreak setTitle:localize(@"Removing Th0r") forState:UIControlStateNormal];
        
    }
    if ((DIjailbreakdpid == 0) && (DIcheckpspawnhook == 1) && (DIcheckuncovermarker ==1)){
        [_enableTweaks setEnabled:YES];
        [_enableTweaks setHidden:YES];
        newTFcheckMyRemover4me = TRUE;
        [_jailbreak setTitle:localize(@"Removing unc0ver VS") forState:UIControlStateNormal];
goto end;
        //[self Th0rSelfReboot];
        //[_jailbreak setTitle:localize(@"Removing Th0r") forState:UIControlStateNormal];
        
    }
    if ((DIjailbreakdpid == 0) && (DIcheckpspawnhook == 1) && (DIcheckelectramarker ==1)){
        [_enableTweaks setEnabled:YES];
        [_enableTweaks setHidden:YES];
        newTFcheckMyRemover4me = TRUE;
        [_jailbreak setTitle:localize(@"Removing electra VS") forState:UIControlStateNormal];
        goto end;
        //[self Th0rSelfReboot];
        //[_jailbreak setTitle:localize(@"Removing Th0r") forState:UIControlStateNormal];
        
    }
    if ((DIjailbreakdpid == 1) && (DIcheckpspawnhook == 1) && (DIcheckuncovermarker ==1)){
        [_enableTweaks setEnabled:YES];
        [_enableTweaks setHidden:YES];
        [self Th0rSelfReboot];
        return;
        //[_jailbreak setTitle:localize(@"Removing Th0r") forState:UIControlStateNormal];
        
    }
    /*if ((DIjailbreakdpid == 0) && (DIcheckpspawnhook = 1) && (DIcheckth0rmarker ==1)){
        [_enableTweaks setEnabled:NO];
        //[_jailbreak setTitle:localize(@"Rebooting...") forState:UIControlStateNormal];
        [self Th0rSelfReboot];
        return;
    }
     */
    
    if ((DIjailbreakdpid == 1) && (DIcheckpspawnhook = 1) && (DIcheckth0rmarker ==1)){
        [_enableTweaks setEnabled:NO];
        //[_jailbreak setTitle:localize(@"Rebooting...") forState:UIControlStateNormal];
        [self Th0rSelfReboot];
        return;
    }
    if ((newTFcheckMyRemover4me) && (DIcheckth0rmarker ==1)){
        [_enableTweaks setEnabled:YES];
        [_enableTweaks setHidden:YES];
        [_jailbreak setTitle:localize(@"Removing Th0r VS") forState:UIControlStateNormal];
        goto end;
        
        //[_jailbreak setTitle:localize(@"Removing Th0r") forState:UIControlStateNormal];

    }
    
    else {
        [_enableTweaks setEnabled:YES];
        [_jailbreak setTitle:localize(@"Enable gRoot?") forState:UIControlStateNormal];
        printf("what newcheck force install is showing :%d\n", newTFcheckofCyforce);
        printf("what testremover wannacheckforme is showing :%d\n", newTFcheckMyRemover4me);
        }
end:
    
    
    //x81,y-8,w159,h84
    _pickviewarray = 0;
    [sender setEnabled:NO];
    [_enableTweaks setEnabled:NO];
    struct utsname u = { 0 };
    uname(&u);
    currentViewController = self;
    BOOL shouldEnableTweaks = [_enableTweaks isOn];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul), ^{
    int ut = 0;

    if (!strcmp(u.machine, "iPhone8,1") || (!strcmp(u.machine, "iPhone8,2"))) {
        printf("i6s & 6s+ -----------\n");
        
        while ((ut = 99 - uptime()) > 0 ) {
            NSString *msg = [NSString stringWithFormat:localize(@"%s %ds"),u.machine, ut+21];
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(msg);
            });
            sleep(1);
        }
    }else if (!strcmp(u.machine, "iPhone10,1") || (!strcmp(u.machine, "iPhone10,4") || (!strcmp(u.machine, "iPhone10,2") || (!strcmp(u.machine, "iPhone10,5"))))) {
        printf("i8 & i8 + -----------\n");
        while ((ut = 56 - uptime()) > 0 ) {
            NSString *msg = [NSString stringWithFormat:localize(@"%s %ds"),u.machine, ut+4];
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(msg);
            });
            sleep(1);
        }
    }
    else if (!strcmp(u.machine, "iPhone10,3") || (!strcmp(u.machine, "iPhone10,6"))) {
        printf("iX wait 60 -----------\n");
        while ((ut = 40 - uptime()) > 0 ) {
            NSString *msg = [NSString stringWithFormat:localize(@"%s %ds"),u.machine, ut+20];
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(msg);
            });
            sleep(1);
        }
    }
        
    else if (!strcmp(u.machine, "iPhone9,1") || (!strcmp(u.machine, "iPhone9,3") || (!strcmp(u.machine, "iPhone9,2") || (!strcmp(u.machine, "iPhone9,4"))))) {
        printf("i7 & i7 + -----------\n");
        while ((ut = 39 - uptime()) > 0 ) {
            NSString *msg = [NSString stringWithFormat:localize(@"%s %ds"),u.machine, ut+21];
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(msg);
            });
            sleep(1);
        }
        
    }else if (!strcmp(u.machine, "iPhone8,4")) {
        printf("iSE-----------\n");
        while ((ut = 79 - uptime()) > 0 ) {
            NSString *msg = [NSString stringWithFormat:localize(@"%s %ds"),u.machine, ut+21];
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(msg);
            });
            sleep(1);
        }
        
    }else if (!strcmp(u.machine, "iPad7,1") || (!strcmp(u.machine, "iPad7,2") || (!strcmp(u.machine, "iPad7,4") || (!strcmp(u.machine, "iPad7,5") || (!strcmp(u.machine, "iPad6,3") || (!strcmp(u.machine, "iPad6,4") || (!strcmp(u.machine, "iPad6,7") || (!strcmp(u.machine, "iPad6,8"))))))))) {
        printf("iPad Pro 9, 10 & 12 in 2nd gen -----------\n");
        while ((ut = 39 - uptime()) > 0 ) {
            NSString *msg = [NSString stringWithFormat:localize(@"%s %ds"),u.machine, ut+21];
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(msg);
            });
            sleep(1);
        }
    }
        
        /////////////////////////////
        /////////////////////////////4k below
        
    else if (!strcmp(u.machine, "iPhone6,1") || (!strcmp(u.machine, "iPhone6,2") || (!strcmp(u.machine, "iPhone7,1") || (!strcmp(u.machine, "iPhone7,2"))))) {
        printf("i5s & i6  & 6+ -----------\n");
        printf("Hello %s ---------------\n", u.machine);
        
        while ((ut = 60 - uptime()) > 0 ) {
            
            NSString *msg = [NSString
                             stringWithFormat:localize(@"%s %ds"),u.machine, ut+20];
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(msg);
            });
            sleep(1);
        }
    }
        
    else if (!strcmp(u.machine, "iPad5,3") || (!strcmp(u.machine, "iPad5,4") || (!strcmp(u.machine, "iPad4,2") || (!strcmp(u.machine, "iPad4,3"))))) {
        printf("iPad air 1 & 2 -----------\n");
        while ((ut = 99 - uptime()) > 0 ) {
            NSString *msg = [NSString stringWithFormat:localize(@"%s %ds"),u.machine, ut+14];
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(msg);
            });
            sleep(1);
        }
        
    }else if (!strcmp(u.machine, "iPad5,1") || (!strcmp(u.machine, "iPad5,2") || (!strcmp(u.machine, "iPad4,7") || (!strcmp(u.machine, "iPad4,8") || (!strcmp(u.machine, "iPad4,9")))))) {
        printf("iPad mini 4 & 3 -----------\n");
        
        while ((ut = 116 - uptime()) > 0 ) {
            
            NSString *msg = [NSString stringWithFormat:localize(@"%s %ds"),u.machine, ut+4];
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(msg);
            });
            sleep(1);
        }
    }else if (!strcmp(u.machine, "iPod7,1")) {
        printf("iPod 6 -----------\n");
        while ((ut = 116 - uptime()) > 0 ) {
            NSString *msg = [NSString stringWithFormat:localize(@"%s %ds"),u.machine, ut+4];
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(msg);
            });
            sleep(1);
        }
    }
        //haha wtf /s, anyways lets make this better to make the tfp0 eaiser to find
        //int exploitstatus = vfs_sploit();
         mach_port_t tfp0 = MACH_PORT_NULL;
         tfp0 = voucher_swap();
        //For iOS version detection
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
        
        if (SYSTEM_VERSION_LESS_THAN(@"11.0")) {
             postProgress(localize(@"Not Supported😡"));
            sleep(1);
            return;
        }
        if (SYSTEM_VERSION_GREATER_THAN(@"11.4.1")) {
            // also note that th0r will get ios 12 support soon shrug
            postProgress(localize(@"Not Supported😡"));
            sleep(1);
            return;
        }
        
        if (!MACH_PORT_VALID(tfp0)) {
            postProgress(localize(@"Error: exploit😡"));
            sleep(1);
            return;
        }
        
        //#endif /* !WANT_VFS */
        dispatch_async(dispatch_get_main_queue(), ^{
            postProgress(localize(@"♫ Working ♫"));
        });
        
        //prepare_for_rw_with_fake_tfp0(tfp0);

        int jailbreakstatus = start_Th0r(tfp0, shouldEnableTweaks);
        switch (jailbreakstatus) {
            case ERR_NOERR: {
                
                if (newTFcheckMyRemover4me ==TRUE){
                    
                    printf("[*****] FUCK done using remover all in ONE!\n");
                    if (/* iOS 11.2.6 or lower don't need snapshot */ kCFCoreFoundationVersionNumber <= 1451.51){
                        
                        
                        UIAlertController *YojbRemoved = [UIAlertController alertControllerWithTitle:localize(@"Jailbreak Removed!") message:localize(@" Most files/tweaks that come with a Jailbreak have been removed! without a snaphsot revert, Files have been removed manually\vp.s. I didn't remove any of your personal data or pictures/apps/messages/contacts etc\vI've set your Device to reboot in 30 secons as soon as this prompt comes up...\n If you leave this prompt open for 30 seconds your device will reboot.\nThank you for using my tool. If you would like to, close it now before it reboots. Then open it again and click share!. After you've shared it, Please REBOOT Manually.\n♫♫♫ @pwned4ever ♫♫♫  ") preferredStyle:UIAlertControllerStyleAlert];
                        
                        [YojbRemoved addAction:[UIAlertAction actionWithTitle:localize(@"Exit") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                            [YojbRemoved dismissViewControllerAnimated:YES completion:nil];
                            exit(0);
                        }]];
                        
                        [self presentViewController:YojbRemoved animated:YES completion:nil];
                        
                    }
                    
                    else if (/* iOS 11.3 and higher can use snapshot */ kCFCoreFoundationVersionNumber > 1451.51){
                        
                        UIAlertController *YojbRemovedSnap = [UIAlertController alertControllerWithTitle:localize(@"Jailbreak Removed!") message:localize(@" All files/tweaks that come with a Jailbreak have been removed!\vp.s. I didn't remove any of your personal data or pictures/apps/messages/contacts etc\vI've set your Device to reboot in 30 secons as soon as this prompt comes up...\n If you leave this prompt open for 30 seconds your device will reboot.\nThank you for using my tool. If you would like to, close it now before it reboots. Then open it again and click share!. After you've shared it, Please REBOOT Manually.\n♫♫♫ @pwned4ever ♫♫♫ ") preferredStyle:UIAlertControllerStyleAlert];
                        
                        [YojbRemovedSnap addAction:[UIAlertAction actionWithTitle:localize(@"Exit") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                            [YojbRemovedSnap dismissViewControllerAnimated:YES completion:nil];
                            exit(0);
                        }]];
                        
                        [self presentViewController:YojbRemovedSnap animated:YES completion:nil];
                    };
                sleep(30);
                do_restart();
                break;
                    
                }else {

                    dispatch_async(dispatch_get_main_queue(), ^{
                        postProgress(localize(@"Jailbroken"));
                        
                        UIAlertController *openSSHRunning = [UIAlertController alertControllerWithTitle:localize(@"OpenSSH Running") message:localize(@"OpenSSH is now running! Enjoy.") preferredStyle:UIAlertControllerStyleAlert];
                        [openSSHRunning addAction:[UIAlertAction actionWithTitle:localize(@"Exit") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                            [openSSHRunning dismissViewControllerAnimated:YES completion:nil];
                            exit(0);
                        }]];
                        [self presentViewController:openSSHRunning animated:YES completion:nil];
                    });
                    break;
            
                }
            case ERR_TFP0: {
                postProgress(localize(@"Error: tfp0"));
                break;
            }
            case ERR_ALREADY_JAILBROKEN: {
                postProgress(localize(@"Already Jailbroken"));
                break;
            }
            case ERR_AMFID_PATCH: {
                postProgress(localize(@"Error: amfid patch😡"));
                break;
            }
            case ERR_ROOTFS_REMOUNT: {
                postProgress(localize(@"Remove update file"));
                break;
            }
            case ERR_SNAPSHOT: {
                postProgress(localize(@"Error: snapshot failed😡"));
                break;
            }
            case ERR_CONFLICT: {
                postProgress(localize(@"Error: conflict😡"));
                break;
            }
            default: {
                postProgress(localize(@"Error Jailbreaking😡"));
                break;
            }
        }
        NSLog(@" ♫ KPP never bothered me anyway... ♫ ");
        }});
}

- (IBAction)tappedOnSetNonce:(id)sender {
    __block NSString *generatorToSet = nil;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:localize(@"Set the system boot nonce on jailbreak") message:localize(@"Enter the generator for the nonce you want the system to generate on boot") preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:localize(@"Cancel") style:UIAlertActionStyleDefault handler:nil]];
    UIAlertAction *set = [UIAlertAction actionWithTitle:localize(@"Set") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        const char *generatorInput = [alertController.textFields.firstObject.text UTF8String];
        char compareString[22];
        uint64_t rawGeneratorValue;
        sscanf(generatorInput, "0x%16llx",&rawGeneratorValue);
        sprintf(compareString, "0x%016llx", rawGeneratorValue);
        if(strcmp(compareString, generatorInput) != 0) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:localize(@"Error") message:localize(@"Failed to validate generator") preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:localize(@"OK") style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
            return;
        }
        generatorToSet = [NSString stringWithUTF8String:generatorInput];
        [userDefaults setObject:generatorToSet forKey:@K_GENERATOR];
        [userDefaults synchronize];
        uint32_t flags;
        csops(getpid(), CS_OPS_STATUS, &flags, 0);
        UIAlertController *alertController = nil;
        if ((flags & CS_PLATFORM_BINARY)) {
            alertController = [UIAlertController alertControllerWithTitle:localize(@"Notice") message:localize(@"The system boot nonce will be set the next time you enable your jailbreak") preferredStyle:UIAlertControllerStyleAlert];
        } else {
            alertController = [UIAlertController alertControllerWithTitle:localize(@"Notice") message:localize(@"The system boot nonce will be set once you enable the jailbreak") preferredStyle:UIAlertControllerStyleAlert];
        }
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    }];
    [alertController addAction:set];
    [alertController setPreferredAction:set];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = [NSString stringWithFormat:@"%s", genToSet()];
    }];
    [self presentViewController:alertController animated:YES completion:nil];
}

NSString *getURLForUsername(NSString *user) {
    UIApplication *application = [UIApplication sharedApplication];
    if ([application canOpenURL:[NSURL URLWithString:@"tweetbot://"]]) {
        return [@"tweetbot:///user_profile/" stringByAppendingString:user];
    } else if ([application canOpenURL:[NSURL URLWithString:@"twitterrific://"]]) {
        return [@"twitterrific:///profile?screen_name=" stringByAppendingString:user];
    } else if ([application canOpenURL:[NSURL URLWithString:@"tweetings://"]]) {
        return [@"tweetings:///user?screen_name=" stringByAppendingString:user];
    } else if ([application canOpenURL:[NSURL URLWithString:@"twitter://"]]) {
        return [@"twitter://user?screen_name=" stringByAppendingString:user];
    } else {
        return [@"https://mobile.twitter.com/" stringByAppendingString:user];
    }
    return nil;
}

- (IBAction)tappedOnHyperlink:(id)sender {
    UIApplication *application = [UIApplication sharedApplication];
    NSString *str = getURLForUsername(@pwned4ever_TEAM_TWITTER_HANDLE);
    NSURL *URL = [NSURL URLWithString:str];
    [application openURL:URL options:@{} completionHandler:nil];
}

- (void)removingLiberiOS {
    postProgress(localize(@"Removing liberiOS"));
}

- (void)removingJailbreak {
    postProgress(localize(@"Removing Jailbreak"));
}

- (void)removingJailbreaknotice {
    postProgress(localize(@"NOW Removing JB"));
}
- (void)cyforceJailbreak {
    postProgress(localize(@"Force Installing Cydia"));
}

- (void)installingCydia {
    postProgress(localize(@"Installing Cydia"));
}


- (void)wait4jailbreakd {
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        postProgress(localize(@"Starting jailbreakd"));
    });
    sleep(1);
    dispatch_async(dispatch_get_main_queue(), ^{
        postProgress(localize(@"wait"));
    });
    sleep(1);
    
    
}
- (void)serverS {
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        postProgress(localize(@"Starting Server"));
    });
    sleep(1);
    /*dispatch_async(dispatch_get_main_queue(), ^{
        postProgress(localize(@"Server wait"));
    });
    sleep(1);
    */
    
}
- (void)waitupdatespring {
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        postProgress(localize(@"update springlist"));
    });
    sleep(0.5);
    
}

- (void)waitfaketfp {
    dispatch_async(dispatch_get_main_queue(), ^{
        postProgress(localize(@"fake tfp0"));
    });
    sleep(1);
    
}
- (void)waittermkernel {
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        postProgress(localize(@"terminate kernel"));
    });
    sleep(1);
    /*dispatch_async(dispatch_get_main_queue(), ^{
        postProgress(localize(@"kernel term in 4"));
    });
    sleep(1);
    dispatch_async(dispatch_get_main_queue(), ^{
        postProgress(localize(@"kernel term in 3"));
    });
    sleep(1);
    dispatch_async(dispatch_get_main_queue(), ^{
        postProgress(localize(@"kernel term in 2"));
    });
    sleep(1);
     */
    dispatch_async(dispatch_get_main_queue(), ^{
        postProgress(localize(@"kernel term in 1"));
    });
    sleep(0.31);

}

- (void)almostdone {
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        postProgress(localize(@"Kexecute done"));
    });
    sleep(0.5);
    
}

- (void)canaryPwait{
    
        dispatch_async(dispatch_get_main_queue(), ^{
            postProgress(localize(@"Canary found?"));
        });
        sleep(1);
        dispatch_async(dispatch_get_main_queue(), ^{
            postProgress(localize(@"Fkn Canary"));
        });
        sleep(1);
}
- (void)canarySwait{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        postProgress(localize(@"Wait for Canary"));
    });
    sleep(1);
    dispatch_async(dispatch_get_main_queue(), ^{
        postProgress(localize(@"Canary fault?"));
    });
    sleep(1);
}

- (void)canarySLwait{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        postProgress(localize(@"Wait for Canary"));
    });
    sleep(0.5);
    dispatch_async(dispatch_get_main_queue(), ^{
        postProgress(localize(@"Canary wait 2"));
    });
    sleep(1);
    dispatch_async(dispatch_get_main_queue(), ^{
        postProgress(localize(@"Canary crash?"));
    });
    sleep(1);
    dispatch_async(dispatch_get_main_queue(), ^{
        postProgress(localize(@"crashing..."));
    });
    sleep(0.5);
}

-(void)semiworkin {

    dispatch_async(dispatch_get_main_queue(), ^{
        postProgress(localize(@"🍀lucky you🍀"));
    });
    sleep(0.1);
    dispatch_async(dispatch_get_main_queue(), ^{
        postProgress(localize(@"🖕🏽sploit2"));
    });
    sleep(0.51);
}

- (void)rmounting {
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        postProgress(localize(@"running mount"));
    });
    sleep(0.1);
    
}

- (void)newwaiting {
    int ut = 0;
    struct utsname u = { 0 };
    uname(&u);
    if (!strcmp(u.machine, "iPhone8,1") || (!strcmp(u.machine, "iPhone8,2"))) {
        printf("i6s & 6s+ -----------\n");
        while ((ut = 107 - uptime()) > 0 ) {
            NSString *msg = [NSString stringWithFormat:localize(@"%s %ds"), u.machine, ut+13];
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(msg);
            });
            sleep(1);
        }

        dispatch_async(dispatch_get_main_queue(), ^{
            postProgress(localize(@"13s wait"));
        });
        sleep(1);
        dispatch_async(dispatch_get_main_queue(), ^{
            postProgress(localize(@"12s wait"));
        });
        sleep(1);
        dispatch_async(dispatch_get_main_queue(), ^{
            postProgress(localize(@"11s wait"));
        });
        sleep(1);
        dispatch_async(dispatch_get_main_queue(), ^{
            postProgress(localize(@"10s wait"));
        });
        sleep(1);
        dispatch_async(dispatch_get_main_queue(), ^{
            postProgress(localize(@"9s wait"));
        });
        sleep(1);
        dispatch_async(dispatch_get_main_queue(), ^{
            postProgress(localize(@"8s wait"));
        });
        sleep(1);
        dispatch_async(dispatch_get_main_queue(), ^{
            postProgress(localize(@"7s wait"));
        });
        sleep(1);
        dispatch_async(dispatch_get_main_queue(), ^{
            postProgress(localize(@"6s wait"));
        });
        sleep(1);
        dispatch_async(dispatch_get_main_queue(), ^{
            postProgress(localize(@"5s wait"));
        });
        sleep(1);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            postProgress(localize(@"4s wait"));
        });
        sleep(1);
        dispatch_async(dispatch_get_main_queue(), ^{
            postProgress(localize(@"3s wait"));
        });
        sleep(1);
        dispatch_async(dispatch_get_main_queue(), ^{
            postProgress(localize(@"2s wait"));
        });
        sleep(1);
        dispatch_async(dispatch_get_main_queue(), ^{
            postProgress(localize(@"1s wait"));
        });
        sleep(1);
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            postProgress(localize(@"VFS"));
        });
        
    }else if (!strcmp(u.machine, "iPhone10,1") || (!strcmp(u.machine, "iPhone10,4") || (!strcmp(u.machine, "iPhone10,2") || (!strcmp(u.machine, "iPhone10,5"))))) {
            printf("i8 & i8 + -----------\n");
        
        while ((ut = 57 - uptime()) > 0 ) {
            NSString *msg = [NSString stringWithFormat:localize(@"%s %ds"), u.machine, ut+3];
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(msg);
            });
            sleep(1);
        }
        /*
         postProgress(localize(@"i8(+) wait 19s"));
         sleep(1);
         postProgress(localize(@"i8(+) wait 18s"));
         sleep(1);
         postProgress(localize(@"i8(+) wait 17s"));
         sleep(1);
         
         postProgress(localize(@"i8(+) wait 16s"));
         sleep(1);
         
         postProgress(localize(@"i8(+) wait 15s"));
         sleep(1);
         
         postProgress(localize(@"i8(+) 14s wait"));
         sleep(1);
         
        dispatch_async(dispatch_get_main_queue(), ^{
            postProgress(localize(@"13s wait"));
        });
        sleep(1);
        dispatch_async(dispatch_get_main_queue(), ^{
            postProgress(localize(@"12s wait"));
        });
        sleep(1);
        dispatch_async(dispatch_get_main_queue(), ^{
            postProgress(localize(@"11s wait"));
        });
        sleep(1);
        dispatch_async(dispatch_get_main_queue(), ^{
            postProgress(localize(@"10s wait"));
        });
        sleep(1);
        dispatch_async(dispatch_get_main_queue(), ^{
            postProgress(localize(@"9s wait"));
        });
        sleep(1);
        dispatch_async(dispatch_get_main_queue(), ^{
            postProgress(localize(@"8s wait"));
        });
        sleep(1);
        dispatch_async(dispatch_get_main_queue(), ^{
            postProgress(localize(@"7s wait"));
        });
        sleep(1);
        dispatch_async(dispatch_get_main_queue(), ^{
            postProgress(localize(@"6s wait"));
        });
        sleep(1);
        dispatch_async(dispatch_get_main_queue(), ^{
            postProgress(localize(@"5s wait"));
        });
        sleep(1);
        dispatch_async(dispatch_get_main_queue(), ^{
            postProgress(localize(@"4s wait"));
        });
        sleep(1);
         */
        dispatch_async(dispatch_get_main_queue(), ^{
            postProgress(localize(@"3s wait"));
        });
        sleep(1);
        dispatch_async(dispatch_get_main_queue(), ^{
            postProgress(localize(@"2s wait"));
        });
        sleep(1);
        dispatch_async(dispatch_get_main_queue(), ^{
            postProgress(localize(@"1s wait"));
        });
        sleep(1);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            postProgress(localize(@"VFS"));
        });

        }
        else if (!strcmp(u.machine, "iPhone10,3") || (!strcmp(u.machine, "iPhone10,6"))) {
            printf("iX -----------\n");
            
            while ((ut = 40 - uptime()) > 0 ) {
                NSString *msg = [NSString stringWithFormat:localize(@"%s %ds"), u.machine, ut+20];
                dispatch_async(dispatch_get_main_queue(), ^{
                    postProgress(msg);
                });
                sleep(1);
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"19s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"18s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"17s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"16s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"15s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"14s wait"));
            });
            sleep(1);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"13s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"12s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"11s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"10s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"9s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"8s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"7s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"6s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"5s wait"));
            });
            sleep(1);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"4s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"3s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"2s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"1s wait"));
            });
            sleep(1);
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"VFS"));
            });
        }
    
        else if (!strcmp(u.machine, "iPhone9,1") || (!strcmp(u.machine, "iPhone9,3") || (!strcmp(u.machine, "iPhone9,2") || (!strcmp(u.machine, "iPhone9,4"))))) {
            printf("i7 & i7 + -----------\n");
            
            while ((ut = 47 - uptime()) > 0 ) {
                NSString *msg = [NSString stringWithFormat:localize(@"%s %ds"), u.machine, ut+13];
                dispatch_async(dispatch_get_main_queue(), ^{
                    postProgress(msg);
                });
                sleep(1);
            }
            /*
             postProgress(localize(@"i8(+) wait 19s"));
             sleep(1);
             postProgress(localize(@"i8(+) wait 18s"));
             sleep(1);
             postProgress(localize(@"i8(+) wait 17s"));
             sleep(1);
             
             postProgress(localize(@"i8(+) wait 16s"));
             sleep(1);
             
             postProgress(localize(@"i8(+) wait 15s"));
             sleep(1);
             
             postProgress(localize(@"i8(+) 14s wait"));
             sleep(1);
             */
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"13s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"12s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"11s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"10s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"9s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"8s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"7s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"6s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"5s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"4s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"3s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"2s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"1s wait"));
            });
            sleep(1);
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"VFS"));
            });
        }
    
    
        else if (!strcmp(u.machine, "iPhone8,4")) {
            printf("iSE-----------\n");
            
            while ((ut = 107 - uptime()) > 0 ) {
                NSString *msg = [NSString stringWithFormat:localize(@"%s %ds"), u.machine, ut+13];
                dispatch_async(dispatch_get_main_queue(), ^{
                    postProgress(msg);
                });
                sleep(1);
            }
            /*
             postProgress(localize(@"i8(+) wait 19s"));
             sleep(1);
             postProgress(localize(@"i8(+) wait 18s"));
             sleep(1);
             postProgress(localize(@"i8(+) wait 17s"));
             sleep(1);
             
             postProgress(localize(@"i8(+) wait 16s"));
             sleep(1);
             
             postProgress(localize(@"i8(+) wait 15s"));
             sleep(1);
             
             postProgress(localize(@"i8(+) 14s wait"));
             sleep(1);
             */
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"13s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"12s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"11s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"10s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"9s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"8s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"7s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"6s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"5s wait"));
            });
            sleep(1);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"4s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"3s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"2s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"1s wait"));
            });
            sleep(1);
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"VFS"));
            });
        }
    
        else if (!strcmp(u.machine, "iPad6,3") || (!strcmp(u.machine, "iPad6,4") || (!strcmp(u.machine, "iPad6,7") || (!strcmp(u.machine, "iPad6,8"))))) {
            printf("iPad pro 9 & 12 in -----------\n");
            
            while ((ut = 47 - uptime()) > 0 ) {
                NSString *msg = [NSString stringWithFormat:localize(@"%s %ds"), u.machine, ut+13];
                dispatch_async(dispatch_get_main_queue(), ^{
                    postProgress(msg);
                });
                sleep(1);
            }
            /*
             postProgress(localize(@"i8(+) wait 19s"));
             sleep(1);
             postProgress(localize(@"i8(+) wait 18s"));
             sleep(1);
             postProgress(localize(@"i8(+) wait 17s"));
             sleep(1);
             
             postProgress(localize(@"i8(+) wait 16s"));
             sleep(1);
             
             postProgress(localize(@"i8(+) wait 15s"));
             sleep(1);
             
             postProgress(localize(@"i8(+) 14s wait"));
             sleep(1);
             */
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"13s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"12s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"11s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"10s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"9s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"8s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"7s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"6s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"5s wait"));
            });
            sleep(1);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"4s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"3s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"2s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"1s wait"));
            });
            sleep(1);
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"VFS"));
            });
        }
    
        else if (!strcmp(u.machine, "iPad7,1") || (!strcmp(u.machine, "iPad7,2") || (!strcmp(u.machine, "iPad7,4") || (!strcmp(u.machine, "iPad7,5"))))) {
            printf("iPad pro 10 & 12 in 2nd gen -----------\n");
            
            while ((ut = 47 - uptime()) > 0 ) {
                NSString *msg = [NSString stringWithFormat:localize(@"%s %ds"), u.machine, ut+13];
                dispatch_async(dispatch_get_main_queue(), ^{
                    postProgress(msg);
                });
                sleep(1);
            }
            /*
             postProgress(localize(@"i8(+) wait 19s"));
             sleep(1);
             postProgress(localize(@"i8(+) wait 18s"));
             sleep(1);
             postProgress(localize(@"i8(+) wait 17s"));
             sleep(1);
             
             postProgress(localize(@"i8(+) wait 16s"));
             sleep(1);
             
             postProgress(localize(@"i8(+) wait 15s"));
             sleep(1);
             
             postProgress(localize(@"i8(+) 14s wait"));
             sleep(1);
             */
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"13s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"12s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"11s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"10s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"9s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"8s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"7s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"6s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"5s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"4s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"3s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"2s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"1s wait"));
            });
            sleep(1);
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"VFS"));
            });
        }
    
        /////////////////////////////
        /////////////////////////////4k below
    
        else if (!strcmp(u.machine, "iPhone6,1") || (!strcmp(u.machine, "iPhone6,2") || (!strcmp(u.machine, "iPhone7,1") || (!strcmp(u.machine, "iPhone7,2"))))) {
            printf("i5s & i6  & 6+ -----------\n");
            while ((ut = 61 - uptime()) > 0 ) {
                NSString *msg = [NSString stringWithFormat:localize(@"%s %ds"), u.machine, ut+19];
                dispatch_async(dispatch_get_main_queue(), ^{
                    postProgress(msg);
                });
                sleep(1);
            }
            /**/
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"19s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"18s wait"));
            });
            sleep(1);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"17s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"16s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"15s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"14s wait"));
            });
            sleep(1);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"13s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"12s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"11s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"10s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"9s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"8s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"7s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"6s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"5s wait"));
            });
            sleep(1);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"4s wait"));
            });
            sleep(1);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"3s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"2s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"1s wait"));
            });
            sleep(1);
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"VFS"));
            });
        }
        else if (!strcmp(u.machine, "iPad4,2") || (!strcmp(u.machine, "iPad4,3") ||(!strcmp(u.machine, "iPad5,1") || (!strcmp(u.machine, "iPad5,2") || (!strcmp(u.machine, "iPad4,7") || (!strcmp(u.machine, "iPad4,8") || (!strcmp(u.machine, "iPad4,9")))))))) {
            printf("iPad air 1 mini 3 -----------\n");
            while ((ut = 117 - uptime()) > 0 ) {
                NSString *msg = [NSString stringWithFormat:localize(@"%s %ds"), u.machine, ut+3];
                dispatch_async(dispatch_get_main_queue(), ^{
                    postProgress(msg);
                });
                sleep(1);
            }
            /*

             postProgress(localize(@"i8(+) wait 19s"));
             sleep(1);
             postProgress(localize(@"i8(+) wait 18s"));
             sleep(1);
             postProgress(localize(@"i8(+) wait 17s"));
             sleep(1);
             
             postProgress(localize(@"i8(+) wait 16s"));
             sleep(1);
             
             postProgress(localize(@"i8(+) wait 15s"));
             sleep(1);
             
             postProgress(localize(@"i8(+) 14s wait"));
             sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"13s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"12s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"11s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"10s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"9s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"8s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"7s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"6s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"4s wait"));
            });
            sleep(1);
             */
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"3s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"2s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"1s wait"));
            });
            sleep(1);
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"VFS"));
            });
        }else if (!strcmp(u.machine, "iPad5,3") || (!strcmp(u.machine, "iPad5,4"))) {
            printf("iPad air -----------\n");
            
            while ((ut = 100 - uptime()) > 0 ) {
                NSString *msg = [NSString stringWithFormat:localize(@"%s %ds"), u.machine, ut+13];
                dispatch_async(dispatch_get_main_queue(), ^{
                    postProgress(msg);
                });
                sleep(1);
            }
            /*
             postProgress(localize(@"i8(+) wait 19s"));
             sleep(1);
             postProgress(localize(@"i8(+) wait 18s"));
             sleep(1);
             postProgress(localize(@"i8(+) wait 17s"));
             sleep(1);
             
             postProgress(localize(@"i8(+) wait 16s"));
             sleep(1);
             
             postProgress(localize(@"i8(+) wait 15s"));
             sleep(1);
             
             postProgress(localize(@"i8(+) 14s wait"));
             sleep(1);
             */
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"13s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"12s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"11s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"10s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"9s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"8s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"7s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"6s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"5s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"4s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"3s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"2s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"1s wait"));
            });
            sleep(1);
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"VFS"));
            });
        }
    
        else if (!strcmp(u.machine, "iPod7,1")) {
            printf("iPod 6 -----------\n");
            
            while ((ut = 117 - uptime()) > 0 ) {
                NSString *msg = [NSString stringWithFormat:localize(@"%s %ds"), u.machine, ut+3];
                dispatch_async(dispatch_get_main_queue(), ^{
                    postProgress(msg);
                });
                sleep(1);
            }
            /*
             postProgress(localize(@"i8(+) wait 19s"));
             sleep(1);
             postProgress(localize(@"i8(+) wait 18s"));
             sleep(1);
             postProgress(localize(@"i8(+) wait 17s"));
             sleep(1);
             
             postProgress(localize(@"i8(+) wait 16s"));
             sleep(1);
             
             postProgress(localize(@"i8(+) wait 15s"));
             sleep(1);
             
             postProgress(localize(@"i8(+) 14s wait"));
             sleep(1);
             
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"13s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"12s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"11s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"10s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"9s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"8s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"7s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"6s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"5s wait"));
            });
            sleep(1);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"4s wait"));
            });
            sleep(1);
            */
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"3s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"2s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"1s wait"));
            });
            sleep(1);
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"VFS"));
            });
        }
    
        else {
            
            while ((ut = 57 - uptime()) > 0 ) {
                NSString *msg = [NSString stringWithFormat:localize(@"%s %ds"), u.machine, ut+13];
                dispatch_async(dispatch_get_main_queue(), ^{
                    postProgress(msg);
                });
                sleep(1);
            }
            /*
             postProgress(localize(@"i8(+) wait 19s"));
             sleep(1);
             postProgress(localize(@"i8(+) wait 18s"));
             sleep(1);
             postProgress(localize(@"i8(+) wait 17s"));
             sleep(1);
             
             postProgress(localize(@"i8(+) wait 16s"));
             sleep(1);
             
             postProgress(localize(@"i8(+) wait 15s"));
             sleep(1);
             
             postProgress(localize(@"i8(+) 14s wait"));
             sleep(1);
             */
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"13s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"12s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"11s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"10s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"9s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"8s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"7s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"6s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"5s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"4s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"3s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"2s wait"));
            });
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"1s wait"));
            });
            sleep(1);
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                postProgress(localize(@"VFS"));
            });
        }
}

- (void)JBremoverIsDone {
    sleep(0.3);
    postProgress(localize(@"JB Remover Is Done"));
}
- (void)cydiaDone {
    sleep(0.3);
    postProgress(localize(@"Cydia Installed"));
}
- (void)startdwait {
    postProgress(localize(@"starting daemons"));
    sleep(1);
    postProgress(localize(@"🤞 Respringing"));
    sleep(1);
}
- (void)displaySnapshotNotice {
    dispatch_async(dispatch_get_main_queue(), ^{
        postProgress(localize(@"user prompt"));
        UIAlertController *apfsNoticeController = [UIAlertController alertControllerWithTitle:localize(@"APFS Snapshot Created") message:localize(@"An APFS Snapshot has been successfully created! You may be able to use SemiRestore to restore your phone to this snapshot in the future.") preferredStyle:UIAlertControllerStyleAlert];
        [apfsNoticeController addAction:[UIAlertAction actionWithTitle:localize(@"Continue Jailbreak") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            postProgress(localize(@"Please Wait 😡"));
            snapshotWarningRead();
        }]];
        [self presentViewController:apfsNoticeController animated:YES completion:nil];
    });
}

- (void)displaySnapshotWarning {
    dispatch_async(dispatch_get_main_queue(), ^{
        postProgress(localize(@"user prompt"));
        UIAlertController *apfsWarningController = [UIAlertController alertControllerWithTitle:localize(@"APFS Snapshot Not Found") message:localize(@"Warning: Your device was bootstrapped using a pre-release version of Electra and thus does not have an APFS Snapshot present. While Electra may work fine, you will not be able to use SemiRestore to restore to stock if you need to. Please clean your device and re-bootstrap with this version of Electra to create a snapshot.") preferredStyle:UIAlertControllerStyleAlert];
        [apfsWarningController addAction:[UIAlertAction actionWithTitle:@"Continue Jailbreak" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            postProgress(localize(@"Please Wait 😡"));
            snapshotWarningRead();
        }]];
        [self presentViewController:apfsWarningController animated:YES completion:nil];
    });
}

- (void)restarting {
    postProgress(localize(@"Rebooting"));
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (IBAction)enableTweaksChanged:(id)sender {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    BOOL enableTweaks = [_enableTweaks isOn];
    [userDefaults setBool:enableTweaks forKey:@K_ENABLE_TWEAKS];
    [userDefaults synchronize];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
