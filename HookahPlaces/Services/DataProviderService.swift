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
//Location: CLLocation?
//(DataResponse<LoginResult>) -> Void
protocol DataProviderService {
    typealias Location = (latitude: Double, longitude: Double)
    func fetch(_ resourceType: Decodable.Type, completion: @escaping (Result<Decodable, NetworkError>) -> Void)
    func fetchAll(_ resourceType: Decodable.Type, completion: @escaping (Result<[Decodable], NetworkError>) -> Void)
    func fetch(_ resourceType: Decodable.Type, near location: Location, completion: @escaping (Swift.Result<[Decodable], NetworkError>) -> Void)
}
