//
//  CollectionViewGridLayout.swift
//  MovieDatabase
//
//  Created by Anton Komin on 19.05.2018.
//  Copyright © 2018 Anton Komin. All rights reserved.
//

import Foundation
import UIKit

class CollectionGridFlowLayout: UICollectionViewFlowLayout {
    
    override init() {
        super.init()
        setupLayout()
    }
        
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }
    
    func setupLayout() {
        minimumInteritemSpacing = 5
        minimumLineSpacing = 0
        scrollDirection = .vertical
        sectionHeadersPinToVisibleBounds = true
        sectionInset = UIEdgeInsetsMake(0, 5, 0, 5)
    }
    
    func itemWidth() -> CGFloat {
        switch UIScreen.main.traitCollection.userInterfaceIdiom {
        case .phone:
            return ((collectionView!.frame.width - 15)/2)
        case .pad:
            if collectionView!.frame.height > collectionView!.frame.width {
                return ((collectionView!.frame.width - 20)/3)
            } else {
                return ((collectionView!.frame.width - 25)/4)
            }
        default :
            return ((collectionView!.frame.width - 15)/2)
        }
    }
    
    func itemHeight() -> CGFloat {
        switch UIScreen.main.traitCollection.userInterfaceIdiom {
        case .phone:
            if collectionView!.frame.height > collectionView!.frame.width {
                return ((collectionView!.frame.height)/2)
            } else {
                return collectionView!.frame.height
            }
        case .pad:
            if collectionView!.frame.height > collectionView!.frame.width {
                return ((collectionView!.frame.height)/3)
            } else {
                return ((collectionView!.frame.height)/2)
            }
        default :
            return ((collectionView!.frame.height)/2)
        }
    }
    
    override var itemSize: CGSize {
        set {
            self.itemSize = CGSize(width: itemWidth(), height: itemHeight())
        }
        get {
            return CGSize(width: itemWidth(), height: itemHeight())
        }
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        return collectionView!.contentOffset
    }
    
    override func invalidateLayout() {
        super.invalidateLayout()
    }
}
