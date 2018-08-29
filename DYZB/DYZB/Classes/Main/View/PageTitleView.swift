//
//  PageTitleView.swift
//  DYZB
//
//  Created by byron on 2018/8/29.
//  Copyright © 2018年 byron. All rights reserved.
//

import UIKit

private let kScrollLineH : CGFloat = 2

class PageTitleView: UIView {
    private var titles : [String]
    
    private lazy var scrollView:UIScrollView={
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    
    private lazy var scrollLine:UIView={
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.gray
        return scrollLine
    }()
    
    private lazy var titleLabels : [UILabel] = [UILabel]()
    
    init(frame: CGRect, titles:[String]) {
        self.titles = titles
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PageTitleView{
    

    private func setupUI(){
        addSubview(scrollView)
        scrollView.frame = bounds
        setupTitleLabels()
        setupIndicator()
    }
    
    private func setupTitleLabels(){
        
        let labelW : CGFloat = frame.width / CGFloat(titles.count)
        let labelH : CGFloat = frame.height - kScrollLineH
        let labelY : CGFloat = 0
        
        for(index, title) in titles.enumerated() {
            let label=UILabel()
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize:16.0)
            label.textColor = UIColor.darkGray
            label.textAlignment = .center
            let labelX : CGFloat = labelW * CGFloat(index)
            
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            scrollView.addSubview(label)
            titleLabels.append(label)
            
        }
    }
    
    private func setupIndicator(){
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        bottomLine.frame = CGRect(x: 0, y: frame.height-0.5, width: frame.width, height: 0.5)
        addSubview(bottomLine)
        scrollView.addSubview(scrollLine)
        
        guard let firstLabel = titleLabels.first else {return}
        firstLabel.textColor = UIColor.orange
        
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height-kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
    }
    
//    fileprivate func setupBottomLineAndScrollLine() {
//        // 1.添加底线
//        let bottomLine = UIView()
//        bottomLine.backgroundColor = UIColor.lightGray
//        let lineH : CGFloat = 0.5
//        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
//        addSubview(bottomLine)
//
//        // 2.添加scrollLine
//        // 2.1.获取第一个Label
//        guard let firstLabel = titleLabels.first else { return }
//        firstLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
//
//        // 2.2.设置scrollLine的属性
//        scrollView.addSubview(scrollLine)
//        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
//    }
    
    
}
