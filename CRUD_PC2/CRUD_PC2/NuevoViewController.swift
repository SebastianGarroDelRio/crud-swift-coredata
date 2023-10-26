//
//  NuevoViewController.swift
//  CRUD_PC2
//
//  Created by DAMII on 23/10/23.
//

import UIKit
import DropDown

class NuevoViewController: UIViewController {
    
    @IBOutlet weak var txtCodigo: UITextField!
    @IBOutlet weak var txtNombre: UITextField!
    @IBOutlet weak var txtApellido: UITextField!
    @IBOutlet weak var txtNumero: UITextField!

    //Por si no sale con Dropdown
    //@IBOutlet weak var txtOperador: UITextField!
    
    let operadores = ["Movistar", "Claro", "Entel"]
    // Instancia de DropDown
    let dropDown = DropDown()

    
    @IBOutlet weak var cboOperador: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //parte del combo
        setupDropDown()
        
    }

    //Funcion del combo
    func setupDropDown() {
        dropDown.anchorView = cboOperador
        dropDown.dataSource = operadores
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            cboOperador.setTitle(item, for: .normal)
        }
    }

    //Funcion del boton combo
    @IBAction func btnCombo(_ sender: UIButton) {
        //vincular el objeto dropdown con el boton
        dropDown.anchorView = sender
        //mancho de la lista
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        //mostrar lista
        dropDown.show()
        //evento cuando se selecciona un operador
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
        print("Selected item: \(item) at index: \(index)")
        sender.setTitle(item, for: .normal)
        }
        
    }

    @IBAction func btnGrabar(_ sender: UIButton) {
        let cod=Int16(txtCodigo.text ?? "0") ?? 0
        let nom=txtNombre.text ?? ""
        let ape=txtApellido.text ?? ""
        let num=txtNumero.text ?? ""
    //let ope=txtOperador.text ?? ""


        let ope = cboOperador.title(for: .normal) ?? "" // Obtén el operador seleccionado

        
        //variable de tipo cliente
        let objCiente=Cliente(codigo: cod, nombre: nom, apellido: ape, numero: num, operador: ope)
    //let objCiente=Cliente(codigo: cod, nombre: nom, apellido: ape, numero: num, operador: ope)
        
        ControladorCliente().registraCliente(bean:objCiente)
        
    }
    
}
