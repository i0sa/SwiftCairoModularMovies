Pod::Spec.new do |spec|
  spec.name                   = 'ConsumerNetworking'
  spec.version                = '1.0.0'
  spec.summary                = 'Consumer networking'
  spec.homepage               = 'https://swiftcairo.com'
  spec.source                 = { :git => '.', :tag => spec.version.to_s }
  spec.author                 = { 'Osama Gamal' => 'me@i0sa.com' }
  
  spec.ios.deployment_target  = '13.0'
  
  spec.source_files           = 'ConsumerNetworking/ConsumerNetworking/**/*.{swift}'
  spec.dependency               'SwiftCairoCommon'
  
  spec.test_spec  'UnitTests' do |test_spec|
    test_spec.source_files  = 'ConsumerNetworking/Tests/**/*'
    test_spec.requires_app_host = true
  end
  
end
