//
//  AnimalDetailViewController.swift
//  AnimalPharmacy
//
//  Created by 60080254 on 2020/09/01.
//  Copyright © 2020 60080254. All rights reserved.
//

import UIKit

class AnimalDetailViewController: UIViewController {
    
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var sex: UILabel!
    @IBOutlet weak var kindCd: UILabel!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var happenDate: UILabel!
    @IBOutlet weak var happenPlace: UILabel!
    @IBOutlet weak var careAddr: UILabel!
    @IBOutlet weak var noticeNo: UILabel!
    @IBOutlet weak var careTel: UILabel!
    @IBOutlet weak var specialMark: UILabel!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var dataView: UIView!
    
    var ageData: String = "나이"
    var sexData: String = "성별"
    var kindCdData: String = "품종"
    var weightData: String = "무게"
    var happenDtData: String = "발견 날짜"
    var happenPlaceData: String = "발견 장소"
    var careAddrData: String = "보호소 주소"
    var noticeNoData: String = "공고번호"
    var careTelData: String = "보호소 전화번호"
    var urlData: String = "이미지 주소"
    var neutrData: String = "중성화 여부"
    var specialMarkData: String = "특이 사항"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let sextmp = sexData == "F" ? "암컷" : "수컷"
        let placeholder: UIImage? = UIImage.init(named: "animal.png")
        
        age.text = ageData
        sex.text = "\(sextmp) / 중성화(\(neutrData))"
        kindCd.text = kindCdData
        weight.text = weightData
        happenPlace.text = happenPlaceData
        happenDate.text = happenDtData
        careAddr.text = careAddrData
        noticeNo.text = noticeNoData
        careTel.text = careTelData
        specialMark.text = specialMarkData
    
        
        photo.imageFromURL(urlString: urlData, placeholder: placeholder) {
            
        }
        // Do any additional setup after loading the view.
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
