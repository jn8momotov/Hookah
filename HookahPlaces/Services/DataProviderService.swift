//
//  DataProviderService.swift
//  HookahPlaces
//
//  Created by Игорь Боляев on 08.12.2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import Foundation
enum NetworkError: Error {
    case backendProblem
}

//(DataResponse<LoginResult>) -> Void
protocol DataProviderService {
    func fetch(_ resourceType: Codable.Type, completion: @escaping (Result<Codable, NetworkError>) -> Void)
}
