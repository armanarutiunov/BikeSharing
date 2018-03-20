platform :ios, '10.0'
inhibit_all_warnings!
use_frameworks!

def rx_deps
    pod 'RxSwift', '~> 4.0'
    pod 'RxCocoa', '~> 4.0'
end

def network
    pod 'Moya', '~> 10.0.0'
    pod 'Moya-Gloss'
    pod 'Moya-Gloss/RxSwift'
end

target 'BikeSharing' do
    rx_deps

    pod 'RxDataSources'
    pod 'Swinject', '~> 2.1'
    pod 'GoogleMaps'
end

target 'DataLayer' do
    rx_deps
    network
end

target 'ModelLayer' do
    rx_deps
    pod 'RxDataSources'
end

target 'ModelLayerTests' do
    rx_deps
    pod 'RxDataSources'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['ENABLE_BITCODE'] = 'NO'
        end
    end
end
