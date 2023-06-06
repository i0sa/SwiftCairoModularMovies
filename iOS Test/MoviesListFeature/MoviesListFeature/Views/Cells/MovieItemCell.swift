//
//  MovieItemCell.swift
//  MoviesListFeature
//
//  Created by Osama Gamal on 24/03/2023.
//

import UIKit
import SwiftCairoDesignSystem

class MovieItemCell: UITableViewCell {    
    @IBOutlet weak var listItemView: ListItemView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func configure(_ viewModel: MovieViewModel) {
        let image: ListItemViewModel.Image
        switch viewModel.image {
        case .none:
            image = .local(name: "ImageLoadError", bundle: Bundle.module)
        case .url(let url):
            image = .remote(url: url)
        }
        
        let listItemViewModel = ListItemViewModel(
            image: image,
            title: .init(text: viewModel.title, weight: .bold, color: .black),
            subtitle: .init(text: viewModel.subtitle, weight: .normal, color: .black))
        
        
        listItemView.configure(viewModel: listItemViewModel)
    }
}
