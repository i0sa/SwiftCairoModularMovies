//
//  MoviesListViewController.swift
//  MoviesListFeature
//
//  Created by Osama Gamal on 24/03/2023.
//

import UIKit
import SwiftCairoDesignSystem

enum MoviesListViewControllerDisplayMode {
    case idle
    case loading
    case movies([MovieViewModel])
}

public final class MoviesListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var interactor: MoviesListSceneBusinessLogic!
    private var displayMode: MoviesListViewControllerDisplayMode = .idle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        interactor.fetchMoviesList()
    }
    
    init() {
        super.init(nibName: "MoviesListViewController", bundle: Bundle.module)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCellNib(cellClass: MovieItemCell.self, bundle: Bundle.module)
        tableView.registerCellNib(cellClass: MovieItemShimmerCell.self, bundle: Bundle.module)
        tableView.separatorStyle = .none
    }
}

extension MoviesListViewController: MoviesListSceneDisplayLogic {
    func displayMovies(_ viewModel: MoviesListViewModel) {
        self.displayMode = .movies(viewModel.movies)
        DispatchQueue.main.async { [weak self] in
            self?.tableView.backgroundView = nil
            self?.tableView.reloadData()
        }
    }
    
    func displayLoadingMoviesList() {
        self.displayMode = .loading
        DispatchQueue.main.async { [weak self] in
            self?.tableView.backgroundView = nil
        }
    }
    
    func displayFetchMoviesFailure() {
        let error = ErrorView()
        error.delegate = self
        DispatchQueue.main.async { [weak self] in
            self?.displayMode = .idle
            self?.tableView.backgroundView = error
            self?.tableView.reloadData()
        }
    }
}

extension MoviesListViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch displayMode {
        case .loading:
            let cell: MovieItemShimmerCell = tableView.dequeue()
            return cell
        case .movies(let movies):
            let movie = movies[indexPath.row]
            let cell: MovieItemCell = tableView.dequeue()
            cell.configure(movie)
            return cell
        case .idle:
            fatalError("No cells should be displayed at idle mode")
        }
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch displayMode {
        case .loading:
            return 5
        case .movies(let movies):
            return movies.count
        case .idle:
            return 0
        }
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor.selectMovieAtIndex(index: indexPath.row)
    }
}

extension MoviesListViewController: ErrorViewDelegate {
    public func didTapRetry() {
        interactor.fetchMoviesList()
    }
}
