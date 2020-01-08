import Foundation
import Alamofire

// MARK: - Tipe
class Tipe: Codable {
    var data: [TipeData]
    
    init(data: [TipeData]) {
        self.data = data
    }
}

class TipeData: Codable {
    var kode, desc: String
    
    init(kode: String, desc: String) {
        self.kode = kode
        self.desc = desc
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
    func responseTipe(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<Tipe>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
}

