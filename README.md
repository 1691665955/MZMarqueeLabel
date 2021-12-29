# MZMarqueeLabel
循环滚动、跑马灯、Marquee

<div align=center>
<img src="1.gif" width="300px" />
</div>

#### Cocoapods 引入
```
pod 'MZMarqueeLabel', '~> 0.0.1'
```

#### 使用
```
let marqueeLabel = MZMarqueeLabel(frame: CGRect(x: 50, y: 100, width: SCREEN_WIDTH - 100, height: 40))
// 设置MarqueeLabel相关属性
// text: 显示的文字
// font: 显示文字的Font
// textColor: 显示文字的颜色
// whiteSpace: 滚动间隔文字
// direction: 滚动方向
// speed: 滚动速度
marqueeLabel.setupText("我是marqueeLabel，你在干什么", font: .systemFont(ofSize: 20), textColor: .brown, whiteSpace: "************", speed: .Middle)
self.view.addSubview(marqueeLabel)
```
