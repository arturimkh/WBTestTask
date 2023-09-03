//
//  WBLikedButtonView.swift
//  WBTestTask
//
//  Created by Artur Imanbaev on 04.09.2023.
//

import UIKit

/// class to reuse like button
final class WBLikedButtonView: UIButton {
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        layer.borderWidth = 2.0
        layer.borderColor = UIColor.black.cgColor
        setTitleColor(.black, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Switching value of button liked or disliked
    /// - Parameter labelText: key to get values
    public func switchButton(labelText: String){
        let flag = MyUserDefaultsManager.shared.getData(forKey: labelText)
        switch flag{
        case true:
            setTitle("Не понравилось", for: .normal)
            MyUserDefaultsManager.shared.saveData(key: labelText, value: false)
        case false:
            setTitle("Понравилось", for: .normal)
            MyUserDefaultsManager.shared.saveData(key: labelText, value: true)
        }
    }
    
    /// cheking information about button, liked or disliked
    /// - Parameter labelText: key to get values
    public func checkInfoAbout(labelText:String){
        let flag = MyUserDefaultsManager.shared.getData(forKey: labelText)
        switch flag{
        case true:
            setTitle("Понравилось", for: .normal)
        case false:
            setTitle("Не понравилось", for: .normal)
        }
    }
}
