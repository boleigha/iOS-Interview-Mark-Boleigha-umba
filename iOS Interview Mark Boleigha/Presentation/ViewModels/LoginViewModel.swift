//
//  LoginViewModel.swift
//  iOS Interview Mark Boleigha
//
//  Created by Mark Boleigha on 17/01/2022.
//

import Foundation

class LoginViewModel {
    var req_token: String?
    
    func login_guest(callback: @escaping (Bool) -> Void) {
        let request = NetworkRequest(endpoint: .auth(.guest_login), method: .get, encoding: .url, body: [:])
        HTTP.shared.request(request) { (response, _ data: GuestSessionResponse?) in
            
            switch response {
            case .failed(_):
                callback(false)
            case .success:
                guard let data = data else {
                    callback(false)
                    return
                }
                AppDelegate.shared.keystore.set(data.guest_session_id, forKey: "sess_id")
                callback(true)
            }
        }
        
    }
}
