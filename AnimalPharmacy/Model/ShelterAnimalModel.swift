//
//  ShelterAnimal.swift
//  AnimalPharmacy
//
//  Created by 60080254 on 2020/08/26.
//  Copyright © 2020 60080254. All rights reserved.
//

import Foundation
/*
 **유기 동물 조회
 http://openapi.animal.go.kr/openapi/service/rest/abandonmentPublicSrvc/abandonmentPublic?ServiceKey=GV9oF1kJ7TEhlXW311QqGaE3tPHLqFVU7YClXVzc%2F9qo%2FtZtJo4giGpu39Sya2cX6ir%2Fc1qjge1H249PFvAsew%3D%3D
 parmas
 bgnde - 유기 날짜 (검색 시작일)
 endde - 유기 날짜 (검색 종료일)
 upkind - 417000: 개, 422400: 고양이
 upr_cd - 시도코드
 org_cd - 시군구코드
 care_reg_no - 보호소번호
 state - 상태. notice: 공고중, protect: 보호중
 neuter_yn - 중성화여부, Y N U
 
 
 
 */

//protocol ShelterAnimalModelProtocl {
//    func animalRetrieved(animal:[)
//}
let CAT:String = "422400"
let DOG:String = "417000"

class ShelterAnimalModel {
   
    
    
}


enum Sido {
    enum Seoul: String{
        case val =  "6110000"
        enum Sigun: String{
            case home = "6119999"
            case gangnam = "3220000"
            case gangdong = "3240000"
            case gangbook = "3080000"
            case gangseo = "3150000"
            case gwanak = "3200000"
            case gwangjin = "3040000"
            case guro = "3160000"
            case gumcheon = "3170000"
            case nowon = "3100000"
            case dobong = "3090000"
            case dongdaemun = "3050000"
            case dongjak = "3190000"
            case mapo = "3130000"
            case seodaemun = "3120000"
            case all = "6119998"
            case seocho = "3210000"
            case seongdong = "3030000"
            case seongbook = "3070000"
            case songpa = "3230000"
            case yangcheon = "3140000"
            case yeongdengpo = "3180000"
            case yongsan = "3020000"
            case eunpyeong = "3110000"
            case jongro = "3000000"
            case jung = "3010000"
            case jungrang = "3060000"
        }
    }
    enum Busan:String {
        case val = "6260000"
        enum Sigun: String{
            case gangseo = "3360000"
            case geumjeong = "3350000"
            case gijang = "3400000"
            case nam = "3310000"
            case dong = "3270000"
            case dongrae = "3300000"
            case busanjin = "3290000"
            case book = "3320000"
            case sasang = "3390000"
            case saha = "3340000"
            case seo = "3260000"
            case suyoung = "3380000"
            case yeonje = "3370000"
            case youndo = "3280000"
            case joong = "3250000"
            case haeundae = "3330000"
        }
    }
    enum Daegu:String{
        case val = "6270000"
        enum Sigun: String {
            case nam = "3440000"
            case dalseo = "3470000"
            case dalseong = "3480000"
            case dong = "3420000"
            case book = "3450000"
            case seo = "3430000"
            case suseong = "3460000"
            case joong = "3410000"
        }
        
    }
    enum Incheon:String{
        case val = "6280000"
        enum Sigun: String{
            case kanghwa = "3570000"
            case hyeyang = "3550000"
            case namdong = "3530000"
            case dong = "3500000"
            case michuhol = "3510500"
            case bupyeong = "3540000"
            case seo = "3560000"
            case yeonsu = "3520000"
            case ongjin = "3580000"
            case joong = "3490000"
        }
        
    }
    enum Gwangju:String{
        case val = "6290000"
        enum Sigun: String{
            case gwangsan = "3630000"
            case nam = "3610000"
            case dong = "3590000"
            case book = "3620000"
            case seo = "3600000"
        }
        
    }
    enum Sejong:String{
        case val = "5690000"
    }
    enum Daejeon:String{
        case val = "6300000"
        enum Sigun: String{
            case daeduk = "3680000"
            case dong = "3640000"
            case seo = "3660000"
            case yuseong = "3670000"
            case joong = "3650000"
        }
    }
    enum Ulsan:String{
        case val = "6310000"
        enum Sigun: String{
            case ulju = "3730000"
            case nam = "3700000"
            case dong = "3710000"
            case book = "3720000"
            case joong = "3690000"
        }
        
    }
    enum Gyeonggi:String{
        case val = "6410000"
        enum Sigun: String{
            case gapyeong = "4160000"
            case goyang = "3940000"
            case gwacheon = "3970000"
            case gwangmyeong = "3900000"
            case gwangju = "5540000"
            case guri = "3980000"
            case gunpo = "4020000"
            case kimpo = "4090000"
            case namyangju = "3990000"
            case dongducheon = "3920000"
            case bucheon = "3860000"
            case seongnam = "3780000"
            case suwon = "3740000"
            case siheung = "4010000"
            case ansan = "3930000"
            case anseong = "4080000"
            case anyang = "3830000"
            case yangju = "5590000"
            case yangpeong = "4170000"
            case yeoju = "5700000"
            case yeoncheon = "4140000"
            case osan = "4000000"
            case yongin = "4050000"
            case yonginkiheung = "5630000"
            case euiwang = "4030000"
            case euijeongbu = "3820000"
            case icheon = "4070000"
            case paju = "4060000"
            case pyeongtaek = "3910000"
            case pocheon = "5600000"
            case hanam = "4040000"
            case hwaseong = "5530000"
        }
    }
    enum Kangwon:String{
        case val = "6420000"
        enum Sigun:String {
            case gangreung = "4200000"
            case goseong = "4340000"
            case donghae = "4210000"
            case samcheok = "4240000"
            case sokcho = "4230000"
            case yanggu = "4320000"
            case yangyang = "4350000"
            case yeongwol = "4270000"
            case wonju = "4190000"
            case injae = "4330000"
            case jeongsun = "4290000"
            case cheolwon = "4300000"
            case choonchun = "4180000"
            case taebaek = "4220000"
            case pyeongchang = "4280000"
            case hongchun = "4250000"
            case hwachun = "4310000"
            case hoingsung = "4260000"
        }
    }
}
