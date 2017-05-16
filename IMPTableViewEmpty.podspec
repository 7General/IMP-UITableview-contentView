Pod::Spec.new do |s|
    s.name         = 'IMPTableViewEmpty'
    s.version      = '0.0.1'
    s.summary      = 'An easy way to use HZ-IMPTableViewEmpty'
    s.homepage     = 'https://github.com/7General/IMP-UITableview-contentView'
    s.license      = 'MIT'
    s.author       = { "王会洲" => "wanghuizhou21@163.com" }
    s.platform     = :ios, '7.0'
    s.source       = {:git => 'https://github.com/7General/IMP-UITableview-contentView.git', :tag => s.version}
    s.source_files = 'IMPStudy/IMPTableViewEmpty/**/*.{h,m}'
    s.requires_arc = true
end
