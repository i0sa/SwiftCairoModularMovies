Pod::Spec.new do |spec|
    spec.name                   = 'MovieDetailsFeature'
    spec.version                = '1.0.0'
    spec.summary                = 'Movie Details Feature Module for SwiftCairoMovies Project'
    spec.homepage               = 'https://swiftcairo.com'
    spec.source                 = { :git => '.', :tag => spec.version.to_s }
    spec.author                 = { 'Osama Gamal' => 'me@i0sa.com' }

    spec.ios.deployment_target  = '13.0'

    spec.source_files           = 'MovieDetailsFeature/MovieDetailsFeature/**/*.{swift}'

    spec.dependency               'SwiftCairoCommon'
    spec.dependency               'SwiftCairoDesignSystem'

end
