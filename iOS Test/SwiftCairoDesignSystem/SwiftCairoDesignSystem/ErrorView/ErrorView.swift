//
//  MovieItemCell.swift
//  MoviesListFeature
//
//  Created by Osama Gamal on 24/03/2023.
//

import UIKit
import SwiftCairoDesignSystem

public struct ErrorViewModel {
    let errorText: LabelViewModel
}

public class ErrorView: UIView {
    @IBOutlet weak var errorLabel: UILabel!
    public weak var delegate: ErrorViewDelegate?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }

    public convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    @IBAction func didClickRetry(_ sender: Any) {
        delegate?.didTapRetry()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }
    
    public func configure(viewModel: ErrorViewModel) {
        configureLabel(errorLabel, viewModel: viewModel.errorText)
    }
    
    private func configureLabel(_ label: UILabel, viewModel: LabelViewModel) {
        label.text = viewModel.text
        label.textColor = viewModel.color.uiColor
        var fontWeight: UIFont.Weight {
            switch viewModel.weight {
            case .normal: return .regular
            case .bold: return .bold
            default: return .regular
            }
        }
        label.font = UIFont.systemFont(ofSize: 15, weight: fontWeight)
    }

}

public protocol ErrorViewDelegate: AnyObject {
    func didTapRetry()
}
