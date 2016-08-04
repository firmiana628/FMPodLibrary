
Pod::Spec.new do |s|
  s.name             = 'FMPodLibrary'
  s.version          = '0.1.0'
  s.summary          = 'a podsepc'

  s.description      = 'firmiana`s personal podsepc'


  s.homepage         = 'https://github.com/firmiana628/FMPodLibrary'

  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '张亚威' => 'zhang-yawei@foxmail.com' }
  s.source           = { :git => 'https://github.com/firmiana628/FMPodLibrary.git', :tag => s.version.to_s }


  s.ios.deployment_target = '7.0'

  s.source_files = 'FMPodLibrary/Classes/**/*'

   s.frameworks = 'UIKit'

end
