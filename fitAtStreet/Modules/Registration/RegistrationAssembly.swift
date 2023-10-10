//
//  RegistrationAssembly.swift
//  fitAtStreet
//
//  Created by Ruslan Sadritdinov on 23.08.2023.
//  
//

import UIKit

struct RegistrationAssembly {
    func assembly() -> UIViewController {
        let router = RegistrationRouter()
        let viewModel = RegistrationViewModel(router: router)
        let viewController = RegistrationViewController(viewModel)
        return viewController
    }
}
