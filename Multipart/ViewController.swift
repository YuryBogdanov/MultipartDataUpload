//
//  ViewController.swift
//  Multipart
//
//  Created by Yury Bogdanov on 02/02/2019.
//  Copyright © 2019 Yury Bogdanov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button = UIButton()
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 100),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
        button.setTitle("TEST NET", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(callNetwork), for: .touchUpInside)
    }

    
    
    
    @objc func callNetwork() {
        
        if let resourcePath = Bundle.main.resourcePath {
            let imgName = "Morrowind.png"
            let path = resourcePath + "/" + imgName
            
            
            let body = NetworkService().createHTTPBody(withBoundary: "Boundary-Test-Post",
                                                       path: path, fieldName: "file")
            
            var request = URLRequest(url: URL(string: "http://localhost:8989/upload")!)
            request.httpBody = body
            request.httpMethod = "POST"
            request.addValue("\(body.count)", forHTTPHeaderField: "Content-Length")
            request.addValue("multipart/form-data; boundary=Boundary-Test-Post", forHTTPHeaderField: "Content-Type")
            print("=== REQUEST = \(request.debugDescription)")
            URLSession(configuration: .default).uploadTask(with: request, from: body) { data, response, error in
                print("=== DATA = \(String(data: data!, encoding: .utf8))")
                print("=== RESP = \(response)")
                print("=== ERRO = \(error)")
            }
            .resume()
        }
        
        
    }
}

