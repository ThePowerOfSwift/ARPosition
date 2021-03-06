//
//  BeNCListViewController.h
//  ARShop
//
//  Created by Administrator on 12/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//




#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "ARPositionCell.h"
#import <ArroundPlaceService/ArroundPlaceService.h>

@class ARListViewController;

@protocol ListViewOnMapDelegate
@optional

-(void)animationScaleOff:(UINavigationController *)listview;
-(void)showDetailInMapView:(InstanceData *)positionEntity;

@end



@interface ARListViewController : UIViewController<ARPositionCellDelegate,UITableViewDelegate,UITableViewDataSource>{
    int listType;
    IBOutlet UITableView *listShopView;
//    NSMutableArray *shopsArray;
    CLLocation *userLocation ;
    float distanceToShop;
    BOOL editing;
    UIBarButtonItem *editButton;
    UIBarButtonItem *refreshButtonItem;
    NSMutableArray *arrayButtonItem;
    UIButton *done;
    
}
@property(nonatomic,strong) id<ListViewOnMapDelegate> delegate;
@property(nonatomic, strong) NSMutableArray *shopsArray;
@property float distanceToShop;
@property(nonatomic,strong)IBOutlet UITableView *listShopView;
@property(nonatomic,strong)CLLocation *userLocation ;
@property(nonatomic) int listType;
@property (nonatomic, strong) NSMutableArray *arrayPosition;
-(void)didUpdateLocation:(NSNotification *)notifi;
-(int)calculeDistance:(InstanceData *)positionEntity;
//- (void)refreshData;
//- (IBAction)editList:(id)sender;
//-(void)sortShopByDistance;
-(IBAction)closeListViewInMap:(id)sender;
-(void)addDoneButton;
-(void)getShopDataFromMap:(NSArray *)shopArray;
-(void)didUpdateData:(NSMutableArray *)arrayData ;

@end
