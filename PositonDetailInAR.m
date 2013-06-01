//
//  PositonDetailInAR.m
//  ARPosition
//
//  Created by Duc Long on 5/23/13.
//
//

#import "PositonDetailInAR.h"
#define textSize 18
#define max 100000
@implementation PositonDetailInAR

@synthesize labelDistanceToShop,labelShopName;
@synthesize userLocation;
@synthesize delegate,position,imageViewBackground;
- (id)initWithShop:(InstanceData *)positionEntity
{
    self = [super init];
    if (self) {
        UIImage *imageBackground = [UIImage imageNamed:@"BackgroudCell.png"];
        imageViewBackground = [[UIImageView alloc]init];
        imageViewBackground.image = imageBackground;
        [self addSubview:imageViewBackground];
        
        icon = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"EgoImageCell.png"]];
        icon.frame = CGRectMake(0, 0, 50, 50);
        [self addSubview:icon];
        
        position = positionEntity;
        userLocation = [[LocationService sharedLocation]getOldLocation];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didUpdateLocation:) name:@"UpdateLocation" object:nil];
        labelShopName = [[UILabel alloc]init];
        [labelShopName setBackgroundColor:[UIColor clearColor]];
        labelDistanceToShop = [[UILabel alloc]init];
        [labelDistanceToShop setBackgroundColor:[UIColor clearColor]];
        [labelDistanceToShop setTextAlignment:NSTextAlignmentCenter];
        labelDistanceToShop.text = [NSString stringWithFormat:@"%d m",[self caculateDistanceToShop:positionEntity]];
        
        [self addSubview:labelShopName];
        [self addSubview:labelDistanceToShop];
        [self.layer setCornerRadius:8];
        [self setContentDetailShop:positionEntity];
        
    }
    return self;
}


- (void)setContentDetailShop:(InstanceData *)positionEntity
{
    [labelDistanceToShop setFont:[UIFont systemFontOfSize:textSize - 4]];
    labelShopName.text = positionEntity.label;
    [labelShopName setFont:[UIFont boldSystemFontOfSize:textSize - 2]];
    [labelShopName setTextAlignment:UITextAlignmentCenter];
    CGSize labelShopNameSize = [positionEntity.label sizeWithFont:[UIFont boldSystemFontOfSize:textSize - 2] constrainedToSize:CGSizeMake(240, max) lineBreakMode:UILineBreakModeCharacterWrap];
    float originLabelDistance = labelShopNameSize.width;
    

    
    
    UILabel *labelShopAddress = [[UILabel alloc]init];
    labelShopAddress.numberOfLines = 0;
    [labelShopAddress setBackgroundColor:[UIColor clearColor]];
    [labelShopAddress setTextColor:[UIColor blackColor]];
    labelShopAddress.text = positionEntity.address;
    [labelShopAddress setTextAlignment:UITextAlignmentCenter];
    [labelShopAddress setFont:[UIFont systemFontOfSize:textSize - 2 ]];
    CGSize labelShopAddressSize = [positionEntity.address sizeWithFont:[UIFont systemFontOfSize:textSize - 2 ] constrainedToSize:CGSizeMake(320, max) lineBreakMode:UILineBreakModeCharacterWrap];
    labelShopAddress.frame = CGRectMake(80, labelShopNameSize.height + 5, 320 ,labelShopAddressSize.height);
    [self addSubview:labelShopAddress];
    [labelShopAddress release];
    
    labelShopName.frame = CGRectMake(53, 0,originLabelDistance,25 );
    labelDistanceToShop.frame = CGRectMake(53, 15,originLabelDistance, 25);
    imageViewBackground.frame = CGRectMake(0, 0, originLabelDistance + 57, 50);
    icon.imageURL = [NSURL URLWithString:positionEntity.imageUrl];
    self.frame = CGRectMake(0, 0, originLabelDistance + 57, 50);
//
//    UILabel *labelShopDescription = [[UILabel alloc]init];
//    [labelShopDescription setBackgroundColor:[UIColor clearColor]];
//    labelShopDescription.text = [NSString stringWithFormat:@"%@",positionEntity.abstract];
//    [labelShopDescription setFont:[UIFont systemFontOfSize:textSize ]];
//    CGSize labelShopDescriptionSize = [positionEntity.abstract sizeWithFont:[UIFont systemFontOfSize:textSize] constrainedToSize:CGSizeMake(300, max) lineBreakMode:UILineBreakModeCharacterWrap];
//    labelShopDescription.frame = CGRectMake(80, labelShopNameSize.height + labelShopAddressSize.height , 300, labelShopDescriptionSize.height);
//    labelShopDescription.numberOfLines = 0;
//    [self.view addSubview:labelShopDescription];
//    [labelShopDescription release];
    
}

- (int)caculateDistanceToShop:(InstanceData *)positionEntity
{
    CLLocation *shoplocation = [[[CLLocation alloc]initWithLatitude:positionEntity.latitude longitude:positionEntity.longitude]autorelease];
    int distance = (int)[shoplocation distanceFromLocation: self.userLocation];
    return distance;
}

-(void)didUpdateLocation:(NSNotification *)notification {
    CLLocation *newLocation = (CLLocation *)[notification object];
    [userLocation release];
    userLocation = [[CLLocation alloc]initWithLatitude:newLocation.coordinate.latitude longitude:newLocation.coordinate.longitude];
    labelDistanceToShop.text = [NSString stringWithFormat:@"%dm",[self caculateDistanceToShop:position]];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didTouchesToView)]) {
        [self.delegate didTouchesToView];
    }
}

- (void)dealloc
{
    [position release];
    [labelShopName release];
    [labelDistanceToShop release];
    [userLocation release];
    [super dealloc];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end