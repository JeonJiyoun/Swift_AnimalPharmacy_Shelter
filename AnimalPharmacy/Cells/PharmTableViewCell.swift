//
//  PharmTableViewCell.swift
//  AnimalPharmacy
//
//  Created by 60080254 on 2020/08/21.
//  Copyright © 2020 60080254. All rights reserved.
//

import UIKit

class PharmTableViewCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var sigun: UILabel!
    @IBOutlet weak var telNo: UILabel!
    
    
    var pharmacyToDisplay:APData?
    
    func display(pharmacy:APData){
        pharmacyToDisplay = pharmacy
 
        name.text = pharmacyToDisplay!.name
        sigun.text = pharmacyToDisplay!.sigunName
        telNo.text = pharmacyToDisplay!.telNo
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
