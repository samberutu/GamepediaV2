//
//  StringManipulator.swift
//  GamepediaV2
//
//  Created by Samlo Berutu on 18/11/21.
//

import SwiftUI

extension Data {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return  nil
        }
    }
    var html2String: String { html2AttributedString?.string ?? "" }
}

extension String {
    var html2AttributedString: NSAttributedString? {
        Data(utf8).html2AttributedString
    }
    var html2String: String {
        html2AttributedString?.string ?? ""
    }
}
