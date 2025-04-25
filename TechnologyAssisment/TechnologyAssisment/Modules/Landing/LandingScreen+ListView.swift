//
//  LandingScreen+ListView.swift
//  TechnologyAssisment
//
//  Created by Mashhood Qadeer on 25/04/2025.
//

import Foundation
import UIKit

extension LandingScreen{
    
    func setupTableView(){
         self.listView.separatorStyle = .none
         self.listView.separatorColor = .clear
         self.listView.register(UINib(nibName: String(describing: LoadingContentTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: LoadingContentTableViewCell.self))
         self.listView.register(UINib(nibName: String(describing: ErrorMessageCell.self), bundle: nil), forCellReuseIdentifier: String(describing: ErrorMessageCell.self))
         self.listView.register(UINib(nibName: String(describing: ArticalViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: ArticalViewCell.self))
         self.listView.delegate = self
         self.listView.dataSource = self
         self.subscribeEvent()
         self.setupRefreshControl()
        
    }
    
    private func setupRefreshControl() {
           
            listView.refreshControl = refreshControl
            refreshControl.tintColor = .lightGray
            refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh news")
            refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        
    }
    
    @objc private func refreshData(_ sender: Any){
        
          self.viewModel.fetchData()
        
    }
    
    func subscribeEvent(){
         
         self.viewModel.data
             .receive(on: DispatchQueue.main)
             .sink { [weak self] value in
             guard let self else {return}
             self.listView.reloadData()
             self.refreshControl.endRefreshing()
         }.store(in: &self.disposebag)
        
    }
    
}

extension LandingScreen: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         self.viewModel.dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let dataItem = self.viewModel.dataList[indexPath.row]
        
        switch(dataItem.type){
            
        case .ERROR(message: let message):
        if let cell = self.listView.dequeueReusableCell(withIdentifier: String(describing: ErrorMessageCell.self), for: indexPath) as? ErrorMessageCell{
                    cell.selectionStyle = .none
            cell.showMessage(message: message)
            return cell
        }
        break
            
        case .LOADING_CONTENT:
        if let cell = self.listView.dequeueReusableCell(withIdentifier: String(describing: LoadingContentTableViewCell.self), for: indexPath) as? LoadingContentTableViewCell {
                cell.selectionStyle = .none
                cell.activityIndicator?.startAnimating()
                return cell
        }
        
        case .NEWS_ITEM:
        if let cell = self.listView.dequeueReusableCell(withIdentifier: String(describing: ArticalViewCell.self), for: indexPath) as? ArticalViewCell {
                cell.selectionStyle = .none
                cell.setupLayout(data: dataItem.data)
                return cell
        }
                    
        }
        
        return UITableViewCell()
        
    }
  
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
             
        let dataItem = self.viewModel.dataList[indexPath.row]
        
        switch(dataItem.type){
            
        case .ERROR(message: _), .LOADING_CONTENT:
             return tableView.frame.height

        default:
        return UITableView.automaticDimension
            
        }
        
    }
    
}
