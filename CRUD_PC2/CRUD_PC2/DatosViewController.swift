//
//  DatosViewController.swift
//  CRUD_PC2
//
//  Created by DAMII on 24/10/23.
//

import UIKit

class DatosViewController: UIViewController {
    
    @IBOutlet weak var txtCodigo: UITextField!
    @IBOutlet weak var txtNombre: UITextField!
    @IBOutlet weak var txtApellido: UITextField!
    @IBOutlet weak var txtNumero: UITextField!
    
    
    @IBOutlet weak var txtOperador: UITextField!
    
    //declarar variables de tipo cliente
    var bean:ClienteEntity!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtCodigo.text=String(bean.codigo)
        txtNombre.text=bean.nombre
        txtApellido.text=bean.apellido
        txtNumero.text=bean.numero
        
        txtOperador.text=bean.operador
    
    }
    
    
    @IBAction func btnActualizar(_ sender: UIButton) {
        let cod=Int16(txtCodigo.text ?? "0") ?? 0
        let nom=txtNombre.text ?? ""
        let ape=txtApellido.text ?? ""
        let num=txtNumero.text ?? ""
        
        //para actualizar el combo
        let ope = txtOperador.text ?? ""
        
        //setear objeto bean
        bean.codigo=Int16(cod)
        bean.nombre=nom
        bean.apellido=ape
        bean.numero=num
        bean.operador=ope
        
        //invocar metodo
        ControladorCliente().actualizarCliente(bean:bean)
    }
    
    @IBAction func btnEliminar(_ sender: UIButton) {
        let ventana = UIAlertController(title: "Sistema",
                                        message: "seguro de eliminar?",
                                        preferredStyle: .alert)
        
        let botonAceptar = UIAlertAction(title: "SI",
                                         style: .default, handler: {
            action in
            ControladorCliente().eliminarCliente(bean: self.bean)
        })
        ventana.addAction(UIAlertAction(title: "NO", style: .cancel))
        ventana.addAction(botonAceptar)
        present(ventana, animated: true)
    }
    
}

