//
//  TouchViewController.swift
//  BlackBlock
//
//  Created by 金玉龙 on 15/10/26.
//  Copyright © 2015年 JinYulong. All rights reserved.
//

import UIKit

class TouchViewController: UIViewController , BlockLineViewDelegate{
    
    var scoreLabel : UILabel?
    var timeLabel : UILabel?
    
    let scorePrefix : String = "Score : "
    var ScoreNum : Int = 0
    let timePrefix : String = "time : "
    var timeNum : Int = 10
    
    var isGaming : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.whiteColor();
        //blockLineView init
        for index in 0...3{
            let blockView : BlockLineView = BlockLineView.init(frame: CGRectMake(0, kScreenHeight/4 * CGFloat(index), kScreenWith, kScreenHeight/4))
            blockView.delegate = self;
            self.view .addSubview(blockView)
            if index == 3{
                blockView.userInteractionEnabled = true;
            }else{
                blockView.userInteractionEnabled = false;
            }
        }
        //scoreLabel init
        scoreLabel = UILabel(frame: CGRectMake(0, 30, kScreenWith/4,kScreenHeight/30))
        scoreLabel?.textColor = UIColor.blackColor()
        scoreLabel?.backgroundColor = UIColor.whiteColor()
        scoreLabel?.layer.borderColor = UIColor.whiteColor().CGColor
        scoreLabel?.text = scorePrefix + String(ScoreNum)
        scoreLabel?.textAlignment = NSTextAlignment.Center
        self.view .addSubview(scoreLabel!)
        self.view .bringSubviewToFront(scoreLabel!)
        
        //scoreLabel init
        timeLabel = UILabel(frame: CGRectMake(kScreenWith/4 * 3, 30, kScreenWith/4,kScreenHeight/30))
        timeLabel?.textColor = UIColor.blackColor()
        timeLabel?.backgroundColor = UIColor.whiteColor()
        timeLabel?.layer.borderColor = UIColor.whiteColor().CGColor
        timeLabel?.text = timePrefix + String(timeNum)
        timeLabel?.textAlignment = NSTextAlignment.Center
        self.view .addSubview(timeLabel!)
        self.view .bringSubviewToFront(timeLabel!)
    }
    
    func blockLineClicked(isBlackBlock: Bool) {
        print(isBlackBlock)
        //test the block be clicked is blackblock or not
        if isBlackBlock == true{
            ScoreNum++
            self .refreshBlockView()
            if isGaming == false {
                self .runTimer()
            }
            isGaming = true
            
        }else if isBlackBlock == false{
            self.gameOverAlert()
        }
        //refresh score
        scoreLabel?.text = scorePrefix + String(ScoreNum)
    }
    
//MARK : - success
    func refreshBlockView(){
        
        self.removeOldBlockView()
        self.addNewBlockView()
        self.setUserInterfaceEnable()
    }

    func removeOldBlockView(){
        //refresh blocklineview frame
        var viewsArray  = self.view.subviews
        viewsArray[3].removeFromSuperview()
        //
        for index in 0...2{
            viewsArray[index].frame.origin.y = viewsArray[index].frame.origin.y + kScreenHeight/4
        }
    }

    func addNewBlockView(){
        let blockView : BlockLineView = BlockLineView.init(frame: CGRectMake(0, 0, kScreenWith, kScreenHeight/4))
        blockView.delegate = self;
        
        self.view .addSubview(blockView)
        self.view.insertSubview(blockView, atIndex: 0)
        self.view.bringSubviewToFront(scoreLabel!)
        self.view.bringSubviewToFront(timeLabel!)
    }
    
    func setUserInterfaceEnable(){
        //reset viewsArray
        var viewsArray = self.view.subviews
        for index in 0...4{
            if index == 3 {
                viewsArray[index].userInteractionEnabled = true
            }else{
                viewsArray[index].userInteractionEnabled = false
            }
        }
    }
//MARK : - false
    func gameOverAlert(){
        isGaming = false
        weak var weakSelf = self
        let alertAction : UIAlertAction = UIAlertAction.init(title: "重新开始", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in
            
            weakSelf!.ScoreNum = 0
            weakSelf!.scoreLabel?.text = weakSelf!.scorePrefix + String(weakSelf!.ScoreNum)
            weakSelf!.timeNum = 10
            weakSelf!.timeLabel?.text = weakSelf!.timePrefix + String(weakSelf!.timeNum)
        }
        let alertController : UIAlertController = UIAlertController(title: "游戏结束", message: scoreLabel?.text, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(alertAction)
        self.presentViewController(alertController, animated:true , completion: nil)
        
    }
    
//MARK : -TIMER
    func timeCount(){
        timeNum--
        timeLabel?.text = timePrefix + String(timeNum )
        if timeNum > 0 && isGaming == true {
            self .runTimer()
        }else if timeNum == 0 {
            self .gameOverAlert()
        }
    }
    
    func runTimer(){
        NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "timeCount", userInfo: nil, repeats:false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
