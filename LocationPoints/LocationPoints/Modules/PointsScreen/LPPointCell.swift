//
//  LPPointCell.swift
//  LocationPoints
//
//  Created by Artem Kedrov on 20.11.2019.
//  Copyright © 2019 Artem Kedrov. All rights reserved.
//

import UIKit

protocol LPPointCellDelegate: class {
    func didLongPressed(sender: LPPointCell)
}

class LPPointCell: UITableViewCell {

    weak var delegate: LPPointCellDelegate?
    @IBOutlet private weak var lblName: UILabel!
    
    @IBOutlet weak var lblLatitude: UILabel!
    @IBOutlet private weak var lblLongitude: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(longPressAction(_:))))
    }

    private var privatePoint: LPPoint? {
        didSet {
            guard let point = privatePoint else { return }
            lblName.text = point.name
            lblLongitude.text = "Longitude: \(point.longitude ?? 0.0)"
            lblLatitude.text = "Latitude: \(point.latitude ?? 0.0)"
        }
    }
    var model: LPPoint? {
        get { privatePoint }
        set { privatePoint = newValue }
    }
    @IBAction func longPressAction(_ sender: UILongPressGestureRecognizer) {
        guard sender.state == .began else { return }
        delegate?.didLongPressed(sender: self)
    }
}
