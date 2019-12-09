//
//  CheckIn.swift
//  Absensi
//
//  Created by Unit TSI on 02/12/19.
//  Copyright © 2019 technesia. All rights reserved.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let checkIn = try? newJSONDecoder().decode(CheckIn.self, from: jsonData)

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseCheckIn { response in
//     if let checkIn = response.result.value {
//       ...
//     }
//   }

import Foundation
import Alamofire

// MARK: - CheckIn
class CheckIn: Codable {
    var data: DataCheckin
    
    init(data: DataCheckin) {
        self.data = data
    }
}

class DataCheckin: Codable {
    var status: Bool
    
    init(status: Bool) {
        self.status = status
    }
}

extension DataRequest {
    fileprivate func decodableResponseSerializer<T: Decodable>() -> DataResponseSerializer<T> {
        return DataResponseSerializer { _, response, data, error in
            guard error == nil else { return .failure(error!) }
            
            guard let data = data else {
                return .failure(AFError.responseSerializationFailed(reason: .inputDataNil))
            }
            
            return Result { try newJSONDecoder().decode(T.self, from: data) }
        }
    }
    
    @discardableResult
    fileprivate func responseDecodable<T: Decodable>(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
        return response(queue: queue, responseSerializer: decodableResponseSerializer(), completionHandler: completionHandler)
    }
    
    @discardableResult
    func responseCheckIn(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<CheckIn>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
}

