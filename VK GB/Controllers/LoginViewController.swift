//
//  ViewController.swift
//  VK GB
//
//  Created by Роман Вертячих on 28.04.2022.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var loginInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBAction func loginButtonPressed(_ sender: Any) {
        loginToApp()
    }
    
    func loginToApp() {
        checkUserData(email: loginInput.text, password: passwordInput.text, completition: { [weak self] isCompleted in
            guard isCompleted else {
                self?.showLoginError()
                return
            }
            DispatchQueue.main.async {
                let sb = UIStoryboard(name: "Main", bundle: nil)
                let vc = sb.instantiateViewController(withIdentifier: "vkTabBarController")
        //        vc.modalPresentationStyle = .fullScreen
                self?.present(vc, animated: true, completion: nil)
            }
        })
//        guard checkUserData() else {
//            showLoginError()
//            return
//        }
    }
    
    private func checkUserData(email: String?, password: String?, completition: @escaping (Bool) -> Void) {
//        guard loginInput.text! == "admin" && passwordInput.text! == "1" else { return false }
//        return true
        guard let email = loginInput.text,
              !email.isEmpty,
              let password = passwordInput.text,
              !password.isEmpty
        else {
            completition(false)
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            completition(authResult != nil)
        }
    }
    
    func showLoginError() {
        //Создаем контроллер
        let alert = UIAlertController(title: "Ошибка", message: "Введены не верные данные пользователя", preferredStyle: .alert)
        //Создаем кнопку для UIAlertController
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        //Добавляем кнопку UIAlertController
        alert.addAction(action)
        //Показываем UIAlertController
        present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Жест нажатия
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        // Присваиваем его UIScrollVIew
        scrollView?.addGestureRecognizer(hideKeyboardGesture)
        
        loginInput.delegate = self
        passwordInput.delegate = self
        
        loginInput.text = "admin"
        passwordInput.text = "1"
    }
        
    // Когда клавиатура появляется
    @objc func keyboardWasShown(notification: Notification) {
        // Получаем размер клавиатуры
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        // Добавляем отступ внизу UIScrollView, равный размеру клавиатуры
        self.scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    //Когда клавиатура исчезает
    @objc func keyboardWillBeHidden(notification: Notification) {
        // Устанавливаем отступ внизу UIScrollView, равный 0
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
    }
    
    @objc func hideKeyboard(){
        self.scrollView?.endEditing(true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Подписываемся на два уведомления: одно приходит при появлении клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        // Второе — когда она пропадает
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        passwordInput.becomeFirstResponder()
        guard textField == self.passwordInput else {
            return true
        }
        loginToApp()
        return textField.endEditing(true)
    }
}
