//
//  DetalViewController.swift
//  个人通讯录
//
//  Created by MrHuang on 17/7/2.
//  Copyright © 2017年 Mrhuang. All rights reserved.
//

import UIKit

class DetalViewController: UITableViewController {
    
    @IBOutlet weak var nameTF: UITextField!
    
    @IBOutlet weak var numberTF: UITextField!
    
    
    @IBOutlet weak var titleTF: UITextField!
    
    
    var person : PersonModel?
    
    //定义一个闭包属性 是可选的闭包
    
    var complectionCallBack:(() -> ())?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if person != nil {
            
            nameTF.text = person?.name
            numberTF.text = person?.numaber
            titleTF.text = person?.title
            
            
            
        }
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

  

    
    @IBAction func SavePerson(_ sender: Any) {
        
        
        //1.判断person 是否为nil 
        
        if person == nil{
            //如果为nil 则创建初始化实例对象
            person = PersonModel()
        
        }
        
        //2.更新UI数据
        person?.name = nameTF.text
        person?.numaber = numberTF.text
        person?.title = titleTF.text
        
        
        //3.执行闭包回调
        complectionCallBack?()
        
        
        //4.返回上一级界面
        // 因为popViewController 的返回值是UIViewController 然后我们用不上，所以可以用_代替 _可以忽略一切不关心的内容
        _ = navigationController?.popViewController(animated: true)
        
    }
    
    
}
