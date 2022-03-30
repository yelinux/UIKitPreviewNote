//
//  MyCollectionViewFlowLayout.m
//  UIKitPreviewNote
//
//  Created by chenyehong on 2022/3/25.
//

#import "MyCollectionViewFlowLayout.h"

@implementation MyCollectionViewFlowLayout

-(NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSArray *attributesArray = [[NSArray alloc] initWithArray:[super layoutAttributesForElementsInRect:rect] copyItems:YES];
    CGRect visibleRect = {self.collectionView.contentOffset,self.collectionView.bounds.size};
    for (UICollectionViewLayoutAttributes *attributes in attributesArray) {
//        if (!CGRectIntersectsRect(visibleRect, attributes.frame)) {
//            continue;
//        }
        attributes.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.5, 0.5);
    }
    return attributesArray;
}

@end
