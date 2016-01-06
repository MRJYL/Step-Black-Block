//
//  BlockLine.swift
//  BlackBlock
//
//  Created by 金玉龙 on 15/10/26.
//  Copyright © 2015年 JinYulong. All rights reserved.
//

import UIKit

protocol BlockLineViewDelegate{
    func blockLineClicked(isBlackBlock :Bool);
}

class BlockLineView: UIView {
    
    var delegate : BlockLineViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //get blackblock index
        let randomNum = rand() % 4
        
        //block init
        for index in 0...3{
            let buttonBlock = UIButton.init(type: UIButtonType.Custom)
            buttonBlock.frame = CGRectMake(frame.width/4 * CGFloat(index), 0, frame.width/4, frame.height)
            buttonBlock.layer.borderWidth = 0.5
            buttonBlock.layer.borderColor = UIColor.blackColor().CGColor
            if index == Int(randomNum ){
                buttonBlock.backgroundColor = UIColor.blackColor()
                
            }else{
                buttonBlock.backgroundColor = UIColor.whiteColor()
            }
        
            buttonBlock.addTarget(self, action: "buttonClick:", forControlEvents: UIControlEvents.TouchUpInside)
            self .addSubview(buttonBlock)
        }
    }
    
    func buttonClick(sender: UIButton){
        //click action
        if sender.backgroundColor == UIColor.blackColor(){
            delegate?.blockLineClicked(true)
        }else{
            delegate?.blockLineClicked(false)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
