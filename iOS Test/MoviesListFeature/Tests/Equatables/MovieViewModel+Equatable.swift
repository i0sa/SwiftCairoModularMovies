import XCTest
@testable import MoviesListFeature
import SwiftCairoCommon

extension MovieViewModel: Equatable {
    public static func == (lhs: MovieViewModel, rhs: MovieViewModel) -> Bool {
        return lhs.title == rhs.title &&
        lhs.subtitle == rhs.subtitle &&
        lhs.image == rhs.image &&
        lhs.preparationTimeText == rhs.preparationTimeText &&
        lhs.isSelected == rhs.isSelected
    }
}

extension MovieViewModel.Image: Equatable {
    public static func == (lhs: MovieViewModel.Image, rhs: MovieViewModel.Image) -> Bool {
        switch (lhs, rhs) {
        case (.none, .none):
            return true
        case (.url(let lhsUrl), .url(let rhsUrl)):
            return lhsUrl == rhsUrl
        default:
            return false
        }
    }
}
