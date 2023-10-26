//
//  ViewController.swift
//  CRUD_PC2
//
//  Created by DAMII on 23/10/23.
//

import UIKit
import DropDown
import Toaster

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate  {
    
    //PRUEBA
    //UIRefresh para refrescar la ventana
    let refreshControl = UIRefreshControl()

    //constante para el combo
    let dropDown=DropDown()
    var operadorSeleccionado: String?

    //Buscar por nombre
    @IBOutlet weak var txtNombre: UITextField!
    
    @IBOutlet weak var tvClientes: UITableView!
    
    //arreglo de tipo Cliente
    var listaClientes:[ClienteEntity]=[]
    
    var pos = -1
    
    //Aplicando UIRefresh a viewdidload
    override func viewDidLoad() {
        super.viewDidLoad()

        listaClientes=ControladorCliente().listarCliente()

        //Configuracion del UIRefresh
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tvClientes.addSubview(refreshControl)
        
        // Suscribirse a la notificación de registro exitoso
        NotificationCenter.default.addObserver(self, selector: #selector(registroInvalido), name: Notification.Name("RegistroInvalido"), object: nil)

        // Suscribirse a la notificación de registro exitoso
        NotificationCenter.default.addObserver(self, selector: #selector(registroExitoso), name: Notification.Name("RegistroExitoso"), object: nil)
        // Suscribirse a la notificación de actualización exitosa
        NotificationCenter.default.addObserver(self, selector: #selector(actualizacionExitosa), name: Notification.Name("ActualizacionExitosa"), object: nil)
    
        //enviar origen de datos al atributo tvClientes
        tvClientes.dataSource=self
        tvClientes.delegate=self
        tvClientes.rowHeight=150

    }
    
    @objc func registroInvalido() {
    // Mostrar un mensaje de actualización exitosa, por ejemplo, utilizando Toast
    Toast(text: "Los campos estan vacios").show()
    
    // Recargar la lista de clientes
    listaClientes = ControladorCliente().listarCliente()
    tvClientes.reloadData()
    }
    
    @objc func actualizacionExitosa() {
    // Mostrar un mensaje de actualización exitosa, por ejemplo, utilizando Toast
    Toast(text: "Actualización exitosa").show()
    
    // Recargar la lista de clientes
    listaClientes = ControladorCliente().listarCliente()
    tvClientes.reloadData()
    }

    @objc func registroExitoso() {
    // Mostrar un mensaje de registro exitoso, por ejemplo, utilizando Toast
    Toast(text: "Registro exitoso").show()
    
    // Recargar la lista de clientes
    listaClientes = ControladorCliente().listarCliente()
    tvClientes.reloadData()
    }
    
    @objc func refreshData() {
    // Coloca aquí la lógica para recargar tus datos
    listaClientes = ControladorCliente().listarCliente()
    
    // Una vez que los datos se han actualizado, detén el refreshControl
    refreshControl.endRefreshing()
    
    // Actualiza la tabla
    tvClientes.reloadData()
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaClientes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //crear objeto de la clase ItemTableView, usar la celda de la tabla "elemento"
        let row=tvClientes.dequeueReusableCell(withIdentifier: "elemento") as! ItemTableViewCell
        //asignar valores
        //row.lblCodigo.text=String(listaClientes[indexPath.row].codigo)
        row.lblNombre.text=listaClientes[indexPath.row].nombre
        row.lblApellido.text=listaClientes[indexPath.row].apellido
        row.lblNumero.text=listaClientes[indexPath.row].numero
        //row.lblNumero.text=String(listaClientes[indexPath.row].numero)
        row.lblOperador.text=listaClientes[indexPath.row].operador
        return row
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        pos=indexPath.row
        //invocar al segue "datos" datos es el identificador que le pusimos a la flecha
        //que unia el viewcontroller con el datos o detallecontroller
        performSegue(withIdentifier: "datos", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="datos"{
            //crear objeto de la clase DatosViewController
            //trabajar con el segue "datos"
            let row=segue.destination as! DatosViewController
            //acceder a bean
            row.bean=listaClientes[pos]
        }
    }

    //Funcion del boton Nuevo
    @IBAction func btnNuevo(_ sender: UIButton) {
        performSegue(withIdentifier: "nuevo", sender: nil)
    }
    
    //Funcion del boton buscar por nombre
    @IBAction func btnBuscar(_ sender: UIButton) {
        let nombre=txtNombre.text ?? ""
        listaClientes=ControladorCliente().buscaCliente(nom: nombre)
        //refrescar tabla
        tvClientes.reloadData()
    }
    
}
