//
//  ViewController.swift
//  Animation
//
//  Created by user on 16/12/6.
//  Copyright © 2016年 mobin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var AnimationView: UIView!
    var viewFrame : CGRect!
    
    
    var dataSource = ["闪亮","左右摇","上下摇","心跳","摇摆","缩小","放大","掉落","翻转","翻页","推出","覆盖","揭开","3D立方","抽走","不停旋转","渐隐","渐现"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        viewFrame = AnimationView.frame
    }
    
    
    
    


}

extension ViewController: UIPickerViewDataSource,UIPickerViewDelegate{



    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        
        return dataSource.count
    }
    

    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataSource[row]
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //
        AnimationView.transform = CGAffineTransform.identity
        AnimationView.frame = viewFrame
        AnimationView.alpha = 1
        
        switch row {
        case 0:
            AnimationView.mb_blink()
        case 1:
            AnimationView.mb_shake()
        case 2:
            AnimationView.mb_bounceAnimation()
        case 3:
            AnimationView.mb_hearbeatAnimaiton()
        case 4:
            AnimationView.mb_swingAnimation()
        case 5:
            AnimationView.mb_scaleAnimation(scale: 0.1)
        case 6:
            AnimationView.mb_scaleAnimation(scale: 2.0)
        case 7:
            AnimationView.mb_drop()
        case 8:
            AnimationView.mb_flipAnimation()
        case 9:
            AnimationView.mb_paging()
        case 10:
            //                fade     //交叉淡化过渡(不支持过渡方向)
            //                push     //新视图把旧视图推出去
            //                moveIn   //新视图移到旧视图上面
            //                reveal   //将旧视图移开,显示下面的新视图
            //                cube     //立方体翻滚效果
            //                oglFlip  //上下左右翻转效果
            //                suckEffect   //收缩效果，如一块布被抽走(不支持过渡方向)
            //                rippleEffect //滴水效果(不支持过渡方向)
            //                pageCurl     //向上翻页效果
            //                pageUnCurl   //向下翻页效果
            //                cameraIrisHollowOpen  //相机镜头打开效果(不支持过渡方向)
            //            cameraIrisHollowClose //相机镜头关上效果(不支持过渡方向)
            
            
            //            subType:
            //            kCATransitionFromRight
            //            kCATransitionFromLeft
            //            kCATransitionFromTop
            //            kCATransitionFromBottom
            
            AnimationView.mb_Animation(kCATransitionPush, subType: kCATransitionFromRight, duration: 1.0)
            
        case 11:
            AnimationView.mb_Animation(kCATransitionMoveIn, subType: kCATransitionFromRight, duration: 1.0)
            
        case 12:
            AnimationView.mb_Animation(kCATransitionReveal, subType: kCATransitionFromRight, duration: 1.0)
            
        case 13:  //立方
            AnimationView.mb_Animation("cube", subType: kCATransitionFromRight, duration: 1.0)
            
        case 14:
            AnimationView.mb_Animation("suckEffect", subType: kCATransitionFromRight, duration: 1.0)
            
        case 15:  //不停旋转. 如果执行过掉落，这里可能有问题
            AnimationView.mb_retateAnimate(-1, duretion: 1, completion: nil)
            
        case 16:  //渐隐
            AnimationView.mb_fadeOut()
            
        case 17:  //渐现
            AnimationView.mb_fadeIn(0.2, completion: nil)

        
        default:
            break
        }
        
    }
    

}

