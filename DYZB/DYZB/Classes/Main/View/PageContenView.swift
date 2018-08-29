//
//  PageContenView.swift
//  DYZB
//
//  Created by byron on 2018/8/29.
//  Copyright © 2018年 byron. All rights reserved.
//

import UIKit
private let contentCellID = "contentCellID"
class PageContenView: UIView {
    
    private var childVcs:[UIViewController]
    private var parentVc:UIViewController
    
    private lazy var collectionView:UICollectionView={
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.bounces = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: contentCellID)
        
        return collectionView
        
    }()
    
    init(frame: CGRect, childVcs:[UIViewController], parentVc:UIViewController) {
        self.childVcs = childVcs
        self.parentVc = parentVc
        super.init(frame:frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension PageContenView{
    private func setupUI(){
        for childVc in childVcs {
            parentVc.addChildViewController(childVc)
        }
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}

extension PageContenView:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contentCellID, for: indexPath)
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        return cell
    }
}
