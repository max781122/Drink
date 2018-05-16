//
//  EditViewController.swift
//  Drink
//
//  Created by sourceinn on 2018/5/15.
//  Copyright © 2018年 sourceinn. All rights reserved.
//

import UIKit

class EditViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    let iceArr:[String] = ["正常", "少冰", "去冰", "熱"]
    let sugarArr:[String] = ["正常", "半糖", "微糖", "無糖"]
    var order:OrderEntity? = nil
    var drinkList:[DrinkEntity] = []
    var oldName:String? = nil
    @IBOutlet weak var sendBtnClick: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var sugar: UISegmentedControl!
    @IBOutlet weak var ice: UISegmentedControl!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var drinkName: UITextField!

    @IBAction func deleteBtnClick(_ sender: Any) {

        NetworkHelper.shared.delete(column: "name", value: oldName!) { (resp:[String:Any]?) in
            DispatchQueue.main.async {
                self.showAlert(msg: "刪除成功", dismissFlag: true)
            }
        }
    }
    
    @IBAction func sendBtnClick(_ sender: Any) {
        guard (name.text?.isEmpty)!==false else {
            showAlert(msg: "請填寫姓名", dismissFlag: false)
            return
        }

        var priceTxt:String? = nil
        for val in drinkList{
            if val.name == drinkName.text {
                priceTxt = val.price
                break
            }
        }
        
        let data = OrderEntity(name: name.text!,drinkName: drinkName.text!,ice: iceArr[ice.selectedSegmentIndex],sugar: sugarArr[sugar.selectedSegmentIndex],price: priceTxt!)
        if let order = order {//update
            NetworkHelper.shared.update(name: oldName!, data: data) { (pic:[String:Any]?) in
                DispatchQueue.main.async {
                    self.showAlert(msg: "修改成功", dismissFlag: true)
                }
            }
        }else{//create
            NetworkHelper.shared.create(data: data) { (pic:[String:Any]?) in
                DispatchQueue.main.async {
                    self.showAlert(msg: "新增成功", dismissFlag: true)
                }
                
            }
        }
    }
    
    func showAlert(msg:String, dismissFlag:Bool){
        let alert = UIAlertController(title: "訊息", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
            if dismissFlag {
                self.navigationController?.popViewController(animated: true)
            }
        }))
        self.present(alert, animated: true)
    }
    
    
   
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return drinkList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return drinkList[row].name+" $"+drinkList[row].price
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        drinkName.text = drinkList[row].name
        if drinkList[row].name.contains("無糖限定") {
            sugar.selectedSegmentIndex = 3
            sugar.setEnabled(false, forSegmentAt: 0)
            sugar.setEnabled(false, forSegmentAt: 1)
            sugar.setEnabled(false, forSegmentAt: 2)
        }else{
            sugar.setEnabled(true, forSegmentAt: 0)
            sugar.setEnabled(true, forSegmentAt: 1)
            sugar.setEnabled(true, forSegmentAt: 2)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myPickerView = UIPickerView()
        myPickerView.delegate = self
        myPickerView.dataSource = self
        drinkName.inputView = myPickerView
        drinkName.text = drinkList[0].name
        if let data = order {
            oldName = String(data.name)
            deleteBtn.isHidden = false
            sendBtn.setTitle("修改", for: .normal)
            name.text = data.name
            drinkName.text = data.drinkName
            
            var index:Int = 0
            for val in iceArr {
                if(val==data.ice){
                    ice.selectedSegmentIndex = index
                    break
                }
                index = index + 1
            }
            index = 0
            for val in sugarArr {
                if(val==data.sugar){
                    sugar.selectedSegmentIndex = index
                    break
                }
                index = index + 1
            }
            
        }else{
            deleteBtn.isHidden = true
            
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
