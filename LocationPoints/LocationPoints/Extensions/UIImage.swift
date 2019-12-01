//
//  UIImage.swift
//  LocationPoints
//
//  Created by Artem Kedrov on 21.11.2019.
//  Copyright © 2019 Artem Kedrov. All rights reserved.
//

import GoogleMaps

extension GMSMarker {
    func drawFont(text: NSString) {
        guard let icon = icon else { return }
        UIGraphicsBeginImageContextWithOptions(icon.size, false, UIScreen.main.scale)
        icon.draw(in: .init(origin: .zero, size: icon.size))
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        let attr = [
            NSAttributedString.Key.paragraphStyle: style,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17.0),
            NSAttributedString.Key.foregroundColor : UIColor.red
        ]
        let paddingTop: CGFloat = 8.0
        let rect: CGRect = .init(origin: .init(x: 0, y: paddingTop), size: icon.size)
        text.draw(in: rect, withAttributes: attr)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.icon = newImage
    }
}
