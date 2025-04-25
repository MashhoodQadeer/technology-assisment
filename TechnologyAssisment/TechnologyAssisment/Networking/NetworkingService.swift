//
//  NetworkingService.swift
//  TechnologyAssisment
//
//  Created by Mashhood Qadeer on 25/04/2025.
//

import Foundation
import Combine

final class ErrorFactory{
    
    static let shared = ErrorFactory()
    
    private init() {}
    
    func createError(domain: String, code: Int, message: String) -> NSError {
        let userInfo = [NSLocalizedDescriptionKey: message]
        return NSError(domain: domain, code: code, userInfo: userInfo)
    }
}

final class HttpService{
    
    static let shared = HttpService()
    private init(){}

    private let domain = "com.assignment.TechnologyAssisment"

    func request<T: Decodable>(with route: API_ROUTES, to responseType: T.Type) -> Future<T, NSError>{
        return Future { promise in
            guard let url = route.url else{
                let error = ErrorFactory.shared.createError(domain: self.domain, code: 100, message: "Invalid Request URL")
                promise(.failure(error))
                return
            }

            var request = URLRequest(url: url)
            request.httpMethod = route.requestType

            for (key, value) in route.headers {
                request.setValue("\(value)", forHTTPHeaderField: key)
            }

            if route.requestType != HTTP_REQUESTS.GET.rawValue {
                do {
                    request.httpBody = try JSONSerialization.data(withJSONObject: route.payload)
                } catch {
                    let error = ErrorFactory.shared.createError(domain: self.domain, code: 101, message: "Invalid payload")
                    promise(.failure(error))
                    return
                }
            }

            HttpLogger.instance.log(
                requestURL: url.absoluteString,
                requestPayload: route.payload,
                headers: route.headers,
                requestType: route.requestType
            )

            let configuration = URLSessionConfiguration.default
            let timeout = TimeInterval(HttpServiceSettings.REQUEST_TIMEOUT.rawValue)
            configuration.timeoutIntervalForRequest = timeout
            configuration.timeoutIntervalForResource = timeout

            let session = URLSession(configuration: configuration)

            session.dataTask(with: request) { data, response, error in
                if let error = error {
                    let nsError = ErrorFactory.shared.createError(domain: self.domain, code: 400, message: error.localizedDescription)
                    promise(.failure(nsError))
                    return
                }

                guard let data = data else {
                    let nsError = ErrorFactory.shared.createError(domain: self.domain, code: 400, message: "Empty data response")
                    promise(.failure(nsError))
                    return
                }

                HttpLogger.instance.logResponse(requestURL: url.absoluteString, requestResponse: String(data: data, encoding: .utf8) ?? "")

                // Decode the response JSON string into the desired type (T)
                let responseString = String(data: data, encoding: .utf8) ?? ""
                
                responseString.decodeJSON(to: responseType) { decodedResponse in
                    promise(.success(decodedResponse))
                } onFailure: { error in
                    let nsError = ErrorFactory.shared.createError(domain: self.domain, code: 400, message: "Response could not be parsed")
                    promise(.failure(nsError))
                }
            }.resume()
        }
    }
}

enum HttpServiceSettings {
    case REQUEST_TIMEOUT
    case INTERVAL_TASK_POLLING_SECONDS
    case INTERVAL_SCHEDULE_POLLING_SECONDS
    case TOKEN_LIFESPAN_SECONDS
    case SECONDS_BEFORE_PATIENT_NEEDS_UPDATE
}

extension HttpServiceSettings {
    var rawValue: Int {
        switch self {
        case .REQUEST_TIMEOUT: return 300
        case .INTERVAL_TASK_POLLING_SECONDS: return 30
        case .INTERVAL_SCHEDULE_POLLING_SECONDS: return 300
        case .TOKEN_LIFESPAN_SECONDS: return 1800
        case .SECONDS_BEFORE_PATIENT_NEEDS_UPDATE: return 180
        }
    }
}
