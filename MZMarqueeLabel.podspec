Pod::Spec.new do |spec|
  spec.name         = "MZMarqueeLabel"
  spec.version      = "0.0.1"
  spec.summary      = "循环滚动、跑马灯、Marquee"
  spec.homepage     = "https://github.com/1691665955/MZMarqueeLabel"
  spec.authors         = { 'MZ' => '1691665955@qq.com' }
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.source = { :git => "https://github.com/1691665955/MZMarqueeLabel.git", :tag => spec.version}
  spec.platform     = :ios, "9.0"
  spec.swift_version = '5.0'
  spec.source_files  = "MZMarqueeLabel/MZMarqueeLabel/*"
end
