import XCTest
@testable import MoviesListFeature

extension MovieViewModel {
    static func stub(title: String = "Name",
                     subtitle: String = "Subtitle",
                     preparationTimeText: String = "35 Mins",
                     image: Image = .url(url: URL(string: "https://swiftcairo.com/logo.png")!),
                     isSelected: Bool = false) -> Self {
        return .init(title: title, subtitle: subtitle, preparationTimeText: preparationTimeText, image: image, isSelected: isSelected)
    }
}
