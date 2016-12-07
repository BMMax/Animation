//
//  UIView + Extend.swift
//  Animation
//
//  Created by user on 16/12/6.
//  Copyright © 2016年 mobin. All rights reserved.
//

import UIKit

var DEFAULT_DURATION:TimeInterval = 0.25
typealias CompleteBlock = (() -> Void)?
extension UIView{
    
     //MARK: - Position
    /// x
    var left:CGFloat{
        set{
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
        get{
            return self.frame.origin.x
        }
    }

    var top:CGFloat{
    
        set{
        
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
        
        get{
        
            return self.frame.origin.y
        }
    
    }
    
    
    var right:CGFloat {
    
        set{
        
            var frame = self.frame
            frame.origin.x = newValue - frame.size.width
            self.frame = frame
        }
        
        get{
            
            return self.frame.origin.x + self.frame.size.width
        }
    }
    
    var bottom:CGFloat{
    
    
        set{
        
            var frame = self.frame
            frame.origin.y = newValue - frame.size.height
        }
        
        get{
            return self.frame.origin.y + self.frame.size.height
        }
    }
    
    
    
    var centerY: CGFloat{
    
    
        set{
            self.center = CGPoint(x: self.center.x, y: newValue)
        }
        
        get{
        
            return self.center.y
        }
    }
    
    
    var centerX: CGFloat{
    
        set{
        
            self.center = CGPoint(x: newValue, y: self.center.y)
        }
        
        get{
        
            return self.center.x
        }
    }
    
    
    var height: CGFloat{
    
        set{
        
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        
        }
        
        get{
        
            return self.frame.size.height
        }
    
    }
    
    
    var origin:CGPoint{
        set{
            var frame = self.frame;
            frame.origin = newValue
            self.frame = frame
        }
        get{
            return self.frame.origin
        }
    }
    
    var size:CGSize{
        set{
            var frame = self.frame;
            frame.size = newValue
            self.frame = frame
        }
        get{
            return self.frame.size
        }
    }
    
    
    /// 动画效果
    ///
    /// - Parameters:
    ///   - type: type
    /*
     fade     //交叉淡化过渡(不支持过渡方向)
     push     //新视图把旧视图推出去
     moveIn   //新视图移到旧视图上面
     reveal   //将旧视图移开,显示下面的新视图
     cube     //立方体翻滚效果
     oglFlip  //上下左右翻转效果
     suckEffect   //收缩效果，如一块布被抽走(不支持过渡方向)
     rippleEffect //滴水效果(不支持过渡方向)
     pageCurl     //向上翻页效果
     pageUnCurl   //向下翻页效果
     cameraIrisHollowOpen  //相机镜头打开效果(不支持过渡方向)
     cameraIrisHollowClose //相机镜头关上效果(不支持过渡方向)
     */
    ///   - subType: 
    /*
     kCATransitionFromRight
     kCATransitionFromLeft
     kCATransitionFromTop
     kCATransitionFromBottom
     
     */
    ///   - duration: 时间
    func mb_Animation(_ type: String, subType:String?,duration: TimeInterval) -> Void {
        
        let action: CATransition = CATransition()
        action.type = type
        
        if let subType = subType {
            action.subtype = subType
        }
        
        action.duration = duration
        self.layer.add(action, forKey: "animation")
        
    }
    
    
     //MARK: - 转场
    func mb_Animation(_ duration: TimeInterval,transition: UIViewAnimationTransition, forView:UIView, completion: CompleteBlock) {
        UIView.animate(withDuration: duration, animations: {
        
            UIView.setAnimationTransition(transition, for: forView, cache: true)
        }, completion: {(finished) in
            
            completion?()
        
        })
    }
    
    
    
    ///停止所有动画
    func mb_removeAnimations() {
        self.layer.removeAllAnimations()
    }
    
    /// 角度转弧度
    func degressToRadians(_ angle:CGFloat) -> CGFloat{
        return CGFloat(Double(angle) * M_PI / 180)
    }
    
   
    ///向左动画
    func mb_leftAnimate(_ x: CGFloat,duration: TimeInterval,completion: CompleteBlock){

        UIView.animate(withDuration: duration, animations: {
            self.left = x
        }, completion: {(finish) in
            completion?()
        })
    }
    
    func mb_leftAnimate(_ x: CGFloat,completion: CompleteBlock){
        self.mb_leftAnimate(x, duration:DEFAULT_DURATION , completion: completion)
    }
    
    
    ///向下动画
    
    func mb_downAnimation(_ y: CGFloat,duration: TimeInterval, completion: CompleteBlock){
        UIView.animate(withDuration: duration, animations: {
        
            self.top = y
        }, completion: {(finshed) in
            
            completion?()
        })
    }
    
    
    func mb_downAnimation(_ y: CGFloat, completion: CompleteBlock){
        self.mb_downAnimation(y, duration: DEFAULT_DURATION, completion: completion)
    }

    /// 旋转
    //  @param angle      角度， 为-1的时候一直转.  0~180

    func mb_retateAnimate(_ angle: CGFloat,duretion: TimeInterval, completion: CompleteBlock){
    
        var option: UIViewAnimationOptions
        var angle = angle
        if angle == -1 {
            angle = 180
            option = [.repeat,.curveLinear]
        }else{
        
            option = .curveLinear
        }
        
        UIView.animate(withDuration: duretion, delay: 0, options: option, animations: {
        
            self.transform = CGAffineTransform(rotationAngle: self.degressToRadians(angle))
            
        }, completion: {(finished) in
        
            completion?()
        })
        
        
    }
    
    /// 在原来基础上动画移动
    func mb_moveX(_ x: CGFloat,duration: TimeInterval,completion: CompleteBlock){
        self.mb_leftAnimate(self.frame.origin.x + x, duration: duration, completion: completion)
    }
    
    func mb_moveX(_ x: CGFloat,completion: CompleteBlock){
        self.mb_leftAnimate(self.frame.origin.x + x, duration: DEFAULT_DURATION, completion: completion)
    }
    
    func mb_moveY(_ y:CGFloat, duration: TimeInterval,completion: CompleteBlock){
        self.mb_downAnimation(self.frame.origin.y + y, duration: duration, completion: completion)
    }
    
    func mb_moveY(_ y:CGFloat, completion:CompleteBlock){
        self.mb_downAnimation(self.frame.origin.y + y, duration: DEFAULT_DURATION, completion: completion)
    }
    
    
     //MARK: - 左右摇摆
    func mb_shakeAnnimation(_ range:CGFloat,duration:TimeInterval,completion:CompleteBlock){
        self.mb_moveX(-range, duration: duration, completion: {
            self.mb_moveX(range * 2, duration: duration, completion: {
                self.mb_moveX(range, duration: duration, completion:{
                    completion?()
                })
            })
        })
    }
    
    
    func mb_shake(){
        self.mb_shakeAnnimation(10.0, duration: DEFAULT_DURATION, completion: nil)
    }
    
    
     //MARK: - 上下摇摆
    func mb_bounceAnimation(_ range: CGFloat,duration:TimeInterval,completion: CompleteBlock){
        self.mb_moveY(-range, duration: duration, completion: {
        
            self.mb_moveY(range, duration: duration, completion: {
            
                self.mb_moveY(-(range/2), duration: duration, completion: {
                    
                    completion?()
                })
            })
        })
    }
    
    
    
    func mb_bounceAnimation() {
        self.mb_bounceAnimation(10, duration: DEFAULT_DURATION, completion: nil)
    }
    
    
     //MARK: - 心跳
    func mb_heartbeatAnimation(_ range:CGFloat, duration:TimeInterval,completion: CompleteBlock){
        UIView.animate(withDuration: duration, animations: {
            self.transform = CGAffineTransform(scaleX: range, y: range)
        }, completion: {(finished) in
            UIView.animate(withDuration: duration, delay: 0.1 as TimeInterval, options: [.layoutSubviews,.curveEaseOut], animations: {
                self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }, completion: { (finished) in
                completion?()
            })
        })
    }
    
    
    func mb_hearbeatAnimaiton() {
        self.mb_heartbeatAnimation(1.2, duration: DEFAULT_DURATION, completion: nil)
    }
    
     //MARK: - 摇摆
    func mb_swingAnimaition(_ range:CGFloat, duration: TimeInterval,completion: CompleteBlock) {
        
        self.mb_retateAnimate(range, duretion: duration, completion: {
            self.mb_retateAnimate(-range, duretion: duration, completion: {
                self.mb_retateAnimate(range/2, duretion: duration, completion: {
                    self.mb_retateAnimate(0, duretion: duration, completion: {
                        completion?()
                    })
                })
            })
        })
    }
    
    func mb_swingAnimation() {
        self.mb_retateAnimate(15, duretion: DEFAULT_DURATION, completion: nil)
    }
    
     //MARK: - 放大缩小
    func mb_scaleAnimaition(_ scale:CGFloat,duration:TimeInterval,completion:CompleteBlock){
        UIView.animate(withDuration: duration, animations: {
            self.transform = CGAffineTransform(scaleX: scale, y: scale)
        })
    }
    
    func mb_scaleAnimation(scale: CGFloat) {
        self.mb_scaleAnimaition(scale, duration: DEFAULT_DURATION, completion: nil)
    }
    
    
     //MARK: - 宽放大缩小
    func mb_scaleX(_ scale: CGFloat,duration: TimeInterval,completion: CompleteBlock) {
        UIView.animate(withDuration: duration, animations: {
        
            self.transform = CGAffineTransform(scaleX: scale, y: 1)
        })
    }
    
    func mb_scaleX(scale:CGFloat) {
        self.mb_scaleX(scale, duration: DEFAULT_DURATION, completion: nil)
    }
    
     //MARK: - 高放大缩小
    func mb_scaleY(_ scale: CGFloat,duraion: TimeInterval,completion: CompleteBlock) {
        UIView.animate(withDuration: duraion, animations: {
            self.transform = CGAffineTransform(scaleX: 1, y: scale)
        })
    }
    
    func mb_scaleY(scale: CGFloat) {
        self.mb_scaleY(scale, duraion: DEFAULT_DURATION, completion: nil)
    }
    
    
     //MARK: - 渐显
    func mb_fadeIn(_ duration: TimeInterval,completion: CompleteBlock) {
        self.isHidden = false
        self.alpha = 0
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 1
        },completion:{ (finished) in
            completion?()
        })
    }
    
    func mb_dadeIn() {
        self.mb_fadeIn(DEFAULT_DURATION, completion: nil)
    }
    
     //MARK: - 渐隐
    func mb_fadeOut(_ duration: TimeInterval,completion: CompleteBlock) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 0.0
        
        }, completion: {(finished) in
        
            completion?()
        })
    }
    
    
    func mb_fadeOut() {
        self.mb_fadeOut(DEFAULT_DURATION, completion: nil)
    }
    
    
     //MARK: - 呼吸灯
    func mb_blink(duration:TimeInterval) {
        UIView.animate(withDuration: duration, delay: 0, options: [.repeat,.autoreverse], animations: {
        
            self.alpha = 0
        }, completion: nil)
    }
    
    func mb_blink() {
        self.mb_blink(duration: DEFAULT_DURATION)
    }
    
    
     //MARK: - 翻页
    func mb_paging(_ duration:TimeInterval,completion:CompleteBlock) {
        
        self.mb_Animation(duration, transition: .curlUp, forView: self, completion: completion)
    }
    
    
    func mb_paging(){
        self.mb_paging(0.1, completion: nil)
    }
    
     //MARK: - 翻转
    
    func mb_flipAnimation(_ duration: TimeInterval,completion:CompleteBlock) {
        self.mb_Animation(duration, transition: .flipFromLeft, forView: self, completion: completion)
    }
    
    func mb_flipAnimation() {
        self.mb_flipAnimation(DEFAULT_DURATION, completion: nil)
    }
    
    
    
     //MARK: - 掉落
    
    func mb_drop(_ duration:TimeInterval, completion: CompleteBlock) {
        
        // 移动锚点
        let point = CGPoint(x: self.frame.origin.x, y: self.frame.origin.y)
        self.layer.anchorPoint = CGPoint(x: 0, y: 0)
        self.center = point
        
        self.mb_retateAnimate(80, duretion: duration, completion: {
            self.mb_retateAnimate(70, duretion: duration, completion: {
                self.mb_retateAnimate(80, duretion: duration, completion: {
                    self.mb_retateAnimate(70, duretion: duration, completion: {
                    
                        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: {
                        
                            self.top = UIScreen.main.bounds.height
                        }, completion: { (finished) in
                            
                            completion?()

                        })
                    })
                    
                })
            
            })
        
        })
    }
    
    
    
    
    func mb_drop() {
        self.mb_drop(DEFAULT_DURATION, completion: nil)
    }
    
    
    
}
