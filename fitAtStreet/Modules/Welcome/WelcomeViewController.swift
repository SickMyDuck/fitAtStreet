 //
//  WelcomeViewController.swift
//  fitAtStreet
//
//  Created by Ruslan Sadritdinov on 23.08.2023.
//  
//

import UIKit

class WelcomeViewController: UIViewController {

    let nextButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        setupButton()
        title = .greetingText
    }

    func setupButton() {
        view.addSubview(nextButton)
        nextButton.backgroundColor = .systemPink
        nextButton.setTitle("Next", for: .normal)


        nextButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            nextButton.widthAnchor.constraint(equalToConstant: 200),
            nextButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

// MARK: - Localization
private extension String {
	static let greetingText = NSLocalizedString("welcome.registration.title", comment: "User greeting")
}
