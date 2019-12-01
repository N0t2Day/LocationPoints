//
//  PointsScreenPresenter.swift
//  LocationPoints
//
//  Created by Artem Kedrov on 18.11.2019.
//  Copyright © 2019 Artem Kedrov. All rights reserved.
//

import Foundation
import FirebaseDatabase
protocol PointsScreenPresenter: class {
    func viewDidLoad()
    func viewWillAppear()
    func numberOfSections() -> Int
    func numberOfRows(in section: Int) -> Int
    func configure(cell: LPPointCell, at indexPath: IndexPath)
    func didSelectRowAt(_ indexPath: IndexPath)
    
}

class PointsScreenPresenterImplementation: BasePresenter<PointsScreenView, PointsScreenRouter> {
    
    let database = AppManager.RTDB
    
    var items: Points = [] {
        didSet {
            if items.isEmpty {
                view.showError(title: "Oops", message: "Empty points list")
            } else {
                view.reload()
            }
        }
    }
    @objc func didUpdateData() {
        items = database.items.sorted()
    }
}

extension PointsScreenPresenterImplementation: PointsScreenPresenter {
    func viewDidLoad() {
        NotificationCenter.default.addObserver(self, selector: #selector(didUpdateData)
            , name: DataDidUpdateNotification, object: nil)
    }
    

    func viewWillAppear() {
        items = AppManager.RTDB.items.sorted()
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows(in section: Int) -> Int {
        return items.count
    }
    
    func configure(cell: LPPointCell, at indexPath: IndexPath) {
        guard items.count > indexPath.row else { return }
        cell.model = items[indexPath.row]
        cell.delegate = self
    }
    
    func didSelectRowAt(_ indexPath: IndexPath) {
        guard items.count > indexPath.item else { return }
        let item = items[indexPath.row]
        DataTransitionManager.shared.setSelected(marker: item)
        router.toMap()
    }
    
}


extension PointsScreenPresenterImplementation: LPPointCellDelegate {
    func didLongPressed(sender: LPPointCell) {
        sender.model?.ref?.removeValue()
    }
    
    
}
