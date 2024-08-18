//
//  Ext-Image.swift
//  Sport News
//
//  Created by Abdusalom on 20/07/2024.
//

import UIKit

extension UIImage {
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size

        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height

        // Определяем коэффициент масштабирования, чтобы сохранить пропорции
        let newSize = CGSize(width: size.width * min(widthRatio, heightRatio),
                             height: size.height * min(widthRatio, heightRatio))

        // Создаем новый CGRect с новым размером
        let rect = CGRect(origin: .zero, size: newSize)

        // Рисуем изображение в новом размере
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}


extension Date {
    func timeAgoDisplay() -> String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.year, .month, .weekOfMonth, .day, .hour, .minute, .second]
        formatter.maximumUnitCount = 1
        
        let now = Date()
        let timeInterval = now.timeIntervalSince(self)
        return formatter.string(from: timeInterval) ?? "just now"
    }
}









