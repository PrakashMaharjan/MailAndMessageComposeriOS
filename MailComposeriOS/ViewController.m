//
//  ViewController.m
//  MailComposeriOS
//
//  Created by Prakash Maharjan on 8/26/16.
//  Copyright © 2016 Prakash Maharjan. All rights reserved.
//

#import "ViewController.h"
#import <MessageUI/MessageUI.h> // importing messageUI framewok


@interface ViewController ()<MFMailComposeViewControllerDelegate,MFMessageComposeViewControllerDelegate> // set mail amd message composer delegate

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

//send email action
- (IBAction)sendEmail:(id)sender {
    
    //check if device can send email
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailComposer = [[MFMailComposeViewController alloc] init];
        mailComposer.mailComposeDelegate = self;
        
        [mailComposer setToRecipients:@[@"prakash@gmail.com"]];
        
        [mailComposer setTitle:@"Test"];
        [mailComposer setSubject:@"This is test subject"];
        [mailComposer setMessageBody:@"hi. this is test message" isHTML:NO];
        
        [self presentViewController:mailComposer animated:YES completion:^{}];
        
    }
    else
    {
        //show alert if device cannot send email or email is not set up
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error!"
                                   message:@"Sorry your device doesn't seem to support the mail composer sheet."
                                   preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Dissmiss" style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction * action) {}];

        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    
    
    
}

//send text sms action
- (IBAction)sendSMS:(id)sender {
    
    //check if device can send message/sms
    if ([MFMessageComposeViewController canSendText])
    {
        MFMessageComposeViewController *messageComposer = [[MFMessageComposeViewController alloc] init];
        messageComposer.messageComposeDelegate = self;
        
        NSArray *smsRecipents = @[@"9841414141", @"980343434", @"34565443"];
        NSString *smsMessage = [NSString stringWithFormat:@"Hey guys lets meet this saturday at the old coffee shop"];
        
        MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
        
        [messageController setRecipients:smsRecipents];
        [messageController setBody:smsMessage];
        
        [self presentViewController:messageComposer animated:YES completion:^{}];
        
    }
    else
    {
        //show alert if device cannot send text message
   
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error!"
                                   message:@"Sorry your device doesn't seem to support the sms composer sheet."
                                   preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Dissmiss" style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction * action) {}];

        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    
    
    
}

#pragma mark - Mail Composer Delegates
- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
        {
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
           
            UIAlertController* mailSendingFailedAlert = [UIAlertController alertControllerWithTitle:@"Error!"
                                       message:@"Failed to send Email!"
                                       preferredStyle:UIAlertControllerStyleAlert];

            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction * action) {}];

            [mailSendingFailedAlert addAction:defaultAction];
            [self presentViewController:mailSendingFailedAlert animated:YES completion:nil];
            
            break;
        }
            
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - Message Composer Delegates
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult) result
{
    switch (result) {
        case MessageComposeResultCancelled:
            NSLog(@"Message sending canceled");
            break;
            
        case MessageComposeResultFailed:
        {
            NSLog(@"Message Sending Failed");
            
            UIAlertController* mailSendingFailedAlert = [UIAlertController alertControllerWithTitle:@"Error!"
                                       message:@"Failed to send SMS!"
                                       preferredStyle:UIAlertControllerStyleAlert];

            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction * action) {}];

            [mailSendingFailedAlert addAction:defaultAction];
            [self presentViewController:mailSendingFailedAlert animated:YES completion:nil];
            
            break;
        }
            
        case MessageComposeResultSent:
            NSLog(@"Message Sent");
            break;
            
        default:
            break;
    }
    
    // Close the Message Interface
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
