//
//  UIImage.swift
//  Collection_test
//
//  Created by 川北 紘正 on 2019/06/18.
//  Copyright © 2019 川北 紘正. All rights reserved.
//

import UIKit

extension UIImage {
    public convenience init(url: String) {
        let url = URL(string: url)
        do {
            let data = try Data(contentsOf: url!)
            self.init(data: data)!
            return
        } catch let err {
            print("Error : \(err.localizedDescription)")
        }
        self.init()
    }
}

extension UIImage {
    func rgb2GrayScale() -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        guard let context = CGContext(data: nil,
                                      width: Int(size.width),
                                      height: Int(size.height),
                                      bitsPerComponent: 8,
                                      bytesPerRow: 0,
                                      space: CGColorSpaceCreateDeviceGray(),
                                      bitmapInfo: CGImageAlphaInfo.none.rawValue),
            let cgImage = cgImage
            else {
                return nil
        }
        
        context.draw(cgImage, in: rect)
        
        guard let image = context.makeImage() else {
            return nil
        }
        
        return UIImage(cgImage: image)
    }
}
