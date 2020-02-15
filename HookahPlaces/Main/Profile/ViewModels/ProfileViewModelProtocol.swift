//
//  ProfileViewModelProtocol.swift
//  HookahPlaces
//
//  Created by Евгений on 01/12/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import Foundation

protocol ProfileViewModelProtocol {
    var identifier: String { get }
    var didTapCell: VoidHandler? { get }
}
