// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let ruang = try? newJSONDecoder().decode(Ruang.self, from: jsonData)

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseRuang { response in
//     if let ruang = response.result.value {
//       ...
//     }
//   }

import Foundation
import Alamofire

// MARK: - Ruang
class Ruang: Codable {
    var data: [RuangData]
    
    init(data: [RuangData]) {
        self.data = data
    }
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseDatum { response in
//     if let datum = response.result.value {
//       ...
//     }
//   }

// MARK: - Datum
class RuangData: Codable {
    var kodeCyber: String?
    var namaRuang, namaGedung: String?
    
    enum CodingKeys: String, CodingKey {
        case kodeCyber = "kode_cyber"
        case namaRuang = "nama_ruang"
        case namaGedung = "nama_gedung"
    }
    
    init(kodeCyber: String?, namaRuang: String?, namaGedung: String?) {
        self.kodeCyber = kodeCyber
        self.namaRuang = namaRuang
        self.namaGedung = namaGedung
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
    func responseRuang(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<Ruang>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
}

