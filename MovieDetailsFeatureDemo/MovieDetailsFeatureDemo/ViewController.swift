//
//  ViewController.swift
//  MovieDetailsFeatureDemo
//
//  Created by Osama Gamal on 06/06/2023.
//

import UIKit
import MovieDetailsFeature
import SwiftCairoCommon
import ConsumerNetworking

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func didTapOpenDetailsScreen(_ sender: UIButton) {
        let screenConfigurator = MovieDetailsConfigurator()
        let fakeDependencyContainer = FakeDependencyContainer()
        let fakeNavigator = FakeNavigator()
        let fakeMovie = Movie.init(title: "Test", year: 2010, poster: "https://careem.com/logo.png")
        
        let screen = screenConfigurator.configure(dependencies: fakeDependencyContainer,
                                                  navigator: fakeNavigator,
                                                  movie: fakeMovie)
        self.present(screen, animated: true)
    }
}

class FakeDependencyContainer: DependencyContainerType {
    var networking: SwiftCairoCommon.NetworkingType = NetworkingService()
    var cache: SwiftCairoCommon.SwiftCairoCache = FakeCacheService()
}

class FakeNavigator: Navigator {
    func navigate(to destination: SwiftCairoCommon.Destination, type: SwiftCairoCommon.NavigationType) {
        print("Should navigate to \(destination)")
    }
}


class FakeCacheService: SwiftCairoCache {
    func save<T>(_ object: T, forKey key: String) throws where T : Decodable, T : Encodable {
        print("Should save \(key)")
    }
    
    func fetch<T>(forKey key: String) throws -> T where T : Decodable, T : Encodable {
        print("Should fetch")
        
        return "Any" as! T
    }
}
