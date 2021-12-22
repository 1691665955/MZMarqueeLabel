//
//  ViewController.swift
//  MZMarqueeLabel
//
//  Created by 曾龙 on 2021/12/22.
//

import UIKit

let SCREEN_WIDTH = UIScreen.main.bounds.size.width

class ViewController: UIViewController {
    @IBOutlet weak var otherMarqueeLabel: MZMarqueeLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let marqueeLabel = MZMarqueeLabel(frame: CGRect(x: 50, y: 100, width: SCREEN_WIDTH - 100, height: 40))
        marqueeLabel.backgroundColor = . orange
        marqueeLabel.setupText("我是marqueeLabel，你在干什么", font: .systemFont(ofSize: 20), textColor: .brown, whiteSpace: "************", speed: .Middle)
        self.view.addSubview(marqueeLabel)
        
        otherMarqueeLabel.setupText(String("我是一个大笨蛋,哈哈哈".reversed()), font: .systemFont(ofSize: 20), textColor: nil, whiteSpace: "        ", direction: .LeftToRight, speed: .Slow)
    }


}

