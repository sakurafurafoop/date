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
    var togoSaveArray:[String] = []// todoを表示させる配列
    var whenSaveArray:[String] = []//whenを表示させる配列
    var hensyuu: String!
    var hensyuuwhen: String!
    var cellNumber:Int!
    var isInfoEditing:Bool!
    //var togoData = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(cellNumber)
        print(isInfoEditing)
        if userdefaults.object(forKey: "togoTitle") == nil{
            print("nakaminaiyo")
        }else{
            print(hensyuu)
            togoSaveArray = userdefaults.object(forKey:"togoTitle") as! [String]
            togoTextField.text = userdefaults.object(forKey: "togoTitle") as? String
        }
        if userdefaults.object(forKey: "whenTitle") == nil{
            print("nakaminaiyo")
        }else{
            print(hensyuu)
            whenSaveArray = userdefaults.object(forKey:"whenTitle") as! [String]
            whenTextField.text = userdefaults.object(forKey: "whenTitle") as? String
        }
        
        togoTextField.delegate = self
        if isInfoEditing == true{
            togoTextField.text = togoSaveArray[cellNumber]
        }
        whenTextField.delegate = self
//        whenTextField.text = hensyuuwhen
        
//        if hensyuu != nil{
//            print("hensyuu")
//            togoTextField.text = togoSaveArray[cellNumber]
//        }
//        if hensyuuwhen != nil{
//            print("hensyuu")
//            whenTextField.text = hensyuuwhen
//        }
        if cellNumber == nil{
            
        }
        if isInfoEditing == true{
            togoTextField.text = togoSaveArray[cellNumber]
        }
        
       /* if userdefaults.object(forKey: "whenTitle") != nil{
            whenSaveArray = userdefaults.object(forKey: "whenTitle") as! [String]
            whenTextField.text = userdefaults.object(forKey: "whenTitle") as? String
        }*/
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveTogo(){
        if isInfoEditing == false{
            print("保存します")
            togoSaveArray.append(togoTextField.text!)
            userdefaults.set(togoSaveArray, forKey: "togoTitle")//
            whenSaveArray.append(whenTextField.text!)
            userdefaults.set(whenSaveArray, forKey: "whenTitle")
            self.dismiss(animated: true, completion: nil)
        }else{
            //print(hensyuu)
//            let index = togoSaveArray.index(of: hensyuu)
            //配列の要素の中身をtextFieldの中身に代入する
            togoSaveArray[cellNumber] = togoTextField.text!
            userdefaults.set(togoSaveArray, forKey: "togoTitle")
            
            //let whenindex = whenSaveArray.index(of:hensyuuwhen)
            //whenSaveArray.remove(at: (whenindex)!)
            //whenSaveArray.insert(whenTextField.text!, at: index!)
            //userdefaults.set(whenSaveArray, forKey: "whenTitle")
            
            isInfoEditing = false//編集の内容を初期化する処理を入れる
//            self.dismiss(animated: true, completion: nil)
            self.navigationController?.popViewController(animated: true)
        }
        
       
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
