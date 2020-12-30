//
//  ViewController.swift
//  Ponte Pedo
//
//  Created by Abraham Luna on 21/12/20.
//

import SideMenu
import UIKit

class ViewController: UIViewController, MenuControllerDelegate {
    
    @IBOutlet weak var comoItemTxt: UIBarButtonItem!
    @IBOutlet weak var ncarta: UILabel!
    @IBOutlet weak var efecto: UILabel!
    @IBOutlet weak var cartaBtn: UIButton!
    
    var sideMenu : SideMenuNavigationController?
    
    let fontNCarta : CGFloat =  0.060
    let fontEfecto : CGFloat = 0.070
    let fontComo : CGFloat = 0.06
    
    private let rulesController = RulesViewController()
    
    
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
        
        let menu = MenuListController()
        menu.delegate = self
        
        sideMenu = SideMenuNavigationController(rootViewController: menu)
        sideMenu?.leftSide = true
        sideMenu?.setNavigationBarHidden(true, animated: false)
        
        SideMenuManager.default.leftMenuNavigationController = sideMenu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        
        addChillsControllerrs()
    }
    
    func didSelectMenuItem(named: String) {
        sideMenu?.dismiss(animated: true, completion: {
            switch named {
            case "Reglas":
                self.rulesController.view.isHidden = false
                break
            case "Contacto":
                self.showAlert(title: "Contacto", message: "Correo: tizonalc@gmail.com")
                self.rulesController.view.isHidden = true
                break
            case "Créditos":
                self.showAlert(title: "Creditos", message: "Programador: Abraham Luna Cazares\nDiseñador de interfaces: José Ramón Ortega Martínez")
                self.rulesController.view.isHidden = true
                break
            case "Califícanos":
                self.showAlert(title: "Calificanos", message: "Aqui te deberia de mandar a la AppStore")
                self.rulesController.view.isHidden = true
                break
            default:
                break
            }
        })
    }
    
    private func showAlert(title: String, message: String){
        
        // create the alert
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func cartaPressed(_ sender: UIButton) {
        
        self.showToast(message: "Carta Presionada", font: .systemFont(ofSize: 12.0))
    }
    
    @IBAction func didComoPressed(_ sender: UIBarButtonItem) {
        self.showToast(message: "Como jugar presionado", font: .systemFont(ofSize: 12.0))
    }
    
    @IBAction func didSettingsPressed(_ sender: UIBarButtonItem) {
        present(sideMenu!, animated: true)
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    private func addChillsControllerrs(){
        addChild(self.rulesController)
        view.addSubview(rulesController.view)
        rulesController.view.frame = view.bounds
        rulesController.didMove(toParent: self)
        rulesController.view.isHidden = true
    }
}
