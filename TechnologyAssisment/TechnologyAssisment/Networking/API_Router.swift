//
//  API_Router.swift
//  TechnologyAssisment
//
//  Created by Mashhood Qadeer on 25/04/2025.
//

import Foundation

typealias API_Payload = [String : Any]
typealias API_Slugs = [String]

enum API_ROUTES{
     
    case MOST_VIEWED( sectionInformation: String,
                      duration: Int)
     
}

enum HTTP_REQUESTS: String{
     
     case GET = "GET"
     case POST = "POST"
     case PUT = "PUT"
     
}

//Request Type
extension API_ROUTES{
    
    var requestType: String{
    
    switch self {
    
    case .MOST_VIEWED( sectionInformation: _,
                       duration: _):
    return HTTP_REQUESTS.GET.rawValue

    }

  }
    
}

//URL
extension API_ROUTES{
    
    var url: URL?{
    
    switch self{
      
      case .MOST_VIEWED( sectionInformation: let sectionInformation,
                         duration: let duration):
      var path = self.getPath(
        slug: [
        self.apiMainSlug,
        self.apiSlug,
        sectionInformation,
        [String(duration), "json"].joined(separator: ".")]
      )
      if let safePath = path, let value = self.appendQueryParameters(url: safePath, params: self.payload) {
          path = value
      }
      return path
      
    }
      
  }
    
  func appendQueryParameters(url: URL, params: [String: Any]) -> URL?{
       
       if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false){

          var queryItems = urlComponents.queryItems ?? []
           
          for(key, value) in params {
              queryItems.append( URLQueryItem(name: key, value: "\(value)") )
          }
           
          if let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String {
              queryItems.append( URLQueryItem(name: "api-key", value: apiKey) )
          }
            
          urlComponents.queryItems = queryItems

          if let updatedURL = urlComponents.url {
             return updatedURL
          } else {
             return nil
          }
           
      } else {
             return nil
      }
      
  }
    
  func getPath( slug: API_Slugs ) -> URL? {
      
       guard let basePath = Bundle.main.object(forInfoDictionaryKey: "API_BASE_URL") as? String  else {return nil}
      
       var urlComponents = URLComponents(string: basePath)
       urlComponents?.path += slug.joined(separator: "/")
      
       return urlComponents?.url
      
  }
    
  var apiMainSlug: String{
        
        get{
            
            var slug : String = ""
            
            
            switch(self){
                
            case .MOST_VIEWED( sectionInformation: _,
                               duration: _):
                  slug =  "mostpopular"
                  break
                
            }
            
            guard let apiVersion = Bundle.main.object(forInfoDictionaryKey: "API_VERSION") as? String  else {return slug}
            
            return [slug, apiVersion ].joined(separator: "/")
            
        }
        
   }
    
   var apiSlug: String{
          
          get{
              
              switch(self){
                  
              case .MOST_VIEWED( sectionInformation: _,
                                 duration: _):
                    return "mostviewed"
                    
              }
              
          }
          
     }
    
}

//Headers
extension API_ROUTES{

    var headers: [String: Any] {

    switch self{

    default:
        return self.normalHeaders()
    }
      
  }
  
  func normalHeaders() -> [String: Any] {
       return [
              "Accept": "application/json",
              "Content-Type": "application/json",
       ]
  }
    
}

//Payload
extension API_ROUTES {
    
    var payload: API_Payload {
    
    switch self {
    
    default:
    return [String: Any]()
        
    }
      
  }
    
}

