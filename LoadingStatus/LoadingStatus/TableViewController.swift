//
//  TableViewController.swift
//  LoadingStatus
//
//  Created by zhi zhou on 2017/2/3.
//  Copyright © 2017年 zhi zhou. All rights reserved.
//

import UIKit

private let cellIdentifier = "loadingCell"

class TableViewController: UITableViewController {
    // MARK:- 系统函数
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "模仿 Facebook 加载状态 Cell"
        tableView.backgroundColor = UIColor.groupTableViewBackground
        
        /** 
         1. 去掉分割线
         2. 禁止 loadingCell 可以滚动, 防止滚动造成动画执行不统一.
         3. 禁止 cell 点击, 防止点击 cell 造成动画执行不统一.
         */
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.allowsSelection = false
        
        tableView.register(LoadingCell.self, forCellReuseIdentifier: cellIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - TableView 数据源、代理方法
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = LoadingCell(style: .default, reuseIdentifier: cellIdentifier)
        
        return cell
    }

}
