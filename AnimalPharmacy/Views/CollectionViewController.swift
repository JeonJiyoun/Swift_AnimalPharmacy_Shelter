//
//  CollectionViewController.swift
//  AnimalPharmacy
//
//  Created by 60080254 on 2020/08/26.
//  Copyright © 2020 60080254. All rights reserved.
//

import UIKit

private let reuseIdentifier = "collectionCell"

class CollectionViewController: UIViewController, XMLParserDelegate {
    @IBOutlet var tabPageView: UIView!
    @IBOutlet weak var pageCollectionView: UICollectionView!
    @IBOutlet weak var firstTab: UIButton!
    @IBOutlet weak var secondTab: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*초기 세팅*/
        firstTab.setTitleColor(#colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1), for: .normal)
        secondTab.setTitleColor(.lightGray, for: .normal)
        
        pageCollectionView.register(UINib(nibName: "ProtectedAnimalCell", bundle: nil), forCellWithReuseIdentifier: "protectedAnimalCell")
        pageCollectionView.register(UINib(nibName: "AnimalPharmacyCell", bundle: nil), forCellWithReuseIdentifier: "pharmacyPageCell")
    
        
    }
    
    
    @IBAction func tabFirst(_ sender: Any) {
        firstTab.setTitleColor(#colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1), for: .normal)
        secondTab.setTitleColor(.lightGray, for: .normal)
        pageCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0) as IndexPath, at: .left, animated: true)
    }
    
    @IBAction func tabSecond(_ sender: Any) {
        secondTab.setTitleColor(#colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1), for: .normal)
        firstTab.setTitleColor(.lightGray, for: .normal)
        pageCollectionView.scrollToItem(at: IndexPath(item: 0, section: 1) as IndexPath, at: .left, animated: true)
        
    }
    
    
}

extension CollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = pageCollectionView.dequeueReusableCell(withReuseIdentifier: "protectedAnimalCell", for: indexPath) as! ProtectedAnimalCollectionViewCell
            cell.navigationController = self.navigationController
            return cell
            
        }
        else {
            let cell = pageCollectionView.dequeueReusableCell(withReuseIdentifier: "pharmacyPageCell", for: indexPath) as! PharmacyCollectionViewCell
            cell.backgroundColor = .orange
            cell.navigationController = self.navigationController
            return cell
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: tabPageView.frame.width , height: pageCollectionView.frame.height)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        if x > 0 {
            tabSecond([])
        }
        else {
            tabFirst([])
        }
    }
    
}

/*
 // Uncomment this method to specify if the specified item should be highlighted during tracking
 override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
 return true
 }
 */

/*
 // Uncomment this method to specify if the specified item should be selected
 override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
 return true
 }
 */

/*
 // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
 override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
 return false
 }
 
 override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
 return false
 }
 
 override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
 
 }
 */


