//
//  ControladorCliente.swift
//  CRUD_PC2
//
//  Created by DAMII on 23/10/23.
//

import UIKit

class ControladorCliente: NSObject {
    
    func registraCliente(bean:Cliente){
        let delegate=UIApplication.shared.delegate as! AppDelegate
        let contextoBD=delegate.persistentContainer.viewContext
        let tabla=ClienteEntity(context: contextoBD)
        
        tabla.codigo=Int16(bean.codigo)
        tabla.nombre=bean.nombre
        tabla.apellido=bean.apellido
        tabla.numero=bean.numero
        tabla.operador=bean.operador
        
        do {
            try contextoBD.save()
            print("Cliente Registrado")
        }catch let ex as NSError{
            print(ex.localizedDescription)
        }
    }
}
