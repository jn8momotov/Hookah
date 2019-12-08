//
//  DetailPlaceCellProtocol.swift
//  HookahPlaces
//
//  Created by Момотов Евгений Олегович on 29.11.2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import UIKit

protocol DetailPlaceCellProtocol: UITableViewCell {
    func set(_ viewModel: DetailPlaceCellViewModelProtocol)
}
