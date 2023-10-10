//
//  BaseViewController.swift
//  fitAtStreet
//
//  Created by Ruslan Sadritdinov on 11.09.2023.
//

import UIKit

class BaseViewController<ViewModelT: ViewModelProtocolBase>: UIViewController {
    
    let viewModel: ViewModelT

    init(_ viewModel: ViewModelT) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    deinit {
        Log.write(message: "DEINIT \(self)", category: .application, level: .debug)
    }

    override func loadView() {
        super.loadView()
        // FIXME: Change
   //     view.backgroundColor = .white
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        navigationController?.setNavigationBarHidden(false, animated: animated)
//        // FIXME: Change
//        navigationController?.navigationBar.barTintColor = .black
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        registerForKeyboardNotifications()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        unregisterForKeyboardNotifications()
    }


    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    private func unregisterForKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }


    func processKeyboardVisibleHeight(_ height: CGFloat) {
    }

    @objc
    private func keyboardWillShow(_ notification: NSNotification) {
        let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        let rect = value?.cgRectValue
        runKeyboardVisibilityProcess(with: rect?.height ?? 0)
    }

    @objc
    private func keyboardWillHide(_ notification: NSNotification) {
        runKeyboardVisibilityProcess(with: 0)
    }

    private func runKeyboardVisibilityProcess(with height: CGFloat) {
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.processKeyboardVisibleHeight(height)
        }
    }
}

