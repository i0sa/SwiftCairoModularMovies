import XCTest
@testable import MoviesListFeature
@testable import SwiftCairoCommon

extension Movie: Equatable {
    public static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.preparationMinutes == rhs.preparationMinutes &&
        lhs.image == rhs.image &&
        lhs.headline == rhs.headline
    }
}
