//
//  RegisterViewController.swift
//  FIlaMed
//
//  Created by Danilo Araújo on 22/06/20.
//  Copyright © 2020 FilaMed. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    let loginView = LoginView()
    var handle: AuthStateDidChangeListenerHandle?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = self.loginView
        setupAdditionalConfiguration()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handle = Auth.auth().addStateDidChangeListener { (_, _) in
            print("Checar se o usuário está logado")
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handle!)
    }

    func showAlert(message: String = "Erro inesperado", title: String = "Erro") {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)

        alertController.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alertController, animated: true, completion: nil)
    }

    func setupAdditionalConfiguration() {
        self.loginView.loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
    }

    func showAppointments() {
        let tabBarNavigationController = TabBarController()
        tabBarNavigationController.modalPresentationStyle = .fullScreen
        self.present(tabBarNavigationController, animated: true)
    }

    @objc
    func login() {
        guard let email = self.loginView.emailTextField.text else { return }
        guard let password = self.loginView.passwordTextField.text else { return }

        Auth.auth().signIn(withEmail: email, password: password) { [weak self] _, _ in
            guard let strongSelf = self else { return }
            strongSelf.showAppointments()
        }
    }
}
