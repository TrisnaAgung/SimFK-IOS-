// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let jadwalLive = try? newJSONDecoder().decode(JadwalLive.self, from: jsonData)

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseJadwalLive { response in
//     if let jadwalLive = response.result.value {
//       ...
//     }
//   }

import Foundation
import Alamofire

// MARK: - JadwalLive
class JadwalLive: Codable {
    var data: DataLive
    
    init(data: DataLive) {
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
class DataLive: Codable {
    var id: Int
    var idJadwalKelas, tanggal, dosenNip, checkIn: String
    var checkOut: String
    var tglBaru: JSONNull?
    var ruangBaru, jamAwal, jamAkhir: String
    var ip: JSONNull?
    var nim: String
    var ruangbaru: Ruangbaru
    var ploting: Ploting
    
    enum CodingKeys: String, CodingKey {
        case id
        case idJadwalKelas = "id_jadwal_kelas"
        case tanggal
        case dosenNip = "dosen_nip"
        case checkIn = "check_in"
        case checkOut = "check_out"
        case tglBaru = "tgl_baru"
        case ruangBaru = "ruang_baru"
        case jamAwal = "jam_awal"
        case jamAkhir = "jam_akhir"
        case ip, nim, ruangbaru, ploting
    }
    
    init(id: Int, idJadwalKelas: String, tanggal: String, dosenNip: String, checkIn: String, checkOut: String, tglBaru: JSONNull?, ruangBaru: String, jamAwal: String, jamAkhir: String, ip: JSONNull?, nim: String, ruangbaru: Ruangbaru, ploting: Ploting) {
        self.id = id
        self.idJadwalKelas = idJadwalKelas
        self.tanggal = tanggal
        self.dosenNip = dosenNip
        self.checkIn = checkIn
        self.checkOut = checkOut
        self.tglBaru = tglBaru
        self.ruangBaru = ruangBaru
        self.jamAwal = jamAwal
        self.jamAkhir = jamAkhir
        self.ip = ip
        self.nim = nim
        self.ruangbaru = ruangbaru
        self.ploting = ploting
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
    func responseJadwalLive(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<JadwalLive>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
}
