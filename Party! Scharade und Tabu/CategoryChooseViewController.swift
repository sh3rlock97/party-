//
//  CategoryChooseViewController.swift
//  Party! Scharade und Tabu
//
//  Created by Marino Schmid on 15.06.19.
//  Copyright © 2019 Marino Schmid. All rights reserved.
//

import UIKit
class Category {
    var id : Int = 0
    var name : String = ""
    var desc : String = ""
    init(_ id : Int, _ name : String, _ desc : String) {
        self.id = id
        self.name = name
        self.desc = desc
    }
}
class CategoryChooseViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    var categories : [Category] = []
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "category", for: indexPath) as! categoryCollectionViewCell
        cell.title.text = categories[indexPath.row].name
        cell.desc.text = categories[indexPath.row].desc
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/4, height: collectionView.frame.height)
    }

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        categories = [Category(1, "Activity", "Stelle den Begriff dar ohne zu sprechen!"),Category(1, "Test", "TEst")]
        collectionView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if #available(iOS 13.0, *) {
            let vc = storyboard.instantiateViewController(identifier: "game")
            vc.modalPresentationStyle = .overCurrentContext
            self.present(vc, animated: true, completion: nil)
            print("TEST")
        } else {
            // Fallback on earlier versions
        }
        
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
