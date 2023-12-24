import SwiftUI
import UIKit
import Foundation

class Localizations {
    static var bundle: Bundle? {
        if let path = Bundle.main.path(forResource: "en", ofType: "lproj") {
            return Bundle(path: path)
        }
        return nil
    }

    static func localizedString(_ key: String) -> String {
        return bundle?.localizedString(forKey: key, value: nil, table: nil) ?? ""
    }
}

extension UIImage {
    func resized(to size: CGSize) -> UIImage? {
        UIGraphicsImageRenderer(size: size).image { rendererContext in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
    
    func withRoundedCorners(radius: CGFloat) -> UIImage? {
        UIGraphicsImageRenderer(size: size).image { context in
            let rect = CGRect(origin: .zero, size: size)
            UIBezierPath(roundedRect: rect, cornerRadius: radius).addClip()
            draw(in: rect)
        }
    }
    
    func withRoundedCornersResized(to size: CGSize, radius: CGFloat) -> UIImage? {
        resized(to: size)?.withRoundedCorners(radius: radius)
    }
}

@objc class AlertPresenter: NSObject {
    @objc func presentAlert() {
        DispatchQueue.main.async {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let topController = windowScene.windows.first?.rootViewController {
                
                let alertController = UIAlertController(title: Localizations.localizedString("Premium.AppIcons.Proceed"), message: Localizations.localizedString("Premium.AppIconInfo"), preferredStyle: .alert)
                
                if let turboImage = UIImage(named: "Premium/Icons/Premium"),
                   let resizedImage1 = turboImage.resized(to: CGSize(width: 40, height: 40)),
                   let turboImage2 = UIImage(named: "Premium/Icons/Turbo"),
                   let resizedImage2 = turboImage2.resized(to: CGSize(width: 40, height: 40)),
                   let turboImage3 = UIImage(named: "Premium/Icons/Black"),
                   let resizedImage3 = turboImage3.resized(to: CGSize(width: 40, height: 40)) {
                    
                    let cornerRadius: CGFloat = 8.0
                    if let imageWithRadius1 = resizedImage1.withRoundedCornersResized(to: CGSize(width: 40, height: 40), radius: cornerRadius),
                       let imageWithRadius2 = resizedImage2.withRoundedCornersResized(to: CGSize(width: 40, height: 40), radius: cornerRadius),
                       let imageWithRadius3 = resizedImage3.withRoundedCornersResized(to: CGSize(width: 40, height: 40), radius: cornerRadius) {
                        
                        let action1 = UIAlertAction(title: Localizations.localizedString("Appearance.AppIconPremium"), style: .default) { _ in
                            self.changeAppIcon(iconName: "Premium")
                        }
                        action1.setValue(imageWithRadius1.withRenderingMode(.alwaysOriginal), forKey: "image")
                        alertController.addAction(action1)
                        
                        let action2 = UIAlertAction(title: Localizations.localizedString("Appearance.AppIconTurbo"), style: .default) { _ in
                            self.changeAppIcon(iconName: "PremiumTurbo")
                        }
                        action2.setValue(imageWithRadius2.withRenderingMode(.alwaysOriginal), forKey: "image")
                        alertController.addAction(action2)
                        
                        let action3 = UIAlertAction(title: Localizations.localizedString("Appearance.AppIconBlack"), style: .default) { _ in
                            self.changeAppIcon(iconName: "PremiumBlack")
                        }
                        action3.setValue(imageWithRadius3.withRenderingMode(.alwaysOriginal), forKey: "image")
                        alertController.addAction(action3)
                    }
                }
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                alertController.addAction(cancelAction)
                
                topController.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    func changeAppIcon(iconName: String) {
        DispatchQueue.main.async {
            UIApplication.shared.setAlternateIconName(iconName) { _ in
                self.presentAlert() //return alert
            }
        }
    }
}
