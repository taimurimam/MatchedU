//
//  UsefulFunc.swift
//  Football
//
//  Created by Sk Azad on 29/07/23.
//

import Foundation

func data(from fileURL: URL) -> Data {
    do {
        let data = try Data(contentsOf: fileURL)
        return data
    } catch {
        print("Error loading data from file: \(error)")
        return Data()
    }
}

func formatURLString(_ urlString: String) -> String {
    if let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
        return encodedString
    } else {
        return ""
    }
}
