//
//  RegistrationViewModel.swift
//  fitAtStreet
//
//  Created by Ruslan Sadritdinov on 23.08.2023.
//  
//

class RegistrationViewModel: RegistrationViewModelProtocol {

    private let router: RegistrationRouterProtocol

	required init(router: RegistrationRouterProtocol) {
		self.router = router
	}


}
