Pod::Spec.new do |s|
s.name		= 'DataStream'
s.version	= '0.0.1'
s.summary	= 'An DataHandle view on iOS'
s.homepage	= 'https://github.com/MichaelZL/DataStream'
s.license	= { :type => 'MIT' }
s.platform	= 'ios'
s.author	= {'MichaelZL' => '821035751@qq.com'}
s.ios.deployment_target = '9.0'
s.source	= {:git => 'https://github.com/MichaelZL/DataStream.git', :tag => s.version}
s.source_files	= 'DataStream/*.swift'
s.requires_arc	= true
s.frameworks	= 'UIKit','WebKit'
s.dependency 'AFNetworking'
s.swift_version	= '4.1'
end
