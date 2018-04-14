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
    var togoSaveArray:[String?] = []// todoを表示させる配列
    var whenSaveArray:[String?] = []//whenを表示させる配列
    var cellNumber:Int!//どこのセルを編集しているのか
    var isInfoEditing:Bool!//今のメモは編集中なのか新規なのか
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("isInfoEditing:",  isInfoEditing)
        if userdefaults.object(forKey: "togoTitle") != nil{
            togoSaveArray = userdefaults.object(forKey:"togoTitle") as! [String]
            togoTextField.text = userdefaults.object(forKey: "togoTitle") as? String
        }
        
        if userdefaults.object(forKey: "whenTitle") != nil{
            whenSaveArray = userdefaults.object(forKey:"whenTitle") as! [String]
            whenTextField.text = userdefaults.object(forKey: "whenTitle") as? String
        }
        togoTextField.delegate = self
        whenTextField.delegate = self
        //編集の場合元の内容をテキストボックスに表示させる
        if isInfoEditing == true{
            if userdefaults.object(forKey: "togoTitle") != nil{
                togoTextField.text = togoSaveArray[cellNumber]
            }
            
            if userdefaults.object(forKey: "whenTitle") != nil{
                whenTextField.text = whenSaveArray[cellNumber]
            }
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //キーボードたたむ
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //保存ボタンを押した時
    @IBAction func saveTogo(){
        //もしtogoTextFieldの中身があるんやったら保存する
        if togoTextField.text != ""{
            //新規だったら？配列に要素追加する
            if isInfoEditing == false{
                togoSaveArray.append(togoTextField.text!)
                userdefaults.set(togoSaveArray, forKey: "togoTitle")
                whenSaveArray.append(whenTextField.text!)
                userdefaults.set(whenSaveArray, forKey: "whenTitle")
//                self.dismiss(animated: true, completion: nil)
                self.navigationController?.popViewController(animated: true)
            //編集やったら？配列の要素を書き換える
            }else{
                togoSaveArray[cellNumber] = togoTextField.text!
                userdefaults.set(togoSaveArray, forKey: "togoTitle")
                whenSaveArray[cellNumber] = whenTextField.text!
                userdefaults.set(whenSaveArray, forKey: "whenTitle")
                isInfoEditing = false//編集か新規かを初期化する処理を入れる
                self.dismiss(animated: true, completion: nil)
            }
        //もしtogoTextFieldの中身がないんやったらalertを出す
        }else{
            let alert:UIAlertController = UIAlertController(title:"どこに行きますか？",message:"中身を書いてください",preferredStyle:.alert)
            alert.addAction(
                UIAlertAction(
                    title:"OK",
                    style:.default
                )
            )
            present(alert,animated: true,completion: nil)
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
