//
//  NetworkService.swift
//  Multipart
//
//  Created by Yury Bogdanov on 02/02/2019.
//  Copyright © 2019 Yury Bogdanov. All rights reserved.
//

import Foundation
import MobileCoreServices


final class NetworkService {
    
    private enum Constants {
        static let boundary = "test.network.boundary.1991"
    }
    
    
    func createHTTPBody(withBoundary boundary: String,
                        path: String,
                        fieldName: String) -> Data {
        
        var httpBody = Data()
        
        let fileName = path.lastPathComponent
        let data = Data.dataWithContentsOfFile(path)
        let mime = mimeTypeForPath(path: path)
        
        httpBody.append("--\(boundary)\r\n".data(using: .utf8)!)
        httpBody.append("Content-Disposition: form-data; name=\"\(fieldName); filename=\(fileName)\r\n".data(using: .utf8)!)
        httpBody.append("Content-Type: \(mime)\r\n\r\n".data(using: .utf8)!)
        httpBody.append(data)
        httpBody.append("\r\n".data(using: .utf8)!)
        
        httpBody.append("--\(boundary)--\r\n".data(using: .utf8)!)
        return httpBody
    }
    
    
    func mimeTypeForPath(path: String) -> String {
        let url = NSURL(fileURLWithPath: path)
        let pathExtension = url.pathExtension
        
        if let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, pathExtension! as NSString, nil)?.takeRetainedValue() {
            if let mimetype = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?.takeRetainedValue() {
                return mimetype as String
            }
        }
        return "application/unknown"
    }
}


extension String {
    var lastPathComponent: String {
        return (self as NSString).lastPathComponent
    }
    
    var pathExtension: String {
        return (self as NSString).pathExtension
    }
}

extension Data {
    
    static func dataWithContentsOfFile(_ path: String) -> Data {
        if let nsData = NSData(contentsOfFile: path) {
            return nsData as Data
        } else {
            assertionFailure("The file provided contains no data!")
            return Data()
        }
    }
}
