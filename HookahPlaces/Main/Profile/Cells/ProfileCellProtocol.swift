//
//  ProfileCellProtocol.swift
//  HookahPlaces
//
//  Created by Евгений on 01/12/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import UIKit

protocol ProfileCellProtocol: UITableViewCell {
    static var identifier: String { get }
    func set(_ viewModel: ProfileViewModelProtocol)
}
