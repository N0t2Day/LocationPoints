//
//  UITableView.swift
//  LocationPoints
//
//  Created by Artem Kedrov on 20.11.2019.
//  Copyright © 2019 Artem Kedrov. All rights reserved.
//

import UIKit.UITableView

extension UITableView{
    func dequeueReusableCell<T: UITableViewCell>(ofType type: T.Type, for indexPath: IndexPath) -> T{
        return dequeueReusableCell(withIdentifier: T.reuseId, for: indexPath) as! T
    }
    func register<T: UITableViewCell>(cell: T.Type, bundle: Bundle? = nil){
        register(T.nib, forCellReuseIdentifier: T.reuseId)
    }
}

