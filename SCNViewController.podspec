Pod::Spec.new do |s|
  s.name = 'SCNViewController'
  s.version = '1.1.0'
  s.summary = 'The Missing SCNViewController Class (a Swift µ-library)'
  s.description = "A Swift micro-library that provides a configurable/reusable SCNViewController class— a UIViewController subclass with a SceneKit SCNView."
  s.homepage = 'https://github.com/capnslipp/SCNViewController'
  s.license = { :type => 'Public Domain', :file => 'LICENSE' }
  s.author = { 'capnslipp' => 'SCNViewController@capnslipp.com' }
  s.source = { :git => 'https://github.com/capnslipp/SCNViewController.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/capnslipp'
  s.ios.deployment_target = '8.0'
  s.tvos.deployment_target = '9.0'
  s.source_files = 'Sources/**/*'
  s.frameworks = 'UIKit', 'SceneKit'
  s.weak_frameworks = 'AVFoundation'
end
