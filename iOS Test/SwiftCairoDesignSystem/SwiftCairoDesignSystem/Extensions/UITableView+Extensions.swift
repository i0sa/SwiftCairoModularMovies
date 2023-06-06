//
//  UITableView+Extensions.swift
//  SwiftCairoDesignSystem
//
//  Created by Osama Gamal on 25/03/2023.
//

import Foundation
import UIKit

public extension UITableView {
    func registerCellNib<Cell: UITableViewCell>(cellClass: Cell.Type, bundle: Bundle){
        self.register(UINib(nibName: String(describing: Cell.self), bundle: bundle), forCellReuseIdentifier: String(describing: Cell.self))
    }

    func dequeue<Cell: UITableViewCell>() -> Cell{
        let identifier = String(describing: Cell.self)
        
        guard let cell = self.dequeueReusableCell(withIdentifier: identifier) as? Cell else {
            fatalError("Error in cell")
        }
        
        return cell
    }
}
