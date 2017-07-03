//
//  ListViewController.swift
//  个人通讯录
//
//  Created by MrHuang on 17/7/2.
//  Copyright © 2017年 Mrhuang. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {
    
    var personList = [PersonModel]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData { (list) in
            
           print(list)
            
           //拼接数组
            self.personList += list
           //刷新表格
           self.tableView.reloadData()
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

   
    private func loadData( completion:@escaping (_ list:[PersonModel])->()) -> () {
        
        
        DispatchQueue.global().async {
            
        
            
            Thread.sleep(forTimeInterval: 1)
            
            var arrayM = [PersonModel]()
        
            for i in 0..<20{
            
                let p = PersonModel()
                
                
                
                p.name = "张三 --- \(i)"
                p.numaber = "150" + String(format:"%06d",arc4random_uniform(1000000))
                p.title = "老大"
                
                arrayM.append(p)
                
            }
        
            //主线程回调
            DispatchQueue.main.async(execute: { 
                
                //回调执行闭包
                completion(arrayM)
                
            })
            
        }
        
        
        
    }
    
    
    @IBAction func AddPerson(_ sender: Any) {
        
        
        //执行segue
        performSegue(withIdentifier: "list2detail", sender: true)
        
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
       let vc = segue.destination as! DetalViewController
        
        if let index = sender as? IndexPath {
            
            vc.person = personList[index.row]
          //设置编辑完成的闭包
            vc.complectionCallBack = {
            
            //刷新指定行
                self.tableView.reloadRows(at: [index], with: .automatic)
            }
            
        }else {
        
            /**
             *  vc 强引用闭包 -> 闭包又强引用了vc 所以产生循环引用
                解决方法: 在闭包中 weak 修饰 vc -->[weak vc] 使得闭包中的vc是可选类型
             */
            //新建个人记录
            vc.complectionCallBack = {[weak vc] in
            
                //获取明细控制器的Person
                guard let p = vc?.person else  {
                    return
                }
                
                //将新的数据添加到顶部
                self.personList.insert(p, at: 0)
                //刷新表格
                self.tableView.reloadData()
                
            }
            
            
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        //执行segue
        performSegue(withIdentifier: "list2detail", sender: indexPath)
        
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return personList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let  cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
        
        cell.textLabel?.text = personList[indexPath.row].name
        cell.detailTextLabel?.text = personList[indexPath.row].numaber
     
        return cell
        
    }
    
}
