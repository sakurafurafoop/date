//
//  togoViewController.swift
//  date
//
//  Created by SAKU on 2018/02/26.
//  Copyright © 2018年 SAKU. All rights reserved.
//

import UIKit

class togoViewController: UIViewController,UIImagePickerControllerDelegate,UITextFieldDelegate,UINavigationControllerDelegate{
    var userdefaults: UserDefaults = UserDefaults.standard//ユーザーデフォルトにアクセス
    @IBOutlet var togoTextField: UITextField!//togoを入れるTextField
    //@IBOutlet var togoText: UILabel!//
    @IBOutlet var whenTextField: UITextField!//whenを入れるTextField
    @IBOutlet var imageView:UIImageView!
    var togoSaveArray:[String] = []//todoを表示させる配列
    var whenSaveArray:[String] = []//whenを表示させる配列
    var hensyuu: String!
    //var togoData = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if userdefaults.object(forKey: "togoTitle") == nil{
            //return
        }else{
            togoSaveArray = userdefaults.object(forKey:"togoTitle") as! [String]
        }
        
        togoTextField.delegate = self
        togoTextField.text = userdefaults.object(forKey: "togoTitle") as? String
        
        if hensyuu != nil{
            togoTextField.text = hensyuu
        }
        
        if userdefaults.object(forKey: "whenTitle") != nil{
            whenSaveArray = userdefaults.object(forKey: "whenTitle") as! [String]
            
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveTogo(){
        if hensyuu == nil{
            togoSaveArray.append(togoTextField.text!)
            userdefaults.set(togoSaveArray, forKey: "togoTitle")//
            whenSaveArray.append(whenTextField.text!)
            userdefaults.set(whenSaveArray, forKey: "whenTitle")
        }else if hensyuu != nil{
            let index = togoSaveArray.index(of: hensyuu)
            togoSaveArray.remove(at: index!)
            togoSaveArray.insert(togoTextField.text!, at: index!)
            userdefaults.set(togoSaveArray, forKey: "togoTitle")
            
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func openAlbum(){
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = self
            picker.allowsEditing = true
            present(picker, animated: true,completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imageView.image = info[UIImagePickerControllerEditedImage] as? UIImage
        
        dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
