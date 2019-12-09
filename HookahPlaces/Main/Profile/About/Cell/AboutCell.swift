//
//  AboutCell.swift
//  HookahPlaces
//
//  Created by Момотов Евгений Олегович on 09.12.2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import UIKit

final class AboutCell: RightArrowCell {
    static let identifier = String(describing: AboutCell.self)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: AboutCell.identifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(_ viewModel: AboutPresenter.ViewModel) {
        set(viewModel.title)
    }
}
