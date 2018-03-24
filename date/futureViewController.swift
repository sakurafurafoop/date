//
//  futureViewController.swift
//  date
//
//  Created by SAKU on 2018/02/26.
//  Copyright © 2018年 SAKU. All rights reserved.
//

import UIKit

class futureViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate{
    @IBOutlet var table: UITableView!//togoを表示させる配列
    var togoArray: [String] = []//togoを実際に入れる配列
    var whenArray: [String] = []//whenを保存に入れる配列
    var cellNumber:Int!//何こめのセルをタッチしているのか
    var isInfoEditing:Bool = false//新規or編集か判断
    let Userdefaults: UserDefaults = UserDefaults.standard//ユーザーデフォルトにアクセス
    
    //編集の場合、すでに入っている要素の中身をこっちの配列に入れる
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
        if Userdefaults.object(forKey: "togoTitle") != nil{
            togoArray = Userdefaults.object(forKey: "togoTitle") as! [String]//togoArrayにuserdefaultsに入っている配列を代入する
        }
        
        if Userdefaults.object(forKey: "whenTitle") != nil{
             whenArray = Userdefaults.object(forKey: "whenTitle") as! [String]//whenArrayにuserdefaultsに入っている配列を代入する
        }
        table.reloadData()
        
        //もしuserdefaultsが空っぽである場合
//        if  userdefaults.object(forKey: "togoTitle") != nil{
//            //togoArray = saveTogoTitle.object(forKey: "todoTitle") as! [String]
//        }
       
        self.view.addSubview(table)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isInfoEditing = false
        table.dataSource = self
        table.delegate = self
        if Userdefaults.object(forKey: "togoTitle") != nil{
            togoArray = Userdefaults.object(forKey: "togoTitle") as! [String]
        }
        if Userdefaults.object(forKey: "whenTitle") != nil{
            whenArray = Userdefaults.object(forKey: "whenTitle") as! [String]
        }
        table.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //tableViewのcellの数を決める
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return togoArray.count//配列の要素の数がセルの数になる
    }
    
    //cellに配列の要素を表示させるメソッド
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",for:indexPath)
        _ = togoArray[indexPath.row]
        cell.textLabel?.text = togoArray[indexPath.row]
        return cell
    }
    
    
    //削除する
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            togoArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        Userdefaults.set(togoArray, forKey: "togoTitle")//
    }
    
    
    //セルがタップされた時
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        cellNumber = indexPath.row
        isInfoEditing = true
        self.performSegue(withIdentifier: "toTogoViewController", sender: (Any).self)
        table.deselectRow(at:indexPath, animated: true)
    }
    
    //int型のcellNumberとbool型のisInfoEditingをtogoViewControllerに送る
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let Togoviewcontroller:togoViewController = segue.destination as! togoViewController
        Togoviewcontroller.cellNumber = cellNumber
        Togoviewcontroller.isInfoEditing = isInfoEditing
    }
        
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            return true
        }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    

}
