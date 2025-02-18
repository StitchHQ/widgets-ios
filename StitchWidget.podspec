Pod::Spec.new do |s|
  s.name             = 'StitchWidget'
  s.version          = '1.0.0'
  s.summary          = 'StitchWidget framework'

  s.description      = 'Common utilities'

  s.homepage         = 'https://zgit.csez.zohocorpin.com/desk-mobile/zd-portal-utilities'
  s.license          = { :type => 'MIT', :text => 'LICENSE' }
  s.authors          = { 'sudarvizhi' => 'vizhi1930@gmail.com'}
  s.source           = { :git => 'https://github.com/StitchHQ/widgets-ios.git', :tag => s.version }

  s.platform         = :ios, '13.0'

  s.source_files = 'StitchWidget/StitchWidget/**/*.{swift,h,m}'
  s.resources = 'StitchWidget/StitchWidget/**/*.{xcdatamodeld,png,ttf,js,css,gif,xib,xcassets,bundle,json}'
  s.public_header_files = 'StitchWidget/StitchWidget/**/*.{h}'

  s.swift_version = "5.0"
  s.dependency 'Alamofire'
  s.dependency 'CryptoSwift'
end
