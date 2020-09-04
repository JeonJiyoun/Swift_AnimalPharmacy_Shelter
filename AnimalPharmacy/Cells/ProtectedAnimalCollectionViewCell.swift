//
//  pageCollectionViewCell.swift
//  AnimalPharmacy
//
//  Created by 60080254 on 2020/08/26.
//  Copyright © 2020 60080254. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyXMLParser

class ProtectedAnimalCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var searchBar: UIView!
    @IBOutlet weak var filter: UILabel!
    @IBOutlet weak var dataTableView: UITableView!
    weak var navigationController: UINavigationController?
    
    var valIndex = [0, 2, 0]
    var animalData = [ShelterAnimalModel]()
    
    let cities = ["서울특별시", "부산광역시", "대구광역시", "인천광역시", "광주광역시", "대전광역시", "울산광역시"]
    let cities_val = ["6110000", "6260000", "6270000", "6280000", "6290000", "6300000", "6310000"]
    let siguns = [["서울전체", "가정", "강남구", "강동구", "강북구" , "강서구", "관악구", "광진구", "구로구" , "금천구"  ,"노원구" , "도봉구", "동대문구", "동작구"  ,"마포구" , "서대문구" , "서초구" , "성동구", "성북구" ,"송파구" , "양천구" , "영등포구" , "용산구", "은평구", "종로구" , "중구" , "중랑구"],["강서구", "금정구" ,"기장구", "남구", "동구" , "동래구" , "부산진구", "북구", "사상구" , "사하구", "서구", "수영구", "연제구", "연도구", "중구", "해운대구" ],["남구" , "달서구" , "달성군" , "동구" , "북구" , "서구" , "수성구" , "중구" ], ["강화구" , "혜양구" , "남동구" , "동구" , "미추홀구", "부평구" , "서구" , "연수구" , "옹진구" , "중구" ],["광산구" ,"남구" , "동구" , "북구" , "서구" ],["대덕구", "동구","서구" , "유성구", "중구"],["울주군","남구", "동구" , "북구", "중구"]]
    let siguns_val = [["6119998", "6119999", "3220000", "3240000",  "3080000", "3150000", "3200000", "3040000",  "3160000",  "3170000" , "3100000", "3090000", "3050000","3190000" , "3130000",  "3120000", "3210000", "3030000",  "3070000", "3230000","3140000", "3140000", "3020000", "3110000", "3000000",  "3010000", "3060000"],["3360000",  "3350000", "3400000","3310000", "3270000", "3300000", "3290000", "3320000",  "3390000",  "3340000", "3260000", "3380000", "3370000","3280000",  "3250000",  "3330000"],[ "3440000", "3470000","3480000","3420000", "3450000", "3430000",  "3460000",  "3410000"], ["3570000", "3550000","3530000", "3500000", "3510500",  "3540000",  "3560000",  "3520000", "3580000", "3490000"],["3630000","3610000",  "3590000",  "3620000",  "3600000"],[
        "3680000", "3640000","3660000", "3670000", "3650000"],["3730000","3700000","3710000","3720000", "3690000"]]
    let type = ["개", "고양이"]
    let type_val = ["417000","422400"]
    let pickerView = UIPickerView()
    var pageNo = 1
    var hasMoreData = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let tapRound = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        var pickerRect = pickerView.frame
        
        filter.isUserInteractionEnabled = true
        filter.addGestureRecognizer(tapRound)
        filter.text = "서울특별시\t\t강남구\t\t개"
        
        pickerRect.origin.x = 0
        pickerRect.origin.y = 40
        pickerRect.size.width = UIScreen.main.bounds.width
        pickerView.frame = pickerRect
        pickerView.delegate = self
        pickerView.selectRow(2, inComponent: 1, animated: false)
        pickerView.backgroundColor = .white
        pickerView.isHidden = true
        self.addSubview(pickerView)
        
        dataTableView.register(UINib(nibName: "AnimalTableViewCell", bundle: nil), forCellReuseIdentifier: "animalTableCell")
        requestData(["upr_cd":cities_val[valIndex[0]], "org_cd": siguns_val[valIndex[0]][valIndex[1]], "upkind": type_val[valIndex[2]]])
        
        /*당겨서 새로고침*/
        dataTableView.refreshControl = UIRefreshControl()
        dataTableView.refreshControl?.addTarget(self, action: #selector(pullToRefresh(_:)), for: .valueChanged)
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hitView = super.hitTest(point, with: event)
       
        if hitView == self {
            print("//")
        }
        return hitView
    }
    
    func getURL(_ params:[String: Any]) -> URL {
        let key = "GV9oF1kJ7TEhlXW311QqGaE3tPHLqFVU7YClXVzc%2F9qo%2FtZtJo4giGpu39Sya2cX6ir%2Fc1qjge1H249PFvAsew%3D%3D"
        let baseURL = "http://openapi.animal.go.kr/openapi/service/rest/abandonmentPublicSrvc/abandonmentPublic"
        
        let urlParams = params.compactMap({ (key, value) -> String in
            return "\(key)=\(value)"
        }).joined(separator: "&")
        
        let withURL = baseURL + "?\(urlParams)"
        let encoded = withURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)! + "&serviceKey=" + key
        return URL(string:encoded)!
    }
    
    
    func requestData(_ params:[String: Any] = [:], isNewSearch:Bool = true) {
        let url = getURL(params)
        if isNewSearch{
            self.animalData = [ShelterAnimalModel]()
            hasMoreData = true
            pageNo = 1
        }
        print(url)
        AF.request(url, method: .get).responseData {response in
            if let data = response.data {
                let xml = XML.parse(data)
                
                for item in xml.response.body.items.item {
                    self.animalData.append(ShelterAnimalModel(age: item.age.text ?? "2020년생", careAddr: item.careAddr.text ?? "보호소 주소", careTel: item.careTel.text ?? "보호소전화번호", careNm: item.careNm.text ?? "보호소", colorCd: item.colorCd.text ?? "애기 색", photo: item.filename.text ?? "nil", happenDt: item.happenDt.text ?? "발견 날짜", happenPlace: item.happenPlace.text ?? "발견된 장소", neuterYn: item.neuterYn.text ?? "중성화여부", weight: item.weight.text ?? "애기 무게", kindCd: item.kindCd.text ?? "품종", specialMark: item.specialMark.text ?? "특징", sexCd: item.sexCd.text ?? "성별", noticeNo: item.noticeNo.text ?? "공고번호"))
                }
                
                if ceil((xml.response.body.totalCount.double ?? 10.0) / (xml.response.body.numOfRows.double ?? 10.0)) <= Double(self.pageNo){
                    self.hasMoreData = false
                }
                //                print(self.animalData.count, "relaod before")
                self.dataTableView.reloadData()
            }
            
        }
        //        print("after reload")
    }
    
    @IBAction func setSearchFilter(_ sender: Any) {
        requestData(["upr_cd":cities_val[valIndex[0]], "org_cd": siguns_val[valIndex[0]][valIndex[1]], "upkind": type_val[valIndex[2]]])
        pickerView.isHidden = true
    }
    
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil){
        pickerView.isHidden = !pickerView.isHidden
    }
    
    @objc func pullToRefresh(_ sender: Any) {
        DispatchQueue.global().async {
            self.requestData(["upr_cd":self.cities_val[self.valIndex[0]], "org_cd": self.siguns_val[self.valIndex[0]][self.valIndex[1]], "upkind": self.type_val[self.valIndex[2]]])
            
            DispatchQueue.main.async {
                self.dataTableView.reloadData()
                self.dataTableView.refreshControl?.endRefreshing()
                
            }
        }
        //        requestData(["upr_cd":cities_val[valIndex[0]], "org_cd": siguns_val[valIndex[0]][valIndex[1]], "upkind": type_val[valIndex[2]]])
    }
    
}

extension ProtectedAnimalCollectionViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animalData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = dataTableView.dequeueReusableCell(withIdentifier: "animalTableCell", for: indexPath) as! AnimalTableViewCell
        let target = animalData[indexPath.row]
        let placeholder: UIImage? = UIImage.init(named: "animal.png")
        
        tableCell.animalImage.imageFromURL(urlString: target.photo, placeholder: placeholder) {
            //사이즈 같게 할 거니까 갱신할 필요 없음!
        }
        tableCell.setCell(animal: target)

        /*셀 마지막으로 가면 데이터 더 받아오기*/
        if indexPath.row == animalData.count - 1 && hasMoreData{
            pageNo += 1
            requestData(["upr_cd":cities_val[valIndex[0]], "org_cd": siguns_val[valIndex[0]][valIndex[1]], "upkind": type_val[valIndex[2]], "pageNo": pageNo], isNewSearch: false)            
        }
        return tableCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyboard.instantiateViewController(withIdentifier: "AnimalDetail") as! AnimalDetailViewController
        let target = animalData[indexPath.row]
        self.navigationController?.pushViewController(detailVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)

        detailVC.ageData = target.age
        detailVC.sexData = target.sexCd
        detailVC.kindCdData = target.kindCd
        detailVC.weightData = target.weight
        detailVC.happenPlaceData = target.happenPlace
        detailVC.happenDtData = target.happenDt
        detailVC.careAddrData = target.careAddr
        detailVC.noticeNoData = target.noticeNo
        detailVC.careTelData = target.careTel
        detailVC.neutrData = target.neuterYn
        detailVC.urlData = target.photo
        detailVC.specialMarkData = target.specialMark
        
    }
    
    
}
extension ProtectedAnimalCollectionViewCell: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return cities.count
        }
        else if component == 1{
            let selected = pickerView.selectedRow(inComponent: 0)
            return siguns[selected].count
        }
        else {
            return 2
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let title = UILabel()
        title.textColor = #colorLiteral(red: 0.2394758165, green: 0.6759230494, blue: 0.8100400567, alpha: 1)
        title.textAlignment = .center
        title.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.semibold)
        if component == 0{
            title.text = cities[row]
        }
        else if component == 1{
            let selected = pickerView.selectedRow(inComponent: 0)
            guard siguns[selected].count > row else {
                return title
            }
            title.text = siguns[selected][row]
        }
        else {
            title.text = type[row]
        }
        return title
    }
    
    /*스트링 & 하나의 속성만 설정해줄때*/
//    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
//        if component == 0{
//            return NSAttributedString(string: cities[row], attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2394758165, green: 0.6759230494, blue: 0.8100400567, alpha: 1)])
//        }
//        else if component == 1{
//            let selected = pickerView.selectedRow(inComponent: 0)
//            return NSAttributedString(string: siguns[selected][row], attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2394758165, green: 0.6759230494, blue: 0.8100400567, alpha: 1)])
//        }
//        else {
//            return NSAttributedString(string: type[row], attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2394758165, green: 0.6759230494, blue: 0.8100400567, alpha: 1)])
//        }
//    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selected0 = pickerView.selectedRow(inComponent: 0)
        let selected1 = pickerView.selectedRow(inComponent: 1)
        let selected2 = pickerView.selectedRow(inComponent: 2)
        
        var gungu = ""
        
        if component == 0 {
            pickerView.reloadComponent(1)
            pickerView.selectRow(0, inComponent: 1, animated: false)
            gungu = siguns[selected0][0]
            valIndex[1] = 0
        }
        if component == 1 {
            if siguns[selected0].count > selected1 {
                gungu = siguns[selected0][selected1]
                valIndex[1] = selected1
            }
            else {
                gungu = siguns[selected0][0]
                valIndex[1] = 0
            }
        }
        filter.text = "\(cities[selected0])\t\t \(gungu)\t\t \(type[selected2])"
        valIndex[0] = selected0
        valIndex[2] = selected2
    }
}
extension UIImageView {
    public func imageFromURL(urlString: String, placeholder: UIImage?, completion: @escaping () -> ()) {
        
        self.image = placeholder
        
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            if error != nil {
                print(error)
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
                self.setNeedsLayout()
                completion()
            })
        }).resume()
    }
}

