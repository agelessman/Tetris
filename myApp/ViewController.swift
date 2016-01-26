//
//  ViewController.swift
//  myApp
//
//  Created by 马超 on 15/11/7.
//  Copyright © 2015年 马超. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController ,GameViewDelegate {

    let MARGINE:CGFloat = 10
    let BUTTON_SIZE:CGFloat = 48
    let BUTTON_ALPHA:CGFloat = 0.4
    let TOOLBAR_HEIGHT:CGFloat = 44
    var screenWidth:CGFloat!
    var screenHeight:CGFloat!
    var gameView:GameView!
    var bgMusicPlayer:AVAudioPlayer!
    var speedShow:UILabel!
    var scoreShow:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        let rect = UIScreen.mainScreen().bounds
        screenWidth = rect.size.width
        screenHeight = rect.size.height
        
        addToolBar()
        
        let gameRect = CGRectMake(rect.origin.x + MARGINE, rect.origin.y + TOOLBAR_HEIGHT + MARGINE*2, rect.size.width - MARGINE*2, rect.size.height - BUTTON_SIZE * 2 - TOOLBAR_HEIGHT)
        gameView = GameView(frame: gameRect)
        gameView.delegate = self
        self.view.addSubview(gameView)
        
        gameView.startGame()
        
        addButtons()
     
        //添加背景音乐
        let bgMusicUrl = NSBundle.mainBundle().URLForResource("1757", withExtension: "mp3")
        
        do
        {
           try bgMusicPlayer = AVAudioPlayer(contentsOfURL: bgMusicUrl!)
        }catch
        {
        
        }
        bgMusicPlayer.numberOfLoops = -1
        bgMusicPlayer.play()
        
    }


    func addToolBar()
    {
    
        let toolBar = UIToolbar(frame: CGRectMake(0,MARGINE*2,screenWidth,TOOLBAR_HEIGHT))
        self.view.addSubview(toolBar)
        
        //创建一个显示速度的标签
        let speedLabel = UILabel()
        speedLabel.frame = CGRectMake(0, 0, 50, TOOLBAR_HEIGHT)
        speedLabel.text = "速度:"
        let speedLabelItem = UIBarButtonItem(customView: speedLabel)
        
        //创建第二个显示速度值得标签
        speedShow = UILabel()
        speedShow.frame = CGRectMake(0, 0, 20, TOOLBAR_HEIGHT)
        speedShow.textColor = UIColor.redColor()
        let speedShowItem = UIBarButtonItem(customView: speedShow)
        
        //创建第三个显示当前积分的标签
        let scoreLabel = UILabel()
        scoreLabel.frame = CGRectMake(0, 0, 90, TOOLBAR_HEIGHT)
        scoreLabel.text = "当前积分:"
        let scoreLabelItem = UIBarButtonItem(customView: scoreLabel)
        
        //创建第四个显示当前积分值标签
        scoreShow = UILabel()
        scoreShow.frame = CGRectMake(0, 0, 40, TOOLBAR_HEIGHT)
        scoreShow.textColor = UIColor.redColor()
        let scoreShowItem = UIBarButtonItem(customView: scoreShow)
        
        let flexItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        toolBar.items = [speedLabelItem,speedShowItem,flexItem,scoreLabelItem,scoreShowItem]
    }

    //定义方向
    func addButtons()
    {
    
        //left
        let leftBtn = UIButton()
        leftBtn.frame = CGRectMake(screenWidth - BUTTON_SIZE*3 - MARGINE, screenHeight - BUTTON_SIZE - MARGINE, BUTTON_SIZE, BUTTON_SIZE)
        leftBtn.alpha = BUTTON_ALPHA
        leftBtn.setTitle("左", forState: UIControlState.Normal)
        leftBtn.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        leftBtn.addTarget(self, action: "left:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(leftBtn)
        
        //up
        let upBtn = UIButton()
        upBtn.frame = CGRectMake(screenWidth - BUTTON_SIZE*2 - MARGINE, screenHeight - BUTTON_SIZE*2 - MARGINE, BUTTON_SIZE, BUTTON_SIZE)
        upBtn.alpha = BUTTON_ALPHA
        upBtn.setTitle("上", forState: UIControlState.Normal)
        upBtn.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        upBtn.addTarget(self, action: "up:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(upBtn)
        
        //right
        let rightBtn = UIButton()
        rightBtn.frame = CGRectMake(screenWidth - BUTTON_SIZE - MARGINE, screenHeight - BUTTON_SIZE - MARGINE, BUTTON_SIZE, BUTTON_SIZE)
        rightBtn.alpha = BUTTON_ALPHA
        rightBtn.setTitle("右", forState: UIControlState.Normal)
        rightBtn.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        rightBtn.addTarget(self, action: "right:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(rightBtn)
        
        //down
        let downBtn = UIButton()
        downBtn.frame = CGRectMake(screenWidth - BUTTON_SIZE*2 - MARGINE, screenHeight - BUTTON_SIZE - MARGINE, BUTTON_SIZE, BUTTON_SIZE)
        downBtn.alpha = BUTTON_ALPHA
        downBtn.setTitle("下", forState: UIControlState.Normal)
        downBtn.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        downBtn.addTarget(self, action: "down:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(downBtn)
        
    }
    
    func left(sender:UIButton)
    {
        print("点击了左")
        gameView.moveLeft()
    }
    
    func up(sender:UIButton)
    {
        print("点击了上")
        gameView.rotate()
    }
    
    func right(sender:UIButton)
    {
        print("点击了右")
        gameView.moveRight()
    }
    
    func down(sender:UIButton)
    {
        print("点击了下")
        gameView.moveDown()
    }
    
    func updateScore(score: Int) {
        //跟新分数
        self.scoreShow.text = "\(score)"
    }
    
    func updateSpeed(speed: Int) {
        //跟新速度
        self.speedShow.text = "\(speed)"
    }

}

