Pod::Spec.new do |spec|
    spec.name                   = 'MoviesListFeature'
    spec.version                = '1.0.0'
    spec.summary                = 'Movies List Feature Module for SwiftCairoMovies Project'
    spec.homepage               = 'https://swiftcairo.com'
    spec.source                 = { :git => '.', :tag => spec.version.to_s }
    spec.author                 = { 'Osama Gamal' => 'me@i0sa.com' }

    spec.ios.deployment_target  = '13.0'

    spec.source_files           = 'MoviesListFeature/MoviesListFeature/**/*.{swift}'
    spec.resource_bundle = {
      'MoviesListFeature' => [
        'MoviesListFeature/MoviesListFeature/**/*.{xib,xcassets}'
      ]
    }

    spec.dependency               'SwiftCairoCommon'
    spec.dependency               'SwiftCairoDesignSystem'

    spec.test_spec  'UnitTests' do |test_spec|
        test_spec.source_files  = 'MoviesListFeature/Tests/**/*'
        test_spec.requires_app_host = true
    end
end
