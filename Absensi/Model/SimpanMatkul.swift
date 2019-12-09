// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let simpanMatkul = try? newJSONDecoder().decode(SimpanMatkul.self, from: jsonData)

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseSimpanMatkul { response in
//     if let simpanMatkul = response.result.value {
//       ...
//     }
//   }

import Foundation
import Alamofire

// MARK: - SimpanMatkul
class SimpanMatkul: Codable {
    var data: DataClass
    
    init(data: DataClass) {
        self.data = data
    }
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseDataClass { response in
//     if let dataClass = response.result.value {
//       ...
//     }
//   }

// MARK: - DataClass
class DataClass: Codable {
    var status: String
    
    init(status: String) {
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
    func responseSimpanMatkul(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<SimpanMatkul>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
}

