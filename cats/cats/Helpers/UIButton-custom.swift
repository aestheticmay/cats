//
//  UIButton-custom.swift
//  cats
//
//  Created by Майя Калицева on 22.10.2022.
//

import UIKit

extension UIButton
{
    func configureWithLeftImage(_ imageName: String)
    {
        // Retrieve the desired image and set it as the button's image
        let buttonImage = UIImage(systemName: imageName)?.withRenderingMode(.alwaysOriginal)
        
        // Resize the image to the appropriate size if required
        let resizedButtonImage = resizeImage(buttonImage)
        
        setImage(resizedButtonImage, for: .normal)
        
        // Set the content mode
        contentMode = .scaleAspectFit
        
        // Align the content inside the UIButton to be left so that
        // image can be left and the text can be besides that on it's right
        contentHorizontalAlignment = .left
        
        // Set or compute the width of the UIImageView within the UIButton
        let imageWidth: CGFloat = imageView!.frame.width
        
        // Specify the padding you want between UIButton and the text
        let contentPadding: CGFloat = 10.0
        
        // Get the width required for your text in the button
        let titleFrame = titleLabel!.intrinsicContentSize.width
        
        // Keep a hold of the button width to make calculations easier
        let buttonWidth = frame.width
        
        // The UIImage and the Text combined should be centered so we need to calculate
        // the x position of the image first.
        let imageXPos = (buttonWidth - (imageWidth + contentPadding + titleFrame)) / 2
        
        // Adjust the content to be centered
        contentEdgeInsets = UIEdgeInsets(top: 0.0,
                                         left: imageXPos,
                                         bottom: 0.0,
                                         right: 0.0)
    }
    
    // Make sure the image is sized properly, I have just given 50 x 50 as random
    // Code taken from: https://www.createwithswift.com/uiimage-resize-resizing-an-uiimage/
    private func resizeImage(_ image: UIImage?,
                                   toSize size: CGSize = CGSize(width: 50, height: 50)) -> UIImage?
    {
        if let image = image
        {
            UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
            image.draw(in: CGRect(origin: CGPoint.zero, size: size))
            
            let resizedImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            return resizedImage
        }
        
        return nil
    }
}

extension UIImageView {
    
    func loadImage(url: URL?) {
        guard let path = url else {
            return
        }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: path),
                  let image = UIImage(data: imageData) else {
                return
            }
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
}
