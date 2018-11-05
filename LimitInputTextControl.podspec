Pod::Spec.new do |s|
    s.name             = 'LimitInputTextControl'
    s.version          = '0.0.1'
    s.summary          = '限制输入长度以及字数控件'
    s.description      = <<-DESC
    支持 UITextField 文字输入字数限制
    支持 UITextView 文字输入行数以及字数限制
    DESC

    s.homepage         = 'https://github.com/0x1306a94/LimitInputTextControl'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { '0x1306a94' => '0x1306a94@gmail.com' }
    s.source           = { :git => 'https://github.com/0x1306a94/LimitInputTextControl.git', :tag => s.version.to_s }

    s.ios.deployment_target = '8.0'

    s.source_files = 'LimitInputTextControl/Classes/**/*.{h,m}'

    # s.resource_bundles = {
    #   'LimitInputTextControl' => ['LimitInputTextControl/Assets/*.png']
    # }

    # s.public_header_files = 'Pod/Classes/**/*.h'
    s.frameworks = 'UIKit'
end
