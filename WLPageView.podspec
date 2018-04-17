
Pod::Spec.new do |s|
    s.name         = 'WLPageView'
    s.version      = '1.0.0'
    s.summary      = 'An easy way to use pageView'
    s.homepage     = 'https://github.com/DaLiangWang/WLPageView'
    s.license      = 'MIT'
    s.authors      = {'wangliang' => 'wangliang@gmail.com'}
    s.platform     = :ios, '8.0'
    s.source       = {:git => 'https://github.com/DaLiangWang/WLPageView.git', :tag => s.version}
    s.source_files = 'WLPageView/Class/**/*.{h,m}'
    # s.public_header_files = 'WLPageView/Class/Category/WL_Macros.h'
    s.requires_arc = true
    s.dependency "Masonry"

end