//  UIImage+Extensions.swift
//  TechnologyAssisment
//  Created by Mashhood Qadeer on 25/04/2025.

import UIKit

enum AppImages: String {

    case DRAWER_ICON = "Drawer_Icon"
    case SEARCH_ICON = "Search_Icon"
    case DROPDOWN_ICON = "Drop_Menu"

}

extension AppImages {

  var image: UIImage {
      return getImage(name: self.rawValue)
  }

  private func getImage(name: String) -> UIImage {
            return UIImage(named: name) ?? UIImage()
  }

}
