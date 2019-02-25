Pod::Spec.new do |s|
    s.name             = 'LXCountryCallingCodePicker'
    s.version          = '0.1.0'
    s.summary          = '有国旗图案的国家区号选择器，包含 250 个国家地区，支持通过名称、拼音、代码、区号搜索。'
    s.homepage         = 'https://github.com/949478479/LXCountryCallingCodePicker'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { '吕小怼' => '949478479@qq.com' }
    s.source           = { :git => 'https://github.com/949478479/LXCountryCallingCodePicker.git', :tag => s.version.to_s }
    
    s.swift_versions = ['4.0', '4.2', '5.0']
    s.ios.deployment_target = '8.0'
    s.source_files = 'LXCountryCallingCodePicker/Classes/**/*'
    s.resource_bundles = {
        'LXCountryCallingCodePicker' => ['LXCountryCallingCodePicker/Assets/*.{xcassets,json,storyboard}']
    }
end
