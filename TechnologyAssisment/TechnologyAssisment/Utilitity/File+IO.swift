//
//  File+IO.swift
//  TechnologyAssisment
//
//  Created by Mashhood Qadeer on 25/04/2025.
//

import Foundation

class FileIO {

    static let shared = FileIO()
    private init() {}

    func readFile(
        fileName: String,
        fileType: String = "json",
        bundle: Bundle = .main,
        onSuccess: @escaping (String) -> Void,
        onFailure: @escaping (String) -> Void
    ) {
        guard let path = bundle.path(forResource: fileName, ofType: fileType) else {
            onFailure("File not found: \(fileName).\(fileType)")
            return
        }

        do {
            let content = try String(contentsOfFile: path, encoding: .utf8)
            onSuccess(content)
        } catch {
            onFailure("Failed to read file: \(error.localizedDescription)")
        }
    }

}
