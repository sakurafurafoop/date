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
    var mozi:String!
    var hensyuu: String!
    let userdefaults: UserDefaults = UserDefaults.standard//ユーザーデフォルトにアクセス
    
    //var mozi:String = "hamu"
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
        if userdefaults.object(forKey: "togoTitle") != nil{
            togoArray = userdefaults.object(forKey: "togoTitle") as! [String]//togoArrayにuserdefaultsに入っている配列を代入する
        }
        
        if userdefaults.object(forKey: "whenTitle") != nil{
             whenArray = userdefaults.object(forKey: "whenTitle") as! [String]//whenArrayにuserdefaultsに入っている配列を代入する
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
        
        table.dataSource = self
        table.delegate = self
        if userdefaults.object(forKey: "togoTitle") != nil{
            togoArray = userdefaults.object(forKey: "togoTitle") as! [String]
            //var togo = togoArray as! String
            
            
        }
        if userdefaults.object(forKey: "whenTitle") != nil{
            whenArray = userdefaults.object(forKey: "whenTitle") as! [String]
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
        userdefaults.set(togoArray, forKey: "togoTitle")//
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        mozi = togoArray[indexPath.row]
        self.performSegue(withIdentifier: "toTogoViewController", sender: self.mozi)
        
        table.deselectRow(at:indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        _ = segue.destination as! togoViewController
        togoViewController.hensyuu = sender as? String
            //togoViewController.togo = sender as String
        
        
        func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
            return true
        }
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
