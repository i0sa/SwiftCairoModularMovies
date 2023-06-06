Pod::Spec.new do |spec|
    spec.name                   = 'SwiftCairoDesignSystem'
    spec.version                = '1.0.0'
    spec.summary                = 'Design System Module for SwiftCairoMovies Project'
    spec.homepage               = 'https://swiftcairo.com'
    spec.source                 = { :git => '.', :tag => spec.version.to_s }
    spec.author                 = { 'Osama Gamal' => 'me@i0sa.com' }

    spec.ios.deployment_target  = '13.0'

    spec.source_files           = 'SwiftCairoDesignSystem/**/*.{swift}'
    spec.resource_bundle = {
      'SwiftCairoDesignSystem' => [
        'SwiftCairoDesignSystem/SwiftCairoDesignSystem/**/*.{xib}'
      ]
    }
    
    spec.dependency               'Kingfisher'

end
