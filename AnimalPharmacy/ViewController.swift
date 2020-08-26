//
//  ViewController.swift
//  AnimalPharmacy
//
//  Created by 60080254 on 2020/08/19.
//  Copyright © 2020 60080254. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var listTableView: UITableView!
    
    var pharmacy = [APData]()
    var model = AnimalPharmacyModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.title = "동물 약국 현황"
        model.delegate = self
        model.generateData()
        
        listTableView.separatorColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        listTableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "header")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let mapView = segue.destination as? MapViewController else {
            return
        }
        if segue.identifier == "showMap" {

            if let obj = sender as? APData {
                mapView.fullAddr = obj.location
                mapView.lat = Double(obj.latitude) ?? 128.0
                mapView.log = Double(obj.longtude) ?? 35.0
            }
            
        }
    }
}

extension ViewController:AnimalPharmacyModelProtocol {
    func pharmacyRetrieved(pharmacy: [APData]) {
        self.pharmacy = pharmacy
        listTableView.reloadData()
    }
}
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pharmacy.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! PharmTableViewCell
        let target = pharmacy[indexPath.row]
        cell.display(pharmacy: target)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Animal Pharmacy List"
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row, "row!")
        print(pharmacy[indexPath.row], "data")
        performSegue(withIdentifier: "showMap", sender: pharmacy[indexPath.row])
    }
    

}

