//
//  EditPropertyVC.m
//  Pillow
//
//  Created by Lucas Luo on 1/11/17.
//  Copyright © 2017 RJT. All rights reserved.
//

#import "EditPropertyVC.h"
#import "SellerPropertyVC.h"
#import "Property.h"
#import "Contants.h"

@interface EditPropertyVC ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameTextFld;
@property (weak, nonatomic) IBOutlet UITextField *typeTextFld;
@property (weak, nonatomic) IBOutlet UITextField *addressTextFld;
@property (weak, nonatomic) IBOutlet UITextField *zipCode;
@property (weak, nonatomic) IBOutlet UITextField *costTextFld;
@property (weak, nonatomic) IBOutlet UITextField *sizeFld;
@property (weak, nonatomic) IBOutlet UITextField *descTextFld;
@property (weak, nonatomic) IBOutlet UISwitch *statusSwitch;
@property (assign,nonatomic) NSInteger imageBtnTag;
@property (weak, nonatomic) IBOutlet UIButton *doneBtn;

@property (nonatomic,strong)UIImagePickerController*picker;
@property (weak, nonatomic) IBOutlet UIImageView *pickerImage1;
@property (weak, nonatomic) IBOutlet UIImageView *pickerImage2;
@property (weak, nonatomic) IBOutlet UIImageView *pickerImage3;
@end

@implementation EditPropertyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.doneBtn.enabled = NO;
}

- (IBAction)cancelBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)doneBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}

-(NSString*)getDocumentDirLocation{
    //    return ([NSHomeDirectory() stringByAppendingPathComponent:@"Documents/"]);//HomeDirectoru is the root directory which contain DOCument
    NSString*dirPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/image"];
    if(![[NSFileManager defaultManager] fileExistsAtPath:dirPath]){
        [[NSFileManager defaultManager] createDirectoryAtPath:dirPath withIntermediateDirectories:NO attributes:[NSDictionary dictionary] error:nil];//Creat a sub dirtionary
    }
    return dirPath;
}

-(void)SourceISCamera{
    self.picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:self.picker animated:YES completion:nil];
}

-(void)sourceIsPhotoLibrary{
    self.picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:self.picker animated:YES completion:nil];
}
- (IBAction)selectImageAction:(UIButton *)sender {
    self.picker = [[UIImagePickerController alloc]init];
    self.picker.allowsEditing = YES;
    self.picker.delegate = self;//Need confirm NagivationColler Delegate
    
    self.imageBtnTag = sender.tag;
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Image Source" message:@"Select Image Source" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction*cameraAction = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action){
        [self SourceISCamera];
    }];
    UIAlertAction* galleryAction = [UIAlertAction actionWithTitle:@"Gallery" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action){
        [self sourceIsPhotoLibrary];
    }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        [actionSheet addAction:cameraAction];
    }
    [actionSheet addAction:galleryAction];
    [actionSheet addAction:cancelAction];
    [self presentViewController:actionSheet animated:YES completion:nil];
    
}
#pragma mark-UIImagePickViewController Delegate Netgids
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo{
    switch (self.imageBtnTag) {
        case 100:
            self.pickerImage1.image = image;
            break;
        case 101:
            self.pickerImage2.image = image;
            break;
        case 102:
            self.pickerImage3.image = image;
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
//
//}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    //    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
