//
//  ContentfullDataProvider.swift
//  HookahPlaces
//
//  Created by Игорь Боляев on 08.12.2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import Foundation
import Contentful
//import os.log

extension Place: EntryDecodable, FieldKeysQueryable {
    static var contentTypeId: ContentTypeId {
        return "place"
    }
    enum FieldKeys: String, CodingKey {
      case name, locationCoord
    }
}

final class ContentfullDataProvider: DataProviderService {
    
    private let client = Client(spaceId: "zoxp97809y35",
                                environmentId: "master",
                                accessToken: "MtfLg1dtaxzim4faQ_K5qZMW2krMXoJz7XijtTfW7Qc",
                                contentTypeClasses: [Place.self])
    func fetchAll(_ resourceType: Decodable.Type, completion: @escaping (Swift.Result<[Decodable], NetworkError>) -> Void) {
        let query = QueryOn<Place>()

        client.fetchArray(of: Place.self, matching: query) { (result: Result<HomogeneousArrayResponse<Place>>) in
          switch result {
          case .success(let entriesArrayResponse):
            let items = entriesArrayResponse.items
            completion(.success(items))
          case .error(let error):
            completion(.failure(.backendProblem))
          }
        }
    }
    
    
    func fetch(_ resourceType: Decodable.Type, near location: DataProviderService.Location, completion: @escaping (Swift.Result<[Decodable], NetworkError>) -> Void) {
        let mappedLocation = Contentful.Location(latitude: location.latitude, longitude: location.longitude)
        let query = QueryOn<Place>().where(field: .locationCoord, .isNear(mappedLocation))
        client.fetchArray(of: Place.self, matching: query) { (result: Result<HomogeneousArrayResponse<Place>>) in
          switch result {
          case .success(let entriesArrayResponse):
            let items = entriesArrayResponse.items
            completion(.success(items))
          case .error(let error):
            completion(.failure(.backendProblem))
          }
        }
    }
    
    func fetch(_ resourceType: Decodable.Type, completion: @escaping (Swift.Result<Decodable, NetworkError>) -> Void) {
        client.fetch(Place.self, id: "3IB4eylBXsqLx5oHfRTxpj") { (result: Result<Place>) in
            switch result {
            case .success(let place):
                completion(.success(place))
            case .error(let error):
                completion(.failure(.backendProblem))
            }
        }
    }
}
