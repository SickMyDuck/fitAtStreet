//
//  RegistrationViewController.swift
//  fitAtStreet
//
//  Created by Ruslan Sadritdinov on 23.08.2023.
//  
//

import UIKit

final class RegistrationViewController: BaseViewController<RegistrationViewModel> {


    // MARK: - Private Properties
    private let progressView = ProgressBarView()

    private let enterNameStack = UIStackView()
    private let enterNameLabel = UILabel()
    private let enterNameTextField = TextField(placeholder: "")

    private let enterAgeStack = UIStackView()
    private let enterAgeLabel = UILabel()
    private let enterAgeTextField = TextField(placeholder: "")

    private let selectGenderStack = UIStackView()
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
        view.backgroundColor = .white

        configure()

    }
}

// MARK: - Configuration
private extension RegistrationViewController {

    func configure() {
        setupTexts()

        setupProgressView(with: progressView)

        setupStackView(with: enterNameStack, firstView: true)
        setupStackView(with: enterAgeStack, firstView: false)
        setupStackView(with: selectGenderStack, firstView: false)

        setupLabel(with: enterNameStack, label: enterNameLabel)
        setupTextField(with: enterNameStack, textField: enterNameTextField)

        setupLabel(with: enterAgeStack, label: enterAgeLabel)
        setupEnterAgeTextField(with: enterAgeStack, textField: enterAgeTextField)

        setupLabel(with: selectGenderStack, label: chooseGenderLabel)
        setupGenderPicker(with: selectGenderStack)

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


// MARK: - ProgressView Section

private extension RegistrationViewController {

    func setupProgressView(with progressView: ProgressBarView) {

        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)

        let progressBar = ProgressBarView()
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(progressBar)

        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.topAnchor.constraint(equalTo:view.topAnchor, constant: 100),
            containerView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 4/5),
            containerView.heightAnchor.constraint(equalToConstant: 80)
        ])

        NSLayoutConstraint.activate([
            progressBar.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            progressBar.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            progressBar.topAnchor.constraint(equalTo: containerView.topAnchor),
            progressBar.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])

    }

}

// MARK: - StackView Section
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

// MARK: - Label And TextField Section
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

        let imageName = gender == .male ? "maleIcon" : "femaleIcon"
        button.setImage(UIImage(named: imageName), for: .normal)
        button.adjustsImageWhenHighlighted = false

        button.translatesAutoresizingMaskIntoConstraints = false

        button.setTitleColor(.white, for: .normal)

        button.backgroundColor = gender == .male ? .systemBlue : .systemPink
        button.titleLabel?.font = UIFont(name: "Roboto", size: 14)
        button.layer.cornerRadius = .small

        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 40),
            button.heightAnchor.constraint(equalToConstant: 60)
        ])

        addActionToGenderButton(gender: gender)
    }

    func addActionToGenderButton(gender: Gender) {
        if gender == .male {
            maleButton.addTarget(self, action: #selector(maleButtonTapped), for: .touchUpInside)
        } else {
            femaleButton.addTarget(self, action: #selector(femaleButtonTapped), for: .touchUpInside)
        }
    }

    @objc func maleButtonTapped() {

        Vibration.light.vibrate()

        UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.5, options: .curveEaseIn, animations:  {
            self.maleButton.transform = CGAffineTransform(scaleX: 0.92, y: 0.92)
        }) { _ in
            UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 4, animations: {
                self.maleButton.transform = CGAffineTransform(scaleX: 1, y: 1)
            } , completion: nil)
        }
        self.femaleButton.layer.borderWidth = 0
        self.maleButton.layer.borderWidth = 3
        self.maleButton.layer.borderColor = UIColor.blue.cgColor

    }

    @objc func femaleButtonTapped() {

        Vibration.light.vibrate()

        UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.5, options: .curveEaseIn, animations:  {
            self.femaleButton.transform = CGAffineTransform(scaleX: 0.92, y: 0.92)
        }) { _ in
            UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 4, animations: {
                self.femaleButton.transform = CGAffineTransform(scaleX: 1, y: 1)
            } , completion: nil)
        }
        self.maleButton.layer.borderWidth = 0
        self.femaleButton.layer.borderWidth = 3
        self.femaleButton.layer.borderColor = UIColor.systemPink.cgColor
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

        UIView.animate(withDuration: 0.35, delay: 0, options: [], animations: {
            self.currentStack.transform = CGAffineTransform(translationX: -self.view.bounds.width, y: 0)
            self.stackToShow.transform = .identity
            self.stackToShow.alpha = 1
        }, completion:
            nil)

        if currentStack == enterNameStack {
            currentStack = enterAgeStack
            stackToShow = selectGenderStack
        } else {
            currentStack = selectGenderStack
            self.nextButton.backgroundColor = .green
            self.nextButton.setTitle("Finish", for: .normal)

        }
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
