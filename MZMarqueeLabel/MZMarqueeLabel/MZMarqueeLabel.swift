//
//  MZMarqueeLabel.swift
//  MZMarqueeLabel
//
//  Created by 曾龙 on 2021/12/22.
//

import UIKit

/// 文字滚动方向
enum MZMarqueeDirection {
    case RightToLeft    //  从右向左滚动
    case LeftToRight    //  从左向右滚动
}


/// 文字滚动速度、每秒多少个字
enum MZMarqueeSpeed {
    case Slow       //  3
    case Middle     //  4
    case Fast       //  5
    case from(Int)  //  自定义
}

class MZMarqueeLabel: UIView {

    private lazy var firstLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    private lazy var lastLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }
    
    private func setup() {
        self.clipsToBounds = true
    }

    
    /// 设置MarqueeLabel相关属性
    /// - Parameters:
    ///   - text: 显示的文字
    ///   - font: 显示文字的Font
    ///   - textColor: 显示文字的颜色
    ///   - whiteSpace: 滚动间隔文字
    ///   - direction: 滚动方向
    ///   - speed: 滚动速度
    func setupText(_ text: String, font: UIFont?, textColor: UIColor?, whiteSpace: String = "    ", direction: MZMarqueeDirection = .RightToLeft, speed: MZMarqueeSpeed = .Middle) {
        firstLabel.text = "\(text)\(whiteSpace)"
        if font != nil {
            firstLabel.font = font
        }
        if textColor != nil {
            firstLabel.textColor = textColor
        }
        
        lastLabel.text = "\(text)\(whiteSpace)"
        if font != nil {
            lastLabel.font = font
        }
        if textColor != nil {
            lastLabel.textColor = textColor
        }
        
        if self.subviews.count == 0 {
            self.addSubview(firstLabel)
            self.addSubview(lastLabel)
        }
        
        let maxSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: self.frame.height)
        let firstSize = firstLabel.sizeThatFits(maxSize)
        let lastSize = lastLabel.sizeThatFits(maxSize)
        if firstSize.width > self.frame.width {
            if direction == .LeftToRight {
                firstLabel.frame = CGRect(x: self.frame.width - firstSize.width, y: 0, width: firstSize.width, height: self.frame.height)
                lastLabel.frame = CGRect(x: self.frame.width - firstSize.width - lastSize.width, y: 0, width: lastSize.width, height: self.frame.height)
            } else {
                firstLabel.frame = CGRect(x: 0, y: 0, width: firstSize.width, height: self.frame.height)
                lastLabel.frame = CGRect(x: firstSize.width, y: 0, width: lastSize.width, height: self.frame.height)
            }
            
            var speedValue: Int = 4
            switch speed {
            case .Slow:
                speedValue = 3
            case .Middle:
                speedValue = 4
            case .Fast:
                speedValue = 5
            case .from(let value):
                speedValue = value
            }
            self.updateLabelFrame(withDirection: direction, andDuration: Double(text.count) / Double(speedValue))
        } else {
            firstLabel.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
            lastLabel.frame = CGRect(x: self.frame.width, y: 0, width: self.frame.width, height: self.frame.height)
        }
        
    }
        
    
    private func updateLabelFrame(withDirection direction: MZMarqueeDirection, andDuration duration: TimeInterval) {
        UIView.transition(with: self, duration: duration, options: .curveLinear) {
            var firstFrame = self.firstLabel.frame
            var lastFrame = self.lastLabel.frame
            if (direction == .LeftToRight) {
                firstFrame.origin.x = firstFrame.origin.x + (firstFrame.width + lastFrame.width) * 0.5
                self.firstLabel.frame = firstFrame
                lastFrame.origin.x = lastFrame.origin.x + (firstFrame.width + lastFrame.width) * 0.5
                self.lastLabel.frame = lastFrame
            } else {
                firstFrame.origin.x = firstFrame.origin.x - (firstFrame.width + lastFrame.width) * 0.5
                self.firstLabel.frame = firstFrame
                lastFrame.origin.x = lastFrame.origin.x - (firstFrame.width + lastFrame.width) * 0.5
                self.lastLabel.frame = lastFrame
            }
        } completion: { finished in
            // 0.01为处理浮点数的误差
            if finished {
                let firstFrame = self.firstLabel.frame
                let lastFrame = self.lastLabel.frame
                if direction == .LeftToRight {
                    if firstFrame.minX + 0.01 >= self.frame.width {
                        self.firstLabel.frame = CGRect(x: lastFrame.minX - firstFrame.width, y: 0, width: firstFrame.width, height: firstFrame.height)
                    } else if lastFrame.minX + 0.01 >= self.frame.width {
                        self.lastLabel.frame = CGRect(x: firstFrame.minX - lastFrame.width, y: 0, width: lastFrame.width, height: lastFrame.height)
                    }
                } else {
                    if firstFrame.maxX <= 0.01 {
                        self.firstLabel.frame = CGRect(x: lastFrame.maxX, y: 0, width: firstFrame.width, height: firstFrame.height)
                    } else if lastFrame.maxX <= 0.01 {
                        self.lastLabel.frame = CGRect(x: firstFrame.maxX, y: 0, width: lastFrame.width, height: lastFrame.height)
                    }
                }
                self.updateLabelFrame(withDirection: direction, andDuration: duration)
            }
        }

    }
}
