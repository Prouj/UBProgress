Pod::Spec.new do |s|
  s.name     = 'UBProgress'
  s.version  = '1.0.0'
  s.platform = :ios, '9.0'
  s.summary  = 'Custom Progress Bars'
  s.homepage = 'https://github.com/Prouj/UBProgress'
  s.author   = { 'Larissa Uchôa' => 'ltuchoa@gmail.com',
		'Paulo Uchôa' => '' }
  s.source   = { :git => 'https://github.com/Prouj/UBProgress.git', :tag => s.version.to_s }
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.source_files = 'UBProgress/UBProgress.{h,m}'
  s.requires_arc = true
end