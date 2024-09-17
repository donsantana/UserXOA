//
//  File.swift
//  
//
//  Created by Done Santana on 8/21/24.
//

import Foundation


struct GlobalStrings {
    //Session headers
    static let personalInformationTitle: String = NSLocalizedString("Datos del usuario",comment:"")
    static let profileViewTitle: String = NSLocalizedString("Perfil de usuario",comment:"")
    static let passwordRecoverTitle: String = NSLocalizedString("Recuperar la clave",comment:"")
    static let errorGenericoMessage: String = NSLocalizedString("Ha ocurrido un error en el servidor por favor intentar otra vez.",comment:"")
    //Subheaders
    static let passwordRecoverSubtitle: String = NSLocalizedString("Estimado Cliente: Ingrese el número de teléfono con el cual se registró.",comment:"")
    //static let passwordViewTitle: String = NSLocalizedString("Clave",comment:"")
    //words
    static let passwordTitle: String = NSLocalizedString("Clave",comment:"")
    static let sessionTitle: String = NSLocalizedString("Cuenta",comment:"")

    
    //Alert Strings
    static let removeClientTitle: String = NSLocalizedString("Eliminar usuario",comment:"")
    static let updatePasswordTitle: String = NSLocalizedString("Clave Actualizada",comment:"")
    static let removeClientMessage: String = NSLocalizedString("¿Estás seguro que desea eliminar su cuenta?",comment:"")
    static let profileUpdatedTitle: String = NSLocalizedString("Perfil actualizado",comment:"")
    static let errorTitle: String = NSLocalizedString("Error de perfil",comment:"")
    static let usuarioEliminadoExito: String = NSLocalizedString("Usuario eliminado con éxito.",comment:"")
    static let usuarioEliminadoError: String = NSLocalizedString("El usuario no pudo ser eliminado. Por favor intente otra vez.",comment:"")
    static let missedDataTitle: String = NSLocalizedString("Error en el Formulario",comment:"")
    static let missedDataMessage: String = NSLocalizedString("Por favor, llenar todos los campos del formulario.",comment:"")
    //static let loginAlertTitle: String = NSLocalizedString("Login",comment:"")
    //Buttons
    static let aceptarButtonTitle: String = NSLocalizedString("Aceptar",comment:"")
    static let loginButtonTitle: String = NSLocalizedString("Autenticar",comment:"")
    static let removeButtonTitle: String = NSLocalizedString("Eliminar",comment:"")
    static let cancelarButtonTitle: String = NSLocalizedString("Cancelar",comment:"")
    static let removeClientButtonTitle: String = NSLocalizedString("Eliminar mi cuenta",comment:"")
    static let updateClientButtonTitle: String = NSLocalizedString("Actualizar",comment:"")
    static let recoverPasswordButtonTitle: String = NSLocalizedString("Olvidé mi clave",comment:"")
    static let updatePasswordButtonTitle: String = NSLocalizedString("Cambiar mi clave",comment:"")
    static let logoutButtonTitle: String = NSLocalizedString("Cerrar sesion",comment:"")
    static let cambioClavesTitle: String = NSLocalizedString("Cambio de clave",comment:"")
}
