//
//  LandingScreen + Navigation.swift
//  TechnologyAssisment
//
//  Created by Mashhood Qadeer on 25/04/2025.
//

import UIKit

extension LandingScreen{
    
    func styleNavigationBar(){
        
         guard let nav = navigationController as? NavController else { return }
         
         self.title = "NY Times Most Popular"
         
         //Drawer Icon
         let drawerImage = AppImages.DRAWER_ICON.image.withRenderingMode(.alwaysOriginal)
         let drawerButton = UIButton(type: .custom)
         drawerButton.setImage(drawerImage, for: .normal)
         let drawerItem = UIBarButtonItem(customView: drawerButton)
         navigationItem.leftBarButtonItem = drawerItem
        
         //Search Icon
         let searchIcon = nav.createBarButton(imageName: AppImages.SEARCH_ICON.rawValue, target: self, action: #selector(self.searchButtonTapped))
        
         //Drop Menu
         let dropMenu = nav.createBarButton(imageName: AppImages.DROPDOWN_ICON.rawValue, target: self, action: #selector(self.dropdownMenuTapped))
         navigationItem.rightBarButtonItems = [dropMenu, searchIcon]
          
    }
    
    @objc private func searchButtonTapped(_ sender: Any){
          
    }
        
    @objc private func dropdownMenuTapped(_ sender: Any ){
         
    }
    
}
