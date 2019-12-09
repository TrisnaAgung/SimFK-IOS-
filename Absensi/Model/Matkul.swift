// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let matkul = try? newJSONDecoder().decode(Matkul.self, from: jsonData)

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseMatkul { response in
//     if let matkul = response.result.value {
//       ...
//     }
//   }

import Foundation
import Alamofire

// MARK: - Matkul
class Matkul: Codable {
    var data: [Datum]
    
    init(data: [Datum]) {
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
class Datum: Codable {
    var idJadwalKelas: Int
    var idRuangan, namaRuangan, noKelasMk, sks: String
    var kodeMk: String
    var namaMk: String
    var namaMkEn: String
    var idProdi: String
    var namaProdi: String
    var idJam, namaJam: String
    var jamMulai: String
    var jamSelesai, idHari: String
    var namaHari: String
    var tahunAkademik: String
    var tahunAjaran: String
    var groupSemester: String
    var tingkatSemester, idKelasMk, namaKelas: String
    
    enum CodingKeys: String, CodingKey {
        case idJadwalKelas = "id_jadwal_kelas"
        case idRuangan = "id_ruangan"
        case namaRuangan = "nama_ruangan"
        case noKelasMk = "no_kelas_mk"
        case sks
        case kodeMk = "kode_mk"
        case namaMk = "nama_mk"
        case namaMkEn = "nama_mk_en"
        case idProdi = "id_prodi"
        case namaProdi = "nama_prodi"
        case idJam = "id_jam"
        case namaJam = "nama_jam"
        case jamMulai = "jam_mulai"
        case jamSelesai = "jam_selesai"
        case idHari = "id_hari"
        case namaHari = "nama_hari"
        case tahunAkademik = "tahun_akademik"
        case tahunAjaran = "tahun_ajaran"
        case groupSemester = "group_semester"
        case tingkatSemester = "tingkat_semester"
        case idKelasMk = "id_kelas_mk"
        case namaKelas = "nama_kelas"
    }
    
    init(idJadwalKelas: Int, idRuangan: String, namaRuangan: String, noKelasMk: String, sks: String, kodeMk: String, namaMk: String, namaMkEn: String, idProdi: String, namaProdi: String, idJam: String, namaJam: String, jamMulai: String, jamSelesai: String, idHari: String, namaHari: String, tahunAkademik: String, tahunAjaran: String, groupSemester: String, tingkatSemester: String, idKelasMk: String, namaKelas: String) {
        self.idJadwalKelas = idJadwalKelas
        self.idRuangan = idRuangan
        self.namaRuangan = namaRuangan
        self.noKelasMk = noKelasMk
        self.sks = sks
        self.kodeMk = kodeMk
        self.namaMk = namaMk
        self.namaMkEn = namaMkEn
        self.idProdi = idProdi
        self.namaProdi = namaProdi
        self.idJam = idJam
        self.namaJam = namaJam
        self.jamMulai = jamMulai
        self.jamSelesai = jamSelesai
        self.idHari = idHari
        self.namaHari = namaHari
        self.tahunAkademik = tahunAkademik
        self.tahunAjaran = tahunAjaran
        self.groupSemester = groupSemester
        self.tingkatSemester = tingkatSemester
        self.idKelasMk = idKelasMk
        self.namaKelas = namaKelas
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
    func responseMatkul(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<Matkul>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
}
