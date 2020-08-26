//
//  AnimalPharmacy.swift
//  AnimalPharmacy
//
//  Created by 60080254 on 2020/08/21.
//  Copyright © 2020 60080254. All rights reserved.
//
import Foundation

protocol AnimalPharmacyModelProtocol {
    func pharmacyRetrieved(pharmacy:[APData])
}
class AnimalPharmacyModel {
    
    var delegate:AnimalPharmacyModelProtocol?
    
    func generateData() {
        var dataList = [APData]()
        var dataStructure: AnimalPharmacy?
        
        /*api 로 데이터 받아옴*/
        let key = "2834b7e952534b96b36c149cd1cda27e"
        let baseURL = "https://openapi.gg.go.kr/AnimalPharmacy?KEY=\(key)&Type=json&pIndex=1&pSize=100"
        
        guard let url = URL(string: baseURL) else { return }
        
        
        // *1-4. 준비된 url로 데이터를 받아오는 작업
        URLSession.shared.dataTask(with: url) { data, response, error in
            //            ...  // 전달 받은 data, response, error 를 이용해 처리하는 블럭(클로저)
            // *3-1. 에러가 발생했는지 먼저 확인!
            guard error == nil else {
                print(error!)
                return
            }
            // *3-2. 데이터가 잘 받아졌는지 확인!
            guard let resData = data else { return }
            do {
                // *3-3. 받아진 데이터로 json parsing!
                dataStructure = try JSONDecoder().decode(AnimalPharmacy.self, from: resData)
                // *3-4. json을 parsing 하는 것은 다른 thread 에서 발생하는 것 다받은 데이터를 처리
                DispatchQueue.main.async(execute: {
                    if let list = dataStructure?.AnimalPharmacy.row.row {
                        for pharm in list {
                            if pharm.BSN_STATE_NM == "정상" {
                                /*전화번호 처리*/
                                var telNo = pharm.LOCPLC_FACLT_TELNO ??  "번호 없음"
                                if !(telNo.contains("-")) && telNo != "번호 없음"{
                                    telNo.insert("-", at: telNo.index(telNo.startIndex, offsetBy: 3))
                                    if telNo.count > 8 {
                                        telNo.insert("-", at: telNo.index(telNo.endIndex, offsetBy: -4))
                                    }
                                }
                                dataList.append(APData(name: pharm.BIZPLC_NM ?? "약국 이름", sigunName: pharm.SIGUN_NM ?? "약국 시군구", location: pharm.REFINE_ROADNM_ADDR ?? "약국 주소", latitude: pharm.REFINE_WGS84_LAT ?? "128", longtude: pharm.REFINE_WGS84_LOGT ?? "35", telNo: telNo))
                            }
                        }
                    }
                    self.delegate?.pharmacyRetrieved(pharmacy: dataList)
                })
            } catch {
                print("Data Parsing Error")
            }
        }.resume()
        return
    }
    
    struct AnimalPharmacy: Decodable {
        let AnimalPharmacy: AllData
    }
    struct AllData: Decodable {
        let head: Head
        let row: RowData
        
        init(from decoder: Decoder) throws {
            var container = try decoder.unkeyedContainer()
            self.head = try container.decode(Head.self)
            self.row = try container.decode(RowData.self)
        }
    }
    
    struct RowData: Decodable {
        let row: [AnimalPharmacyData]
    }
    struct Head: Decodable {
        let head: HeadData
    }
    struct HeadData: Decodable {
        let list_total_count: ListTotalCount
        let RESULT: Result
        let api_version: ApiVersion
        init(from decoder: Decoder) throws {
            var container = try decoder.unkeyedContainer()
            self.list_total_count = try container.decode(ListTotalCount.self)
            
            self.RESULT = try container.decode(Result.self)
            
            self.api_version = try container.decode(ApiVersion.self)
        }
    }
    struct ListTotalCount: Decodable {
        let list_total_count: Int
    }
    struct Result: Decodable {
        let RESULT: ResultData
    }
    struct ResultData: Decodable {
        let MESSAGE: String
        let CODE: String
    }
    struct ApiVersion: Decodable {
        let api_version: String
    }
    struct AnimalPharmacyData: Decodable {
        let SIGUN_CD: String?
        let SIGUN_NM: String?
        let BIZPLC_NM: String?
        let LICENSG_DE: String?
        let BSN_STATE_NM: String?
        let LICENSG_CANCL_DE: String?
        let CLSBIZ_DE: String?
        let BSN_STATE_DIV_CD: String?
        let TOT_EMPLY_CNT: String?
        let SFRMPROD_PROCSBIZ_DIV_NM: String?
        let STOCKRS_DUTY_DIV_NM: String?
        let LOCPLC_FACLT_TELNO: String?
        let LOCPLC_AR_INFO: String?
        let ROADNM_ZIP_CD: String?
        let REFINE_LOTNO_ADDR: String?
        let REFINE_ROADNM_ADDR: String?
        let REFINE_ZIP_CD: String?
        let REFINE_WGS84_LOGT: String?
        let REFINE_WGS84_LAT: String?
        let BIZCOND_DIV_NM_INFO: String?
        let X_CRDNT_VL: String?
        let Y_CRDNT_VL: String?
        let STOCKRS_IDNTFY_NO: String?
        let RIGHT_MAINBD_IDNTFY_NO: String?
    }
    
}


