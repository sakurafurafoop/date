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
    var cellNumber:Int!//どこのセルを編集しているのか
    var isInfoEditing:Bool!//今のメモは編集中なのか新規なのか

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if userdefaults.object(forKey: "togoTitle") == nil{
            print("nakaminaiyo")
        }else{
            togoSaveArray = userdefaults.object(forKey:"togoTitle") as! [String]
            togoTextField.text = userdefaults.object(forKey: "togoTitle") as? String
        }
        
        if userdefaults.object(forKey: "whenTitle") == nil{
            print("nakaminaiyo")
        }else{
            whenSaveArray = userdefaults.object(forKey:"whenTitle") as! [String]
            whenTextField.text = userdefaults.object(forKey: "whenTitle") as? String
        }
        
        togoTextField.delegate = self
        if isInfoEditing == true{
            print(togoSaveArray[cellNumber])
            togoTextField.text = togoSaveArray[cellNumber]
        }
        whenTextField.delegate = self
       
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
    
    
    
    //保存ボタンを押した時
    @IBAction func saveTogo(){
        //新規だったら？配列に要素追加する
        if isInfoEditing == false{
            togoSaveArray.append(togoTextField.text!)
            userdefaults.set(togoSaveArray, forKey: "togoTitle")//
            whenSaveArray.append(whenTextField.text!)
            userdefaults.set(whenSaveArray, forKey: "whenTitle")
            self.dismiss(animated: true, completion: nil)
        //編集やったら？配列の要素を書き換える
        }else{
            togoSaveArray[cellNumber] = togoTextField.text!
            userdefaults.set(togoSaveArray, forKey: "togoTitle")
            isInfoEditing = false//編集か新規かを初期化する処理を入れる
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
