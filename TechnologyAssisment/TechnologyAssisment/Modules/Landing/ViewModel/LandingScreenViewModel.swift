// LandingScreenViewModel.swift
// TechnologyAssisment
// Created by Mashhood Qadeer on 25/04/2025.

import Foundation
import Combine

enum ListingItemType{
     case LOADING_CONTENT
     case NEWS_ITEM
     case ERROR(message:String)
}

protocol ListingItem_Interface{
    var type: ListingItemType{get set}
    var data: Any{get set}
}

struct ListingItem: ListingItem_Interface{

    var type: ListingItemType
    var data: Any
    
}
 
typealias ListData =  [ListingItem]

class LandingScreenViewModel{
   
    var disposebag: Set<AnyCancellable> = Set<AnyCancellable>()
    var data: CurrentValueSubject<ListData, Never> = CurrentValueSubject<ListData, Never>(
        {
          return [ListingItem(type: .LOADING_CONTENT, data: "")]
        }()
    )
    
    var dataList: ListData {
        get {
            return data.value
        }
    }
 
    func fetchData(){
          
         self.data.send(  self.placeholder )
        
         let apiRoute = API_ROUTES.MOST_VIEWED(sectionInformation: "all-sections", duration: 7)
         HttpService.shared.request(with: apiRoute, to: NYTResponse.self)
           .subscribe(on: DispatchQueue.global(qos: .background))
           .sink {[weak self] completion in
               
               guard let self else{
                     return
               }
               
               switch completion{
                   
               case .finished:
                     break
               
               case .failure(let error):
                    self.emitError(message: error.localizedDescription)
                    break
                  
               }
               
           } receiveValue: {[weak self] nYTResponse in
             
               guard let self  else {return}
            
               if nYTResponse.results.count == 0 {
                  self.emitError(message: "No Articals found")
                  return
               }
               
               self.data.send(
                
                nYTResponse.results.map({
                    ListingItem(type: .NEWS_ITEM, data: $0)
                })
                
               )
               
           }.store(in: &disposebag)
        
    }
    
    func emitError(message: String){
        
        self.data.send(
          [
            ListingItem(type: .ERROR(message: message), data: message)
          ]
        )
        
    }
    
    var placeholder: ListData {
        get {
            return [ListingItem(type: .LOADING_CONTENT, data: "")]
        }
    }
    
}
