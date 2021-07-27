//
//  BaseVC.swift
//  ToDoApp
//
//  Created by Aybek Can Kaya on 27.07.2021.
//

import Foundation
import UIKit

enum ViewControllerType: String {
    case home = "HomeViewController"
    case newTask = "NewTaskViewController"
    
    var title: String {
        switch self {
            case .home: return "Tasks"
            case .newTask: return "New Task"
        }
    }
    
    var leftButtonImage: UIImage? {
        switch self {
        case .home:
            return nil
        case .newTask:
            return #imageLiteral(resourceName: "BackIcon")
        }
    }
    
    var rightButtonImage: UIImage? {
        switch self {
        case .home:
            return #imageLiteral(resourceName: "AddIcon")
        case .newTask:
            return nil
        }
    }
    
}

class BaseVC: UIViewController {
    private var type: ViewControllerType = .home

    private var customNavigationBar: CustomNavigationBar!
    
    private let viewStatus : UIView = {
        let vw = UIView(frame: .zero)
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.backgroundColor = #colorLiteral(red: 0.3764705882, green: 0.2078431373, blue: 0.8156862745, alpha: 1)
        return vw
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
}

// MARK: - Set Up UI
extension BaseVC {
    private func setUpUI() {
        view.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9725490196, alpha: 1)
        self.customNavigationBar = CustomNavigationBar(delegate: self)
        self.view.addSubview(self.customNavigationBar)
        self.customNavigationBar.leadingAnchor(margin: 0).topAnchor(margin: C.statusBarHeight).trailingAnchor(margin: 0).heightAnchor(C.navigationBarHeight)
        
        KeyWindow.addSubview(viewStatus)
        viewStatus.topAnchor.constraint(equalTo: KeyWindow.topAnchor, constant: 0).isActive = true
        viewStatus.leadingAnchor.constraint(equalTo: KeyWindow.leadingAnchor, constant: 0).isActive = true
        viewStatus.trailingAnchor.constraint(equalTo: KeyWindow.trailingAnchor, constant: 0).isActive = true
        viewStatus.heightAnchor.constraint(equalToConstant: C.statusBarHeight).isActive = true
    }
}

// MARK: - CustomNavBar Delegate
extension BaseVC: CustomNavigationBarDelegate {
    func customNavigationBarDidTappedLeftButton(_ navigationBar: CustomNavigationBar) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func customNavigationBarDidTappedRightButton(_ navigationBar: CustomNavigationBar) {
        switch self.type {
            case .home:
               
                baseVCAddOnTap()
            default:
                break
        }
    }
    
    @objc func baseVCAddOnTap() { }
}

extension BaseVC {
    private func updateUI() {
        let className = String(describing: Swift.type(of: self))
        self.type = ViewControllerType(rawValue: className)!
        self.customNavigationBar.setTitle(self.type.title)
        self.customNavigationBar.setLeftButtonImage(self.type.leftButtonImage)
        self.customNavigationBar.setRightButtonImage(self.type.rightButtonImage)
    }
}
