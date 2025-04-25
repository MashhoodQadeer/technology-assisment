//
//  Colors+Extensions.swift
//  TechnologyAssisment
//
//  Created by Mashhood Qadeer on 25/04/2025.
//

import UIKit

enum AppColors: String {

  case NVIGATION_BAR_BACKGROUND = "Navigationbar"
  case NVIGATION_BAR_TINT_COLOR = "NavigationbarContentTint"

}

extension AppColors {

  var color: UIColor {
    return getColor(name: self.rawValue)
  }

  private func getColor(name: String) -> UIColor {
    return UIColor(named: name) ?? UIColor.clear
  }

}
