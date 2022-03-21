//
//  FeedTableViewCell.swift
//  InstaBasicCloneApp
//
//  Created by Talha Varol on 21.03.2022.
//

import UIKit
import Firebase
class FeedTableViewCell: UITableViewCell {

    
    @IBOutlet weak var documentIdLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func likeButton(_ sender: Any) {
        let firestoreDatabase = Firestore.firestore()
        if let likeCount = Int(likeLabel.text!){
            let likeStore = ["likes": likeCount + 1] as [String : Any]
            firestoreDatabase.collection("Posts").document(documentIdLabel.text!).setData(likeStore, merge: true)
            
        }
     
    }
}
