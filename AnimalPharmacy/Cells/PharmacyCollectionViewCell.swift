//
//  ShelterCollectionViewCell.swift
//  AnimalPharmacy
//
//  Created by 60080254 on 2020/08/27.
//  Copyright © 2020 60080254. All rights reserved.
//

import UIKit


/*보호소 찾기*/
class PharmacyCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var pharmacyTableView: UITableView!
    
    weak var navigationController: UINavigationController?
    
    let reuseID = "pharmacyPageCell"
    
    var pharmacy = [APData]()
    var model = AnimalPharmacyModel()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        model.delegate = self
        model.generateData()
        
        pharmacyTableView.separatorColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        pharmacyTableView.register(UINib(nibName: "PharmacyTableViewCell", bundle: nil), forCellReuseIdentifier: "pharmacyCell")
    }
}

extension PharmacyCollectionViewCell: AnimalPharmacyModelProtocol {
    func pharmacyRetrieved(pharmacy: [APData]) {
        self.pharmacy = pharmacy
        pharmacyTableView.reloadData()
    }
}


extension PharmacyCollectionViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pharmacy.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pharmacyCell", for: indexPath) as! PharmTableViewCell
        let target = pharmacy[indexPath.row]
        cell.display(pharmacy: target)
        return cell
    }

}

extension PharmacyCollectionViewCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mapVC = storyboard.instantiateViewController(withIdentifier: "pharmacyDetail") as! MapViewController
        let target = pharmacy[indexPath.row]
        pharmacyTableView.deselectRow(at: indexPath, animated: true)
        mapVC.fullAddr = target.location
        mapVC.lat = Double(target.latitude) ?? 128.0
        mapVC.log = Double(target.longtude) ?? 35.0
        self.navigationController?.pushViewController(mapVC, animated: true)
        
    }
    
}
