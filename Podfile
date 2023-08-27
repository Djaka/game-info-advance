# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

source 'https://github.com/CocoaPods/Specs.git'
source 'https://github.com/Djaka/game-common-podspec'
source 'https://github.com/Djaka/game-core-podspec'

use_frameworks!
workspace 'GameInfoAdvance'
project 'GameInfoAdvance'

def module_pods
  pod "Common", :git=>"https://github.com/Djaka/game-common", :tag=>"1.0.1"
  pod "Core", :git=>"https://github.com/Djaka/game-core", :tag=>"1.1.5"
end

target 'GameInfoAdvance' do
  module_pods
  pod 'SDWebImage'
  pod "SkeletonView"
  
  target 'GameInfoAdvanceTest' do
      inherit! :search_paths
      module_pods
  end
end

target 'Games' do
  project './Games/Games'
  module_pods
end

target 'Favorite' do
  project './Favorite/Favorite'
  module_pods
end

target 'Profile' do
  project './Profile/Profile'
  module_pods
end

post_install do |pi|
    pi.pods_project.targets.each do |t|
      t.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
      end
    end
end
