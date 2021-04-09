//
//  ViewController.swift
//  CloudDemo
//
//  Created by mac on 2021/4/9.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let btn = UIButton.init(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Request Api", for: .normal)
        btn.addTarget(self, action: #selector(showPhoto), for: .touchDown)
        
        view.addSubview(btn)
        NSLayoutConstraint.activate([
            btn.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            btn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            btn.widthAnchor.constraint(equalToConstant: 100),
            btn.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    @objc func showPhoto() {
        let vc = PhotoViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

