//
//  MainTabBarController.swift
//  GPACalculator
//
//  Created by Mekhriddin Jumaev.
//

import UIKit

let grayColor: UIColor = UIColor.init(hex: "BBBBBB")
let blueColor: UIColor = UIColor.init(hex: "38BCF4")

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    let imageV = UIImageView(image: UIImage.init(named: "home"))
    let profileImage = UIImageView(image: UIImage.init(named: "chat"))
    let basketImage = UIImageView(image: UIImage.init(named: "like"))


    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
        object_setClass(self.tabBar, WeiTabBar.self)
        configureTabBarAppearence()
        self.delegate = self
    }
    
    func generateTabBar() {
        tabBar.backgroundColor = .clear
        
        self.profileImage.tintColor = grayColor
        self.basketImage.tintColor = grayColor
        imageV.backgroundColor = blueColor
        imageV.layer.cornerRadius = 30
        imageV.tintColor = .white
        
        basketImage.image = basketImage.image?.withRenderingMode(.alwaysTemplate)
        profileImage.image = profileImage.image?.withRenderingMode(.alwaysTemplate)
        imageV.image = imageV.image?.withRenderingMode(.alwaysTemplate)
        
        viewControllers = [
            generateViewController(vc: UINavigationController(rootViewController: DetailsViewController()), image: UIImage(named: "Off")?.tint(with: .clear), tag: 0),
            generateViewController(vc: UINavigationController(rootViewController: MainViewController()), image: UIImage(named: "Off")?.tint(with: .clear), tag: 1),
            generateViewController(vc: UINavigationController(rootViewController: SettingsViewController()), image: UIImage(named: "Off")?.tint(with: .clear), tag: 2),
        ]
        
        
    }
    
    func generateViewController(vc: UIViewController, image: UIImage?, tag: Int) -> UIViewController {
        vc.tabBarItem.image = image
        vc.tabBarItem.tag = tag
        return vc
    }
    
    
    let shapeLayer = CAShapeLayer()
    
    private func configureTabBarAppearence() {
        let width = Int(tabBar.bounds.width)
        let height = 200
        
        let bazierPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: width, height: height), byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 25, height: 1.0)).cgPath
        shapeLayer.path = bazierPath
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        shapeLayer.shadowOpacity = 1
        shapeLayer.shadowRadius = 104
        shapeLayer.shadowOffset = CGSize(width: 0, height: -7)
        tabBar.layer.insertSublayer(shapeLayer, at: 0)
        tabBar.itemWidth = CGFloat(width / 5)
        tabBar.itemPositioning = .centered
        tabBar.backgroundColor = .clear
        
        tabBar.insertSubview(imageV, belowSubview: tabBar)
        tabBar.insertSubview(profileImage, aboveSubview: tabBar)
        tabBar.insertSubview(basketImage, aboveSubview: tabBar)
        imageV.image = imageV.image?.withRenderingMode(.alwaysTemplate)
        imageV.frame = CGRect.init(x: (tabBar.frame.width/2) - 30, y: 13 , width: 60, height: 60)
        
        profileImage.image = profileImage.image?.withRenderingMode(.alwaysTemplate)
        profileImage.frame = CGRect.init(x: tabBar.frame.width - 58 - 60, y: 13 , width: 60, height: 60)
        basketImage.image = basketImage.image?.withRenderingMode(.alwaysTemplate)
        basketImage.frame = CGRect.init(x: 58, y: 13 , width: 60, height: 60)
        
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
            
            if traitCollection.userInterfaceStyle == .dark {
                shapeLayer.fillColor = UIColor.init(hex: "363636").cgColor
            } else {
                shapeLayer.fillColor = UIColor.white.cgColor
            }

    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        basketImage.image = basketImage.image?.withRenderingMode(.alwaysTemplate)
        profileImage.image = profileImage.image?.withRenderingMode(.alwaysTemplate)
        imageV.image = imageV.image?.withRenderingMode(.alwaysTemplate)
        
        self.profileImage.tintColor = grayColor
        profileImage.backgroundColor = .clear
        self.basketImage.tintColor = grayColor
        basketImage.backgroundColor = .clear
        self.imageV.tintColor = grayColor
        imageV.backgroundColor = .clear
        
        
        switch item.tag {
        case 0:
            tagTapped(imageView: basketImage)
        case 1:
            tagTapped(imageView: imageV)
        case 2:
            tagTapped(imageView: profileImage)
        default:
            break
        }
    }
    
    func tagTapped(imageView: UIImageView) {
        let result = setState(imageView: imageView)
        let centerX = result.0
        let centerY = result.1
        imageView.image = imageView.image?.withRenderingMode(.alwaysTemplate)
        changeState(imageView: imageView, centerX: centerX, centerY: centerY)
    }
    
    func setState(imageView: UIImageView) -> (CGFloat, CGFloat){
        let centerX = imageView.frame.minX + imageView.frame.size.height / 2
        let centerY = imageView.frame.minY + imageView.frame.size.width / 2
        imageView.frame.size.height = 55
        imageView.frame.size.width = 55
        imageView.layer.cornerRadius = imageView.frame.size.height / 2
        imageView.center.x = centerX
        imageView.center.y = centerY
        return (centerX, centerY)
    }
    
    func changeState(imageView: UIImageView, centerX: CGFloat, centerY: CGFloat) {
        imageView.backgroundColor = blueColor
        imageView.tintColor = .white
        UIView.animate(withDuration: 0.3, animations: {
            imageView.frame.size.height = 60
            imageView.frame.size.width = 60
            imageView.center.x = centerX
            imageView.center.y = centerY
            imageView.layer.cornerRadius = imageView.frame.size.width / 2
        })
    }
}


class WeiTabBar: UITabBar {
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        super.sizeThatFits(size)
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = 96
        return sizeThatFits
    }
}

extension UIImage {
    func tint(with color: UIColor) -> UIImage {
        var image = withRenderingMode(.alwaysTemplate)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        color.set()

        image.draw(in: CGRect(origin: .zero, size: size))
        image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}

extension UIColor {
    class func short(red: Int, green: Int, blue: Int, alpha: Double = 1) -> UIColor {
        let r = CGFloat(red) / 255.0
        let g = CGFloat(green) / 255.0
        let b = CGFloat(blue) / 255.0
        let a = CGFloat(alpha)
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
    
    convenience init(hex hexFromString: String, alpha: CGFloat = 1.0) {
        var cString: String = hexFromString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        var rgbValue: UInt32 = 10066329 //color #999999 if string has wrong format
        
        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }
        
        if cString.count == 6 {
            Scanner(string: cString).scanHexInt32(&rgbValue)
        }
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}
