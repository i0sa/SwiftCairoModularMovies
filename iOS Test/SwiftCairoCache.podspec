Pod::Spec.new do |spec|
    spec.name                   = 'SwiftCairoCache'
    spec.version                = '1.0.0'
    spec.summary                = 'Cache Module for MoviesList Project'
    spec.homepage               = 'https://swiftcairo.com'
    spec.source                 = { :git => '.', :tag => spec.version.to_s }
    spec.author                 = { 'Osama Gamal' => 'me@i0sa.com' }

    spec.ios.deployment_target  = '13.0'

    spec.source_files           = 'SwiftCairoCache/SwiftCairoCache/*.{swift}'
    
    spec.dependency               'SwiftCairoCommon'
    
    spec.test_spec  'UnitTests' do |test_spec|
        test_spec.source_files  = 'SwiftCairoCache/Tests/**/*'
        test_spec.requires_app_host = true
    end

end
