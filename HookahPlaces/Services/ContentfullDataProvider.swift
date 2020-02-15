//
//  ContentfullDataProvider.swift
//  HookahPlaces
//
//  Created by Игорь Боляев on 08.12.2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import Foundation
import Contentful

extension Place: EntryDecodable, FieldKeysQueryable {
    static var contentTypeId: ContentTypeId {
        return "place"
    }
    enum FieldKeys: String, CodingKey {
      case name
    }
}

final class ContentfullDataProvider: DataProviderService {
    
    private let client = Client(spaceId: "zoxp97809y35",
                                environmentId: "master",
                                accessToken: "MtfLg1dtaxzim4faQ_K5qZMW2krMXoJz7XijtTfW7Qc",
                                contentTypeClasses: [Place.self])
    
    func fetch(_ resourceType: Codable.Type, completion: @escaping (Swift.Result<Codable, NetworkError>) -> Void) {
        client.fetch(Place.self, id: "3IB4eylBXsqLx5oHfRTxpj") { (result: Result<Place>) in
            switch result {
            case .success(let place):
                print(place)
            case .error(let error):
                print("Error \(error)!")
            }
        }
    }
}
