//
//  ControladorCliente.swift
//  CRUD_PC2
//
//  Created by DAMII on 24/10/23.
//

import UIKit

class ControladorCliente: NSObject {

    //metodo para registrar cliente
    func registraCliente(bean:Cliente){

        //validacion de registro: los valores son obligatorios
         guard !bean.nombre.isEmpty,
              !bean.apellido.isEmpty,
              !bean.numero.isEmpty,
              !bean.operador.isEmpty else {
            
            return NotificationCenter.default.post(name: Notification.Name("RegistroInvalido"), object: nil)
        }

        //PASO 1:objeto de la clase AppDelegate
        let delegate=UIApplication.shared.delegate as! AppDelegate
        //PASO 2:acceder a la conexion de la base de datos
        let contextoBD=delegate.persistentContainer.viewContext
        //PASO 3:establecer tablas
        let tabla=ClienteEntity(context: contextoBD)
        //PASO 4:asignar valor a los atributos del objeto tabla
        tabla.codigo=Int16(bean.codigo)
        tabla.nombre=bean.nombre
        tabla.apellido=bean.apellido
        tabla.numero=bean.numero
        tabla.operador=bean.operador
        //PASO 5:controlar exeption
        do {
            //PASO 6:grabar
            try contextoBD.save()
            print("Cliente Registrado")

            // Enviar una notificación de registro exitoso
            NotificationCenter.default.post(name: Notification.Name("RegistroExitoso"), object: nil)
        }catch let ex as NSError{
            print(ex.localizedDescription)
        }
    }

    //funcion que retornar un arreglo de tipo ClienteEntity
    func listarCliente()->[ClienteEntity]{
        //declarar
        var datos:[ClienteEntity]!
        //PASO 1:objeto de la clase AppDelegate
        let delegate=UIApplication.shared.delegate as! AppDelegate
        //PASO 2:acceder a la conexion de la base de datos
        let contextoBD=delegate.persistentContainer.viewContext
        //PASO 3:controlar exeption
        do {
            //PASO 4:obtener contenido de ClienteEntity
            let registros=ClienteEntity.fetchRequest()
            //PASO 5:leer filas del objeto registros y guardar en "datos"
            datos=try contextoBD.fetch(registros)
        }catch let ex as NSError {
            print(ex.localizedDescription)
        }
        return datos
    }

    //metodo para actualizar cliente
    func actualizarCliente(bean:ClienteEntity){
        //PASO 1:objeto de la clase AppDelegate
        let delegate=UIApplication.shared.delegate as! AppDelegate
        //PASO 2:acceder a la conexion de la base de datos
        let contextoBD=delegate.persistentContainer.viewContext
        
        do {
            //PASO 6:grabar
            try contextoBD.save()
            print("Cliente Actualizado")

            // Enviar una notificación de actualización exitosa
            NotificationCenter.default.post(name: Notification.Name("ActualizacionExitosa"), object: nil)
        }catch let ex as NSError{
            print(ex.localizedDescription)
        }
    }

    //metodo para eliminar cliente
    func eliminarCliente(bean:ClienteEntity){
        //PASO 1:objeto de la clase AppDelegate
        let delegate=UIApplication.shared.delegate as! AppDelegate
        //PASO 2:acceder a la conexion de la base de datos
        let contextoBD=delegate.persistentContainer.viewContext
        
        do {
            contextoBD.delete(bean)
            //PASO 6:grabar
            try contextoBD.save()
            print("Cliente Eliminado")
        }catch let ex as NSError{
            print(ex.localizedDescription)
        }
    }

    //funcion para buscar por un nombre
    func buscaCliente(nom:String)->[ClienteEntity]{
        //declarar
        var datos:[ClienteEntity]!
        //PASO 1:objeto de la clase AppDelegate
        let delegate=UIApplication.shared.delegate as! AppDelegate
        //PASO 2:acceder a la conexion de la base de datos
        let contextoBD=delegate.persistentContainer.viewContext
        //PASO 3:controlar exeption
        do {
            //PASO 4:obtener contenido de ClienteEntity
            let registros=ClienteEntity.fetchRequest()
            //PASO 5: FILTRAR
            let predicate=NSPredicate(format: "nombre BEGINSWITH[c] %@", nom)
            //PASO 6: Enviar filtro
            registros.predicate=predicate
            //PASO 7:leer filas del objeto registros y guardar en "datos"
            datos=try contextoBD.fetch(registros)
        }catch let ex as NSError {
            print(ex.localizedDescription)
        }
        return datos
    }

}
