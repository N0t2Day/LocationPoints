//
//  InfoWindow.swift
//  LocationPoints
//
//  Created by Artem Kedrov on 20.11.2019.
//  Copyright © 2019 Artem Kedrov. All rights reserved.
//

import UIKit
protocol InfoObject {
    var title: String { get }
    var subTitle: String? { get }
    var detailText: String? { get }
}
class InfoWindow: UIView {

    @IBOutlet private weak var lblTitle: UILabel!
    @IBOutlet private weak var lblSubTitle: UILabel!
    @IBOutlet private weak var lblDetailText: UILabel!
    
    func updateWith(with model: InfoObject) {
        lblTitle.text = model.title
        lblSubTitle.text = model.subTitle
        lblDetailText.text = model.detailText
    }
//    override func didMoveToSuperview() {
//        superview?.autoresizesSubviews = false;
//    }
}
