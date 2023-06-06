//
//  MovieDetailsView.swift
//  MovieDetailsFeature
//
//  Created by Osama Gamal on 06/06/2023.
//

import SwiftUI
import SwiftCairoCommon

struct MovieDetailsView: View {
    let movie: Movie
    
    var body: some View {
        Text("Hello, SwiftCairo!")
            .font(.title)
        Text("You have selected: \(movie.title)")
    }
}

struct MovieDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailsView(movie: .init(title: "test", year: 10, poster: "test"))
    }
}
