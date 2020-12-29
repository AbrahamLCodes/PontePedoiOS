//
//  ViewController.swift
//  Ponte Pedo
//
//  Created by Abraham Luna on 21/12/20.
//

import SideMenu
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var comoItemTxt: UIBarButtonItem!
    @IBOutlet weak var ncarta: UILabel!
    @IBOutlet weak var efecto: UILabel!
    @IBOutlet weak var cartaBtn: UIButton!
    
    var menu : SideMenuNavigationController?
    
    let fontNCarta : CGFloat =  0.060
    let fontEfecto : CGFloat = 0.070
    let fontComo : CGFloat = 0.06
    
    
    //Method to prepare a Label to ve shown as an Android Toast
    func showToast(message : String, font: UIFont) {

        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 10.0, delay: 0.1, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    //Component to prepare an ImageBiew as a Background
    var imageView: UIImageView = {
            let imageView = UIImageView(frame: .zero)
            imageView.image = UIImage(named: "fondoobscuro.png")
            imageView.contentMode = .scaleToFill
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
    
    //Method to set an Image as a Background in the App
    func setBackgroundImage(){
        view.insertSubview(imageView, at: 0)
                NSLayoutConstraint.activate([
                    imageView.topAnchor.constraint(equalTo: view.topAnchor),
                    imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
                ])
    }
    
    //Method to resize label font size by screen size
    func initLabelsFont(){
        ncarta.font = ncarta.font.withSize(self.view.frame.width * fontNCarta)
        efecto.font = efecto.font.withSize(self.view.frame.width * fontEfecto)
        //Faltaria cambiar el font del comoItemTxt
        //Este seria un ejemplo:
        //comoBtnTxt.titleLabel?.font = UIFont(name: "¿Cómo se juega?", size: self.view.frame.width * fontComo)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setBackgroundImage()
        initLabelsFont()
        
        menu = SideMenuNavigationController(rootViewController: MenuListController())
        menu?.leftSide = true
        menu?.setNavigationBarHidden(true, animated: false)

        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
    }
    
    @IBAction func cartaPressed(_ sender: UIButton) {
        
        self.showToast(message: "Carta Presionada", font: .systemFont(ofSize: 12.0))
    }
    
    @IBAction func didComoPressed(_ sender: UIBarButtonItem) {
        self.showToast(message: "Como jugar presionado", font: .systemFont(ofSize: 12.0))
    }
    
    @IBAction func didSettingsPressed(_ sender: UIBarButtonItem) {
        present(menu!, animated: true)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
}
