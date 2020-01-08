// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let jadwalKelas = try? newJSONDecoder().decode(JadwalKelas.self, from: jsonData)

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseJadwalKelas { response in
//     if let jadwalKelas = response.result.value {
//       ...
//     }
//   }

import Foundation
import Alamofire

// MARK: - JadwalKelas
class JadwalKelas: Codable {
    var data: [JadwalData]
    
    init(data: [JadwalData]) {
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
class JadwalData: Codable {
    var id: Int
    var idJadwalKelas, tanggal, dosenNip: String
    var tipe: String?
    var checkIn: String?
    var checkOut: String?
    var tglBaru: JSONNull?
    var ruangBaru, jamAwal, jamAkhir: String
    var ip: JSONNull?
    var nim: String?
    var lama: String?
    var ruangbaru: Ruangbaru
    var ploting: Ploting
    var tipemengajar: Tipemengajar?
    
    enum CodingKeys: String, CodingKey {
        case id
        case idJadwalKelas = "id_jadwal_kelas"
        case tanggal
        case dosenNip = "dosen_nip"
        case tipe
        case checkIn = "check_in"
        case checkOut = "check_out"
        case tglBaru = "tgl_baru"
        case ruangBaru = "ruang_baru"
        case jamAwal = "jam_awal"
        case jamAkhir = "jam_akhir"
        case ip, nim, lama, ruangbaru, ploting, tipemengajar
    }
    
    init(id: Int, idJadwalKelas: String, tanggal: String, dosenNip: String, tipe: String?, checkIn: String?, checkOut: String?, tglBaru: JSONNull?, ruangBaru: String, jamAwal: String, jamAkhir: String, ip: JSONNull?, nim: String?, lama: String?, ruangbaru: Ruangbaru, ploting: Ploting, tipemengajar: Tipemengajar?) {
        self.id = id
        self.idJadwalKelas = idJadwalKelas
        self.tanggal = tanggal
        self.dosenNip = dosenNip
        self.tipe = tipe
        self.checkIn = checkIn
        self.checkOut = checkOut
        self.tglBaru = tglBaru
        self.ruangBaru = ruangBaru
        self.jamAwal = jamAwal
        self.jamAkhir = jamAkhir
        self.ip = ip
        self.nim = nim
        self.lama = lama
        self.ruangbaru = ruangbaru
        self.ploting = ploting
        self.tipemengajar = tipemengajar
    }
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responsePloting { response in
//     if let ploting = response.result.value {
//       ...
//     }
//   }

// MARK: - Ploting
class Ploting: Codable {
    var idJadwalKelas: Int
    var idRuangan, namaRuangan, noKelasMk, sks: String
    var kodeMk, namaMk, namaMkEn, idProdi: String
    var namaProdi, idJam, namaJam, jamMulai: String
    var jamSelesai, idHari, namaHari, tahunAkademik: String
    var tahunAjaran, groupSemester, tingkatSemester, idKelasMk: String
    var namaKelas: String
    
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

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseRuangbaru { response in
//     if let ruangbaru = response.result.value {
//       ...
//     }
//   }

// MARK: - Ruangbaru
class Ruangbaru: Codable {
    var idRuang: Int
    var kodeCyber, namaRuang, tipeRuang: String
    var deskRuang: String?
    var idGedung, kodeGedung, namaGedung, lokasiGedung: String
    var deskGedung: String
    var kapasitas: Int
    var kapasitasUjian: String
    var ip, finger: JSONNull?
    
    enum CodingKeys: String, CodingKey {
        case idRuang = "id_ruang"
        case kodeCyber = "kode_cyber"
        case namaRuang = "nama_ruang"
        case tipeRuang = "tipe_ruang"
        case deskRuang = "desk_ruang"
        case idGedung = "id_gedung"
        case kodeGedung = "kode_gedung"
        case namaGedung = "nama_gedung"
        case lokasiGedung = "lokasi_gedung"
        case deskGedung = "desk_gedung"
        case kapasitas
        case kapasitasUjian = "kapasitas_ujian"
        case ip, finger
    }
    
    init(idRuang: Int, kodeCyber: String, namaRuang: String, tipeRuang: String, deskRuang: String?, idGedung: String, kodeGedung: String, namaGedung: String, lokasiGedung: String, deskGedung: String, kapasitas: Int, kapasitasUjian: String, ip: JSONNull?, finger: JSONNull?) {
        self.idRuang = idRuang
        self.kodeCyber = kodeCyber
        self.namaRuang = namaRuang
        self.tipeRuang = tipeRuang
        self.deskRuang = deskRuang
        self.idGedung = idGedung
        self.kodeGedung = kodeGedung
        self.namaGedung = namaGedung
        self.lokasiGedung = lokasiGedung
        self.deskGedung = deskGedung
        self.kapasitas = kapasitas
        self.kapasitasUjian = kapasitasUjian
        self.ip = ip
        self.finger = finger
    }
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseTipemengajar { response in
//     if let tipemengajar = response.result.value {
//       ...
//     }
//   }

// MARK: - Tipemengajar
class Tipemengajar: Codable {
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
    func responseJadwalKelas(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<JadwalKelas>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

