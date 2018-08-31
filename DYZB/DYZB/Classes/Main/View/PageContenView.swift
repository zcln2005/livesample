//
//  PageContenView.swift
//  DYZB
//
//  Created by byron on 2018/8/29.
//  Copyright © 2018年 byron. All rights reserved.
//

import UIKit

protocol PageContenViewDelegate : class {
    func pageContenView(contentView:PageContenView, progress:CGFloat, sourceIndex: Int, targetIndex:Int)
}

private let contentCellID = "contentCellID"
class PageContenView: UIView {
    
    private var childVcs:[UIViewController]
    private weak var parentVc : UIViewController?
    private var startOffsetx : CGFloat = 0
    weak var delegate : PageContenViewDelegate?
    
    private var isForbidScroll : Bool = false
    
    private lazy var collectionView : UICollectionView = { [weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.bounces = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: contentCellID)
        
        return collectionView
        
    }()
    
    init(frame: CGRect, childVcs:[UIViewController], parentVc : UIViewController?) {
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
            parentVc?.addChildViewController(childVc)
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

extension PageContenView:UICollectionViewDelegate{
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startOffsetx = scrollView.contentOffset.x
        isForbidScroll = false
        
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isForbidScroll { return}
        var progress : CGFloat = 0
        var souceIndex : Int = 0
        var targetIndex : Int = 0
        let currentOffsetx = scrollView.contentOffset.x
        let w = scrollView.bounds.width
        let ratio : CGFloat = currentOffsetx / w - floor(currentOffsetx / w)
        if currentOffsetx > startOffsetx {
            progress = ratio
            souceIndex = Int(currentOffsetx / w)
            targetIndex = souceIndex+1
            
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
            if currentOffsetx - startOffsetx == w {
                progress = 1
                targetIndex = souceIndex
            }
        }else{
            progress = 1 - ratio
            targetIndex = Int(currentOffsetx / w)
            souceIndex = targetIndex + 1
            
            if souceIndex >= childVcs.count {
                souceIndex = childVcs.count - 1
            }
        }
        delegate?.pageContenView(contentView: self, progress: progress, sourceIndex: souceIndex, targetIndex: targetIndex)
    }
}

extension PageContenView {
    
    func setCurrentIndex(index: Int){
        isForbidScroll = true
        
        let offset = CGFloat(index) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x:offset,y:0), animated: false)
    }
}
