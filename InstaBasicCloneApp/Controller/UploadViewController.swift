//
//  UploadViewController.swift
//  InstaBasicCloneApp
//
//  Created by Talha Varol on 20.03.2022.
//

import UIKit
import Firebase
class UploadViewController: UIViewController, UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var mentText: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.isUserInteractionEnabled = true
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage) )
        imageView.addGestureRecognizer(recognizer)
        
        
    }
    
    
    @objc func chooseImage(){
        let pickerContoller = UIImagePickerController()
        pickerContoller.delegate = self
        pickerContoller.sourceType = .photoLibrary
        present(pickerContoller, animated: true, completion: nil)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    func makeAlert(titleInput:String, messageInput:String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func uploadButtonClicked(_ sender: Any) {
        //storage oluşturuldu, referans noktası oluşturuldu. referans ile kendi klasörümüze gidiyoruz.
        
        let storage = Storage.storage()
        let storageReferance = storage.reference()
        
        let mediaFolder = storageReferance.child("media")
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5){
            
            let uuıd = UUID().uuidString
            let imageReferanca = mediaFolder.child("\(uuıd).jpg")
            
            imageReferanca.putData(data, metadata: nil) { metadata, error in
                if error != nil{
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                }else{
                    imageReferanca.downloadURL { url, error in
                        if error == nil{
                            let imageUrl = url?.absoluteString
                            
                            // DataBase
                            let firestoreDatabase = Firestore.firestore()
                            var firestoreReferance: DocumentReference? = nil
                            let firestorePosts = ["imageUrl": imageUrl!,"postedBy": Auth.auth().currentUser!.email!,"postComment" : self.mentText.text!, "date": FieldValue.serverTimestamp(),"likes": 0 ] as [String : Any]
                            
                            firestoreReferance = firestoreDatabase.collection("Posts").addDocument(data: firestorePosts, completion: { error in
                                if error != nil{
                                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                                }else{
                                    self.imageView.image = UIImage(named: "select.png")
                                    self.mentText.text = ""
                                    self.tabBarController?.selectedIndex = 0 // gitmek istediğimiz sayfa
                                    
                                }
                            })
                        }
                    }
                }
            }
        }
    }
    
    
}






