//
//  futureViewController.swift
//  date
//
//  Created by SAKU on 2018/02/26.
//  Copyright © 2018年 SAKU. All rights reserved.
//

import UIKit

class futureViewController: togoViewController, UITableViewDataSource,UITableViewDelegate{
    //tableViewのcellの数を決める
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return togoArray.count//配列の要素の数がセルの数になる
    }
    
    //cellに配列の要素を表示させるメソッド
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = togoArray[indexPath.row]
        return cell!
    }
    @IBOutlet var table:UITableView!//togoを表示させるtableview
    var togoArray:[String] = []//togoを実際に入れる配列
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        togoArray = userdefaults.object(forKey: "togoTitle") as! [String]//togoArrayにuserdefaultsに入っている配列を代入する
        table.reloadData()
        if  userdefaults.object(forKey: "togoTitle") != nil{
            //togoArray = saveTodoTitle.object(forKey: "todoTitle") as! [String]
        }
        table.delegate = self
        table.dataSource = self
        self.view.addSubview(table)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //削除する
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            togoArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        userdefaults.set(togoArray, forKey: "togoTitle")//
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
