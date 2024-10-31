# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'UIKitPreviewNote' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for UIKitPreviewNote

pod 'YHTransitionKit', :git => 'https://github.com/yelinux/YHTransitionKit.git'
pod 'Masonry'
pod 'IQKeyboardManager'
pod 'MLeaksFinder', :git => 'https://github.com/Tencent/MLeaksFinder'

post_install do |installer|
    installer.generated_projects.each do |project|
          project.targets.each do |target|
              target.build_configurations.each do |config|
                  config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0'
               end
          end
   end
end
  
end
