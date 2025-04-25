//
//  HttpLogger.swift
//  TechnologyAssisment
//
//  Created by Mashhood Qadeer on 25/04/2025.
//

import Foundation

@objcMembers
@objc class HttpLogger : NSObject{
    
    static var instance : HttpLogger =  HttpLogger()
        
    func log( requestURL  destination : String, requestPayload  payload : [String : Any] , headers: [String : Any],   requestType: String, requestBody: NSData? = nil ){
         var dictionaryData :  [String : Any]  =  [String : Any]();
         dictionaryData["requestType"] = requestType;
         dictionaryData["requestPath"] = destination;
         dictionaryData["requestHeaders"] = headers;
         dictionaryData["params"] = payload;
         //Checking Optional Type On Data
         if( requestBody != nil ){
             do {
                 if let data = requestBody as Data? {
                     if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        dictionaryData["requestBody"] = json;
                     }
                 }
             } catch {
                 if let data = requestBody as Data? {
                     if let dataString = String(data: data, encoding: .utf8) {
                         dictionaryData["requestBody"] = dataString
                     }
                 }
                 print("Error decoding JSON: \(error.localizedDescription)")
             }
         }
         //End of Optional Type On Data
         print("<Start>Http Logger Request")
         self.printDictionaryAsJSON( payload: dictionaryData )
         print("</End>")
    }
    
    func logResponse( requestURL  destination : String, requestResponse  response : String  ){
         var dictionaryData :  [String : Any]  =  [String : Any]();
         dictionaryData["response"] = response;
         print("<Start>Http Logger Request Response for URL \(destination)")
         self.printDictionaryAsJSON( payload: dictionaryData )
         print("</End> URL \(destination)")
    }
    
    func printDictionaryAsJSON( payload : [String : Any] ){
         
         do {
                
               let jsonData = try JSONSerialization.data( withJSONObject: payload, options: .prettyPrinted )
               if let jsonString = String(data: jsonData, encoding: .utf8) {
                  dump( jsonString )
               }
             
         } catch {
               print("Error while creating JSON: \(error.localizedDescription)")
         }
         
    }
    
}
