//
//  OrderListTableViewController.swift
//  Drink
//
//  Created by sourceinn on 2018/5/15.
//  Copyright © 2018年 sourceinn. All rights reserved.
//

import UIKit

class OrderListTableViewController: UITableViewController {


    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    @IBOutlet weak var addBtn: UIBarButtonItem!
    @IBAction func addBtnClick(_ sender: Any) {
        if let controller = storyboard?.instantiateViewController(withIdentifier:"editView") as? EditViewController{
            controller.drinkList = drinks
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    var orders:[OrderEntity] = []
    var drinks:[DrinkEntity] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkHelper.shared.fetchDrinks { (drinks:[DrinkEntity]?) in
            if let drinks = drinks{
                self.drinks = drinks
            }
        }
    }

    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        orders.removeAll()
        tableView.reloadData()
        loadingView.isHidden = false
        NetworkHelper.shared.fetchOrders { (orders:[OrderEntity]?) in
            if let orders = orders{
                self.orders = orders
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.loadingView.isHidden = true
                }
                
            }
        }
        
        addBtn.isEnabled = false
        addBtn.isEnabled = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return orders.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "testCell", for: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath) as! OrderCell
        //print(orders[indexPath.row].name)
        cell.name.text = orders[indexPath.row].name
        cell.drinkName.text = orders[indexPath.row].drinkName
        cell.ice.text = "溫度："+orders[indexPath.row].ice
        cell.sugar.text = "甜度："+orders[indexPath.row].sugar
        cell.price.text = "$"+orders[indexPath.row].price
        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let controller = storyboard?.instantiateViewController(withIdentifier:"editView") as? EditViewController{
            controller.drinkList = drinks
            controller.order = orders[indexPath.row]
            navigationController?.pushViewController(controller, animated: true)
        }
    }


}
