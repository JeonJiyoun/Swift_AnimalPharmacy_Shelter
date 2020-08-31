//
//  animalTableViewCell.swift
//  AnimalPharmacy
//
//  Created by 60080254 on 2020/08/28.
//  Copyright © 2020 60080254. All rights reserved.
//

import UIKit

class AnimalTableViewCell: UITableViewCell {

  
    @IBOutlet weak var kindCd: UILabel!
    @IBOutlet weak var animalImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setCell(animal:ShelterAnimalModel){
        kindCd.text = animal.kindCd
    }
}
