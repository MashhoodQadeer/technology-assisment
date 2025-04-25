//
//  String+Extension.swift
//  TechnologyAssisment
//
//  Created by Mashhood Qadeer on 25/04/2025.
//

import Foundation

extension String {
    /// Decodes a JSON string into a Decodable model using a closure-based result style.
    /// - Parameters:
    ///   - type: The model type to decode into.
    ///   - onSuccess: Closure called when decoding is successful.
    ///   - onFailure: Closure called with an error message when decoding fails.
    func decodeJSON<T: Decodable>(
        to type: T.Type,
        onSuccess: @escaping (T) -> Void,
        onFailure: @escaping (String) -> Void
    ) {
        guard let data = self.data(using: .utf8) else {
            onFailure("Invalid string encoding. Could not convert to Data.")
            return
        }

        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .useDefaultKeys
            let decodedObject = try decoder.decode(T.self, from: data)
            onSuccess(decodedObject)
        } catch {
            onFailure("Decoding failed: \(error.localizedDescription)")
        }
    }
}
