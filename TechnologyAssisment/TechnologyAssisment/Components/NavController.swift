//
//  NavController.swift
//  TechnologyAssisment
//
//  Created by Mashhood Qadeer on 25/04/2025.
//

import UIKit

class NavController: UINavigationController {

  override func viewDidLoad() {
    super.viewDidLoad()
    setupNavigationBar()
  }

  private func setupNavigationBar() {

    let appearance = UINavigationBarAppearance()
    appearance.configureWithOpaqueBackground()
    appearance.backgroundColor = AppColors.NVIGATION_BAR_BACKGROUND.color
    appearance.titleTextAttributes = [.foregroundColor: AppColors.NVIGATION_BAR_TINT_COLOR.color]

    appearance.shadowColor = .clear
    appearance.shadowImage = UIImage()

    navigationBar.standardAppearance = appearance
    navigationBar.scrollEdgeAppearance = appearance
    navigationBar.compactAppearance = appearance

    addCustomShadow()

    navigationBar.tintColor = .white
    navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
  }

  private func addCustomShadow() {
    navigationBar.shadowImage = UIImage()
    navigationBar.layer.masksToBounds = false
    navigationBar.layer.shadowColor = UIColor.black.cgColor
    navigationBar.layer.shadowOpacity = 0.3
    navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2)
    navigationBar.layer.shadowRadius = 4
  }

  func createBarButton(imageName: String, target: Any, action: Selector) -> UIBarButtonItem {
    let button = UIButton(type: .system)
    button.setImage(UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal), for: .normal)
    button.addTarget(target, action: action, for: .touchUpInside)
    button.tintColor = .clear
    button.imageView?.contentMode = .scaleAspectFit

    let buttonSize = CGSize(width: 24, height: 24)
    button.frame = CGRect(origin: .zero, size: buttonSize)

    return UIBarButtonItem(customView: button)
  }

}
