//
//  Bundle.swift
//  SwiftCairoDesignSystem
//
//  Created by Osama Gamal on 25/03/2023.
//

import Foundation
private class DummyClass { }
extension Bundle {
    static let module: Bundle = {
        let main = Bundle(for: DummyClass.self)
        guard let path = main.path(forResource: "SwiftCairoDesignSystem", ofType: "bundle"),
                let bundle = Bundle(path: path) else {
                return main
        }
        return bundle
    }()
}
