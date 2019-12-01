//
//  PointsScreenView.swift
//  LocationPoints
//
//  Created by Artem Kedrov on 18.11.2019.
//  Copyright © 2019 Artem Kedrov. All rights reserved.
//

import UIKit

class PointsScreenView: UITableViewController {

    var presenter: PointsScreenPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension;
        tableView.estimatedRowHeight = 40.0
        tableView.register(cell: LPPointCell.self)
        PointsScreenConfigurator().configure(self)
        presenter?.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return presenter?.numberOfSections() ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRows(in: section) ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(ofType: LPPointCell.self, for: indexPath)
        presenter?.configure(cell: cell, at: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectRowAt(indexPath)
    }
}

extension PointsScreenView: BaseView {
    func reload() {
        tableView.reloadData()
    }
}
