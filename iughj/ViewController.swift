//
//  ViewController.swift
//  iughj
//
//  Created by wsr2 on 27.10.2021.
//

import UIKit

class ViewController: UIViewController {

    let idCell = "tableCell"
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "TableViewItem", bundle: nil), forCellReuseIdentifier: idCell)
    }
    
    @IBOutlet weak var hideView: UIView!
    @IBOutlet weak var label1Hide: UILabel!
    @IBOutlet weak var label2Hide: UILabel!
    
    @IBAction func Hide(_ sender: UIButton) {
        hideView.isHidden = true
        label1Hide.isHidden = true
        label2Hide.isHidden = true
    }
    

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: idCell) as! TableViewItem

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Вчера"
        }
        else {
             return "Май 2022 года"
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 104
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "Info")
        if indexPath.row == 0 {
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
}
