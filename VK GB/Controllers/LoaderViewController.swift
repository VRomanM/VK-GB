//
//  LaunchScreenViewController.swift
//  VK GB
//
//  Created by Роман Вертячих on 25.05.2022.
//

import UIKit

class LoaderViewController: UIViewController {

    @IBOutlet weak var point1: UIImageView!
    @IBOutlet weak var point2: UIImageView!
    @IBOutlet weak var point3: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.7, delay: 0) {
            self.point1.layer.opacity = 0
        }
        UIView.animate(withDuration: 0.7, delay: 0.2) {
            self.point2.layer.opacity = 0
        }
        UIView.animate(withDuration: 1, delay: 0.7) {
            self.point3.layer.opacity = 0
        }
        completion: { _ in
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "loginVC")
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
