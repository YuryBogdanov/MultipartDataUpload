//
//  MultipartTests.swift
//  MultipartTests
//
//  Created by Yury Bogdanov on 02/02/2019.
//  Copyright © 2019 Yury Bogdanov. All rights reserved.
//

import XCTest


class MultipartTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        let net = NetworkService()
        
        let mime = net.mimeTypeForPath(path: "file/document.jpeg")
        print(mime)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
