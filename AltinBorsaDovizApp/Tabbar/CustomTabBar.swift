//
//  CustomTabBar.swift
//  AltinBorsaDovizApp
//
//  Created by Metehan Karadeniz on 8.06.2023.
//

import UIKit

class CustomTabBar: UITabBar {
    
    override public func sizeThatFits(_ size: CGSize) -> CGSize {
        super.sizeThatFits(size)
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = 80
        return sizeThatFits
    }
    override func layoutSubviews() {
           super.layoutSubviews()
        // tabBarItem'ları yukarı itmek için
           let itemWidth = frame.width / CGFloat(items?.count ?? 1)
           var itemIndex: CGFloat = 0

           for subview in subviews {
               if let tabBarButton = subview as? UIControl {
                   let newX = itemWidth * itemIndex
                   tabBarButton.frame = CGRect(x: newX, y: -20, width: itemWidth, height: frame.height)
                   itemIndex += 1
               }
           }
       }
              
}
