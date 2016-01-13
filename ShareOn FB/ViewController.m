//
//  ViewController.m
//  ShareOn FB
//
//  Created by mac on 30/12/15.
//  Copyright © 2015 mac. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [ FBSDKAccessToken currentAccessToken];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ShareBtn:(id)sender {
    if ([[FBSDKAccessToken currentAccessToken] hasGranted:@"publish_actions"]) {
        [[[FBSDKGraphRequest alloc]
          initWithGraphPath:@"me/feed"
          parameters: @{ @"message" : @"hello world this is test message"}
          HTTPMethod:@"POST"]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error) {
                 NSLog(@"Post id:%@", result[@"id"]);
             }
         }];
    } else {
        FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
        [loginManager logInWithPublishPermissions:@[@"publish_actions"]
                                          handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
                                              [[[FBSDKGraphRequest alloc]
                                                initWithGraphPath:@"me/feed"
                                                parameters: @{ @"message" : @"hello world this is test message"}
                                                HTTPMethod:@"POST"]
                                               startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                                                   if (!error) {
                                                       NSLog(@"Post id:%@", result[@"id"]);
                                                   }
                                               }];
                                          }];
    }
}



@end
//let loginManager = FBSDKLoginManager()
//loginManager.logInWithPublishPermissions(["publish_actions"], handler: { (result:FBSDKLoginManagerLoginResult!, error:NSError!) -> Void in
//    if let Goterror = error{
//        print(Goterror.description)
//    }else
//    {
//        print(result.grantedPermissions)
//        if (result.grantedPermissions.contains("publish_actions")){
//            let imgdata: NSData = UIImagePNGRepresentation(self.Stillimage)!
//            let params: NSDictionary = ["source": imgdata]
//            let GraphPath = "/me/photos/"
//            self.MainActivity.startAnimating()
//            self.MainActivity.center = self.view.center
//            self.MainActivity.center = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height/2)
//            let request: FBSDKGraphRequest = FBSDKGraphRequest(graphPath: GraphPath, parameters: params as [NSObject : AnyObject] , HTTPMethod: "POST")
//            request.startWithCompletionHandler { (connection:FBSDKGraphRequestConnection!, result:AnyObject!, error:NSError!) -> Void in
//                if let gotError = error
//                {
//                    print(gotError.description)
//                    self.MainActivity.stopAnimating()
//                    let alert: UIAlertView = UIAlertView(title: "Error", message: "Can not be Uploded Image", delegate: self, cancelButtonTitle: "Cancel", otherButtonTitles: "OK")
//                    alert.show()
//                }else
//                {
//                    self.UploadImageID = result.valueForKey("id") as! String
//                    self.ImageUrl = "https://m.facebook.com/profile.php?preview_cover=\(self.UploadImageID)"
//                    self.MainActivity.stopAnimating()
//                    let alertController = UIAlertController(title: "Success", message: "Photo Upload Successfully", preferredStyle: .Alert)
//                    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) {
//                        UIAlertAction in
//                    }
//                    let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) {
//                        UIAlertAction in
//                    }
//                    // Add the actions
//                    alertController.addAction(okAction)
//                    alertController.addAction(cancelAction)
//                    // Present the controller
//                    self.presentViewController(alertController, animated: true, completion: nil)
//                }
//            }
//        }
//    }
//})
//self.accessToken = FBSDKAccessToken.currentAccessToken()
//}else{
//    let alert:UIAlertView = UIAlertView(title: "Opps", message: "Network is not Reachable.", delegate: self, cancelButtonTitle: nil, otherButtonTitles: "OK")
//    alert.show()
//}
