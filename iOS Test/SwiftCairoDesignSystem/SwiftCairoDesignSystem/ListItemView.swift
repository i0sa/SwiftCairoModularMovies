//
//  ListItemView.swift
//  SwiftCairoDesignSystem
//
//  Created by Osama Gamal on 25/03/2023.
//

import Foundation
import UIKit
import Kingfisher

public struct ListItemViewModel {
    public init(image: ListItemViewModel.Image,
                title: LabelViewModel,
                subtitle: LabelViewModel) {
        self.image = image
        self.title = title
        self.subtitle = subtitle
    }
    
    let image: Image
    let title: LabelViewModel
    let subtitle: LabelViewModel
    
    public enum Image {
        case local(name: String, bundle: Bundle)
        case remote(url: URL)
    }
}

public final class ListItemView: UIView {
    @IBOutlet weak var containerView: UIView!
    private var shadowLayer: CAShapeLayer!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!

    private enum Constants {
        static let cornerRadius: CGFloat = 20
    }
    
    public func configure(viewModel: ListItemViewModel) {
        configureImage(image: viewModel.image)
        configureLabel(firstLabel, viewModel: viewModel.title)
        configureLabel(secondLabel, viewModel: viewModel.subtitle)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
        setupUI()
    }

    public convenience init() {
        self.init(frame: CGRect.zero)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
        setupUI()
    }
    
    func setupUI() {
        containerView.layer.cornerRadius = Constants.cornerRadius
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
    
    private func configureImage(image: ListItemViewModel.Image) {
        switch image {
        case .remote(let url):
            imageView.kf.indicatorType = .activity
            imageView.kf.setImage(with: url)
        case .local(let name, let bundle):
            imageView.image = UIImage(named: name, in: bundle, compatibleWith: nil)
        }
    }

    
    public override func layoutSubviews() {
        super.layoutSubviews()

        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: Constants.cornerRadius).cgPath
            shadowLayer.fillColor = UIColor.white.cgColor

            shadowLayer.shadowColor = UIColor.darkGray.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 0, height: 0)
            shadowLayer.shadowOpacity = 0.3
            shadowLayer.shadowRadius = 10

            containerView.layer.insertSublayer(shadowLayer, at: 0)
            // ------------------------------
            // Set corner radius of imageView
            let imageViewMaskLayer = CAShapeLayer()
            imageViewMaskLayer.backgroundColor = UIColor.black.cgColor
            
            let maskPath = UIBezierPath(roundedRect: bounds,
                                        byRoundingCorners: [.topLeft, .topRight],
                                        cornerRadii: CGSize(width: Constants.cornerRadius, height: Constants.cornerRadius))
            
            // Update the mask layer's path
            imageViewMaskLayer.path = maskPath.cgPath
            imageView.layer.mask = imageViewMaskLayer

        }
    }

}
