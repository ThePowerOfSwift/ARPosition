//
//  BeNCDetailViewController.h
//  ARShop
//
//  Created by Administrator on 12/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <ArroundPlaceService/ArroundPlaceService.h>

@class ARDetailViewController;
@protocol  DetailViewDelegate
-(void)backToMap:(ARDetailViewController *)detailView;
@end
@interface ARDetailViewController : UIViewController{
    CLLocation *userLocation;
    InstanceData *position;
    UILabel *labelDistanceToShop;
}
@property(nonatomic,strong) id<DetailViewDelegate> delegate;
@property(nonatomic, strong)CLLocation *userLocation;
@property(nonatomic, strong)InstanceData *position;
@property(nonatomic, strong)UILabel *labelDistanceToShop;
//- (IBAction)goToMenuSite:(id)sender;
//- (IBAction)goToCouponSite:(id)sender;
//- (IBAction)goToCamera:(id)sender;
- (void)setContentDetailForView:(InstanceData *)positionEntity;
- (id)initWithShop:(InstanceData *)positionEntity;
- (int)caculateDistanceToShop:(InstanceData *)positionEntity;

@end
