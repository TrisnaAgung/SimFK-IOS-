// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let absensi = try? newJSONDecoder().decode(Absensi.self, from: jsonData)

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseAbsensi { response in
//     if let absensi = response.result.value {
//       ...
//     }
//   }

import Foundation
import Alamofire

// MARK: - Absensi
class Absensi: Codable {
    var data: [DataAbsensi]
    var makan, insentif: Insentif
    
    init(data: [DataAbsensi], makan: Insentif, insentif: Insentif) {
        self.data = data
        self.makan = makan
        self.insentif = insentif
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
class DataAbsensi: Codable {
    var nip, tanggal, checkIn: String
    var checkOut: String?
    var ipIn: String
    var ipOut: String?
    var menit: String
    var fingerIn: Finger
    var fingerOut: Finger?
    
    enum CodingKeys: String, CodingKey {
        case nip, tanggal
        case checkIn = "check_in"
        case checkOut = "check_out"
        case ipIn = "ip_in"
        case ipOut = "ip_out"
        case menit
        case fingerIn = "finger_in"
        case fingerOut = "finger_out"
    }
    
    init(nip: String, tanggal: String, checkIn: String, checkOut: String?, ipIn: String, ipOut: String?, menit: String, fingerIn: Finger, fingerOut: Finger?) {
        self.nip = nip
        self.tanggal = tanggal
        self.checkIn = checkIn
        self.checkOut = checkOut
        self.ipIn = ipIn
        self.ipOut = ipOut
        self.menit = menit
        self.fingerIn = fingerIn
        self.fingerOut = fingerOut
    }
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseFinger { response in
//     if let finger = response.result.value {
//       ...
//     }
//   }

// MARK: - Finger
class Finger: Codable {
    var id: Int
    var nama, ip, aktif: String
    
    init(id: Int, nama: String, ip: String, aktif: String) {
        self.id = id
        self.nama = nama
        self.ip = ip
        self.aktif = aktif
    }
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseInsentif { response in
//     if let insentif = response.result.value {
//       ...
//     }
//   }

// MARK: - Insentif
class Insentif: Codable {
    var desc: String
    var fee: Int
    
    init(desc: String, fee: Int) {
        self.desc = desc
        self.fee = fee
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
    func responseAbsensi(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<Absensi>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
}

