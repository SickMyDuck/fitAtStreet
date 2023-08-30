//
//  RegistrationViewController.swift
//  fitAtStreet
//
//  Created by Ruslan Sadritdinov on 23.08.2023.
//  
//

import UIKit

final class RegistrationViewController: UIViewController {

    private let enterNameStack = UIStackView()
    private let enterNameLabel = UILabel()
    private let enterNameTextField = TextField(placeholder: "")

    private let enterAgeStack = UIStackView()
    private let enterAgeLabel = UILabel()
    private let enterAgeTextField = TextField(placeholder: "")

    private let chooseGenderStack = UIStackView()
    private let chooseGenderLabel = UILabel()

    private let genderPickerStackView = UIStackView()
    private let maleButton = UIButton()
    private let femaleButton = UIButton()

    private let nextButton = MainButton()

    private var currentStack = UIStackView()
    private var stackToShow = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        configure()
    }
}

// MARK: - Configuration
private extension RegistrationViewController {

    func configure() {
        setupTexts()

        setupStackView(with: enterNameStack, firstView: true)
        setupStackView(with: enterAgeStack, firstView: false)
        setupStackView(with: chooseGenderStack, firstView: false)

        setupLabel(with: enterNameStack, label: enterNameLabel)
        setupTextField(with: enterNameStack, textField: enterNameTextField)

        setupLabel(with: enterAgeStack, label: enterAgeLabel)
        setupEnterAgeTextField(with: enterAgeStack, textField: enterAgeTextField)

        setupLabel(with: chooseGenderStack, label: chooseGenderLabel)
        setupGenderPicker(with: chooseGenderStack)

        setupNextButton()
        setInitialStackView()
    }

    func setupTexts() {
        title = .greetingText
        enterNameLabel.text = .enterName
        enterAgeLabel.text = .enterAge
        chooseGenderLabel.text = .chooseGender
    }

    func setInitialStackView() {
        currentStack = enterNameStack
        stackToShow = enterAgeStack
    }

}

private extension RegistrationViewController {

    func setupStackView(with stackView: UIStackView, firstView: Bool) {
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.spacing = .large
        stackView.alpha = firstView ? 1 : 0

        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

}

private extension RegistrationViewController {
    func setupLabel(with stackView: UIStackView, label: UILabel) {
        stackView.addArrangedSubview(label)
        label.font = .boldSystemFont(ofSize: 22)

        label.translatesAutoresizingMaskIntoConstraints = false
    }

    func setupTextField(with stackView: UIStackView, textField: TextField) {
        stackView.addArrangedSubview(textField)

        textField.translatesAutoresizingMaskIntoConstraints = false
    }

    func setupEnterAgeTextField(with stackView: UIStackView, textField: TextField) {
        setupTextField(with: stackView, textField: textField)
        textField.keyboardType = .asciiCapableNumberPad
    }

}

// MARK: - Gender Section
private extension RegistrationViewController {
    func setupGenderPicker(with stackView: UIStackView) {
        stackView.addArrangedSubview(genderPickerStackView)
        genderPickerStackView.axis = .horizontal
        genderPickerStackView.spacing = .large

        genderPickerStackView.translatesAutoresizingMaskIntoConstraints = false

        configureGenderButton(button: maleButton, gender: .male)

        configureGenderButton(button: femaleButton, gender: .female)

    }

    func configureGenderButton(button: UIButton, gender: Gender) {

        genderPickerStackView.addArrangedSubview(button)
        let title = gender == .male ? "Male" : "Female"
        button.setTitle(title, for: .normal)

        button.translatesAutoresizingMaskIntoConstraints = false

        button.setTitleColor(.white, for: .normal)

        button.backgroundColor = gender == .male ? .systemBlue : .systemPink
        button.titleLabel?.font = UIFont(name: "Roboto", size: 14)
        button.layer.cornerRadius = .large

        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 80),
            button.heightAnchor.constraint(equalToConstant: 60)
        ])
    }


}

// MARK: - Button Сonfiguration
private extension RegistrationViewController {
    func setupNextButton() {
        view.addSubview(nextButton)
        nextButton.setTitle(.next, for: .normal)

        nextButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.topAnchor.constraint(equalTo: enterNameStack.bottomAnchor, constant: 50),
            nextButton.widthAnchor.constraint(equalToConstant: 220),
            nextButton.heightAnchor.constraint(equalToConstant: 60)
        ])

        addActionToNextButton()

    }
}

// MARK: - Button Actions
private extension RegistrationViewController {
    func addActionToNextButton() {
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }

    @objc func nextButtonTapped() {
        nextButton.tap()

        UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {
            self.currentStack.transform = CGAffineTransform(translationX: -self.view.bounds.width, y: 0)
            self.stackToShow.transform = .identity
            self.stackToShow.alpha = 1
        }, completion:
            nil)

        currentStack = enterAgeStack
        stackToShow = chooseGenderStack
    }
}

// MARK: - Localization
private extension String {
    static let greetingText = NSLocalizedString("welcome.registration.title", comment: "User greeting")
    static let enterName = NSLocalizedString("welcome.registration.enter_name", comment: "welcome.registration.enter_name")
    static let enterAge = NSLocalizedString("welcome.registration.enter_age", comment: "welcome.registration.enter_age")
    static let chooseGender = NSLocalizedString("welcome.registration.enter_gender", comment: "welcome.registration.enter_gender")
    static let next = NSLocalizedString("button.next.title", comment: "button.next.title")
}
