//
//  CartViewController.swift
//  shoppingApp
//
//  Created by 杜襄 on 2021/11/15.
//

import UIKit

class Cart1ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cartStepView: CartStepView!
    

    @IBOutlet weak var nextStepButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        cartStepView.stepBars[0].backgroundColor = UIColor.red
        cartStepView.stepLabels[0].textColor = UIColor.red
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "Cart1TableViewCell", bundle: nil), forCellReuseIdentifier: "Cart1TableViewCell")
        nextStepButton.layer.cornerRadius = 5
        nextStepButton.clipsToBounds = true

    }
    @IBAction func nextStepPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "toStep2", sender: nil)
    }
}

extension Cart1ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cart1TableViewCell")!
        return cell
    }
    
    
}

extension Cart1ViewController: UITableViewDelegate{
    
}
