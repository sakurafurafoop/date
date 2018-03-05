//
//  togoViewController.swift
//  date
//
//  Created by SAKU on 2018/02/26.
//  Copyright © 2018年 SAKU. All rights reserved.
//

import UIKit

class togoViewController: UIViewController{
    var userdefaults: UserDefaults = UserDefaults.standard//ユーザーデフォルトにアクセス
    @IBOutlet var togoTextField: UITextField!//togoを入れるTextField
    @IBOutlet var whenTextField: UITextField!//whenを入れるTextField
    var togoSaveArray:[String?] = []//todoを表示させる配列
    var whenSaveArray:[String] = []//whenを表示させる配列
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if userdefaults.object(forKey: "togoTitle") != nil{
            togoSaveArray = userdefaults.object(forKey:"togoTitle") as! [String]
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
        togoSaveArray.append(togoTextField.text!)
        userdefaults.set(togoSaveArray, forKey: "togoTitle")//
        whenSaveArray.append(whenTextField.text!)
        userdefaults.set(whenSaveArray, forKey: "whenTitle")
        self.navigationController?.popViewController(animated: true)
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
