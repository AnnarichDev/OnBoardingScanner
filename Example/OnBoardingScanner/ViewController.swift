//
//  ViewController.swift
//  OnBoardingScanner
//
//  Created by AnnarichDev on 03/08/2024.
//  Copyright (c) 2024 AnnarichDev. All rights reserved.
//

import UIKit
import OnBoardingScanner
import SnapKit

class ViewController: UIViewController {

    let stackView = UIStackView()
    let qrScannerButton = UIButton()
    let codeLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        stackView.axis = .vertical
        stackView.spacing = 16.0
        
        view.addSubview(stackView)
        stackView.addArrangedSubview(qrScannerButton)
        stackView.addArrangedSubview(codeLabel)
        qrScannerButton.setTitle("QRScanner", for: .normal)
        qrScannerButton.setTitleColor(.black, for: .normal)
        stackView.snp.makeConstraints {
            $0.width.equalTo(100.0)
            $0.center.equalToSuperview()
        }
        qrScannerButton.snp.makeConstraints {
            $0.size.equalTo(100.0)
        }
        qrScannerButton.addTarget(self, action: #selector(qrScannerPress), for: .touchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc private func qrScannerPress() {
        let qrScanner = QRScannerViewController()
        qrScanner.delegate = self
        present(qrScanner, animated: true)
    }
}

extension ViewController: QRScannerViewControllerDelegate {
    
    func didReceiveQRScannerResult(_ string: String) {
        codeLabel.text = string
    }
}
