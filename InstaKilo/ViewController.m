//
//  ViewController.m
//  InstaKilo
//
//  Created by Mike Cameron on 2018-04-25.
//  Copyright © 2018 Mike Cameron. All rights reserved.
//

#import "ViewController.h"
#import "PhotoCollectionViewCell.h"

@interface ViewController ()<UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray<NSMutableArray<UIImage*>*>* images;
@property (nonatomic, strong) NSMutableArray* firstImages;
@property (nonatomic, strong) NSMutableArray* secondImages;
@property (nonatomic) UILongPressGestureRecognizer *longPressRecognizer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *car1 = [UIImage imageNamed:@"car1"];
    UIImage *car2 = [UIImage imageNamed:@"car2"];
    UIImage *car3 = [UIImage imageNamed:@"car3"];
    UIImage *car4 = [UIImage imageNamed:@"car4"];
    UIImage *car5 = [UIImage imageNamed:@"car5"];
    UIImage *car6 = [UIImage imageNamed:@"car6"];
    UIImage *car7 = [UIImage imageNamed:@"car7"];
    UIImage *car8 = [UIImage imageNamed:@"car8"];
    UIImage *car9 = [UIImage imageNamed:@"car9"];
    UIImage *car10 = [UIImage imageNamed:@"car10"];
    NSMutableArray *carImages = [[NSMutableArray alloc] initWithObjects:car1, car2, car3, car4, car5, nil];
    NSMutableArray *tireImages = [[NSMutableArray alloc] initWithObjects:car6, car7, car8, car9, car10, nil];
    
    NSMutableArray *detroitImages = [[NSMutableArray alloc] initWithObjects:car2, car4, car6, car8, car10, nil];
    NSMutableArray *caliImages = [[NSMutableArray alloc] initWithObjects:car1, car3, car5, car7, car9, nil];
    NSMutableArray<NSMutableArray<UIImage*>*> *firstImages = [[NSMutableArray alloc] initWithObjects:carImages, tireImages, nil];
    NSMutableArray<NSMutableArray<UIImage*>*>* secondImages = [[NSMutableArray alloc] initWithObjects:detroitImages, caliImages, nil];
    self.firstImages = firstImages;
    self.secondImages = secondImages;
    self.images = firstImages;
    
    //long press
    UILongPressGestureRecognizer *longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(wasLongPressed:)];
    self.longPressRecognizer = longPressRecognizer;
    [self.collectionView addGestureRecognizer:longPressRecognizer];
    
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.images objectAtIndex:section].count;
//    return 5;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photoCell" forIndexPath:indexPath];

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 160, 160)];

    UIImage *image = self.images[indexPath.section][indexPath.item];
    imageView.image = image;
    
    cell.imageView = imageView;
    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    cell.imageView.clipsToBounds = YES;
//    CGSize size = cell.bounds.size;
    [cell addSubview:cell.imageView];

    return cell;
}

-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView* header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"photoHeader" forIndexPath:indexPath];
    UILabel *label = [header viewWithTag:1];
    if (indexPath.section == 0 && self.images == self.firstImages) {
        label.text = @"1986 Monte Carlos";
    } else if (indexPath.section == 1 && self.images == self.firstImages) {
        label.text = @"1987 Monte Carlos";
    } else if (indexPath.section == 0 && self.images == self.secondImages) {
        label.text = @"Detroit";
    } else if (indexPath.section == 1 && self.images == self.secondImages) {
        label.text = @"California";
    }
    
    return header;
}
- (IBAction)buttonPressed {
    if (self.images == self.firstImages) {
        self.images = self.secondImages;
    } else if (self.images == self.secondImages) {
        self.images = self.firstImages;
    }
    [self.collectionView reloadData];
}
-(IBAction)wasLongPressed:(UILongPressGestureRecognizer*)sender {
    NSLog(@"long press");
    CGPoint point = [sender locationInView:sender.view];
    NSIndexPath *path = [self.collectionView indexPathForItemAtPoint:point];
    NSLog(@"%@", path);
    NSInteger section = path.section;
    NSInteger item = path.item;
    [[self.images objectAtIndex:section] removeObjectAtIndex:item];
    NSArray *array = [[NSArray alloc] initWithObjects:path, nil];
    [self.collectionView deleteItemsAtIndexPaths:array];
//    [self.images removeObjectAtIndex:[self.images objectAtIndex:[section][item]];
    
}
@end
