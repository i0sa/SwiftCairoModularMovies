import XCTest
@testable import MoviesListFeature
import SwiftCairoCommon

extension Movie {
    static func stub(id: String = "0",
                     name: String = "Name",
                     headline: String = "Headline",
                     image: String = "https://imagewebsite.com/image.png",
                     preparationMinutes: Int = 10) -> Self {
        return .init(id: id, name: name, headline: headline, image: image, preparationMinutes: preparationMinutes)
    }
}
