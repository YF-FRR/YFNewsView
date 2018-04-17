

Pod::Spec.new do |s|


  s.name         = "YFNewsViewPod"
  s.version      = "0.0.1"
  s.summary      = "第一个pod项目"

  s.description  = <<-DESC
            测试创建pod库
                   DESC

  s.homepage     = "https://github.com/YFXPP/YFNewsView/tree/master/YFNewsViewPod"


  s.license      = "MIT"


  s.author             = { "ios_yangfei" => "yangfei" }

  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/YFXPP/YFNewsView.git", :tag => "#{s.version}" }



  s.source_files  = "YFNewsViewPod", "YFNewsViewPod/**/*.{h,m}"
  s.exclude_files = "YFNewsView/Exclude"


end
