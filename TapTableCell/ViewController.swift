//
//  ViewController.swift
//  TapTableCell
//
//  Created by ttionn on 2018/8/28.
//  Copyright © 2018 Tong Tian. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
    
        setupViews()
    }
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .white
        table.dataSource = self
        table.delegate = self
        table.register(TableCell.self, forCellReuseIdentifier: "Cell")
        return table
    }()

    func setupViews() {
        view.addSubview(tableView)
        view.addConstraints(format: "H:|[v0]|", views: tableView)
        view.addConstraints(format: "V:|[v0]|", views: tableView)
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableCell
        if indexPath.row < 10 {
            cell.topView.backgroundColor = UIColor.magenta
        } else if indexPath.row < 20 {
            cell.topView.backgroundColor = UIColor.blue
        } else {
            cell.topView.backgroundColor = UIColor.green
        }
        return cell
    }
}

class TableCell: UITableViewCell {
    
    // MARK: - Property
    
    var isTapped = false
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = .white
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        topViewLeadingConstraint.constant = selected ? -50 : 0
        if isTapped && selected {
            topViewLeadingConstraint.constant = 0
            isTapped = false
        } else {
            isTapped = selected
        }
        
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
    
    var topViewLeadingConstraint: NSLayoutConstraint!
    let topView: UIView = {
        let view = UIView()
        return view
    }()
    
    func setupViews() {
        addSubview(topView)
        addConstraints(format: "H:[v0(\(frame.width))]", views: topView)
        addConstraints(format: "V:|[v0]|", views: topView)
        
        topViewLeadingConstraint = topView.leadingAnchor.constraint(equalTo: leadingAnchor)
        topViewLeadingConstraint.isActive = true
    }
    
}
