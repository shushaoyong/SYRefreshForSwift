//
//  TestHorizontalNormalCollectionViewController.swift
//  SYRefreshExampleforSwift
//
//  Created by shusy on 2017/6/10.
//  Copyright © 2017年 SYRefresh. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class TestHorizontalNormalCollectionViewController: UICollectionViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
//        collectionView?.sy_header = TextHeaderFooter(normalText: HorizontalHintText.headerNomalText, pullingText: HorizontalHintText.headerPullingText, refreshingText: HorizontalHintText.headerRefreshText, orientation: .left, height: 60, font: UIFont.systemFont(ofSize: 8), color: UIColor.black, completion: { [weak self] in
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                self?.collectionView?.sy_header?.endRefreshing()
//            }
//        })
        
        let textItem = TextItem(normalText: VerticalHintText.headerNomalText, pullingText: VerticalHintText.headerPullingText, refreshingText: VerticalHintText.headerRefreshText, font: UIFont.systemFont(ofSize: 13), color: UIColor.black)

        collectionView?.sy_header = CoreTextHeaderFooter(textItem: textItem, orientation: .left, height: 44, completion: { 
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
                self?.collectionView?.sy_header?.endRefreshing()
            }
        })
    
         collectionView?.sy_footer = TextHeaderFooter(normalText: HorizontalHintText.footerNomalText, pullingText: HorizontalHintText.footerPullingText, refreshingText: HorizontalHintText.footerRefreshText, orientation: .right, height: 60, font: UIFont.systemFont(ofSize: 8), color: UIColor.black, completion: { [weak self] in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                 self?.collectionView?.sy_footer?.endRefreshing()
            }
        })
        
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 100
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        cell.backgroundColor = UIColor.darkGray
        return cell
    }
    
}
