//
//  StackMov1View.h
//  UIKitPreviewNote
//
//  Created by chenyehong on 2022/4/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YHDragSortGridView : UIView

-(void)setViews: (NSArray<UIView*>*)views
         colNum: (NSInteger)colNum
      itemWidth: (CGFloat)itemWidth
    itemSpacing: (CGFloat)itemSpacing
     itemHeight: (CGFloat)itemHeight
     edgeInsets: (UIEdgeInsets)edgeInsets;

@end

NS_ASSUME_NONNULL_END
