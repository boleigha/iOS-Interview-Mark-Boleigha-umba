//
//  SessionResponse.swift
//  iOS Interview Mark Boleigha
//
//  Created by Mark Boleigha on 17/01/2022.
//  Copyright © 2022 Umba. All rights reserved.
//

import Foundation

struct GuestSessionResponse: Codable{
  var success: Bool
  var guest_session_id: String //"1ce82ec1223641636ad4a60b07de3581",
  let expires_at: String //"2016-08-27 16:26:40 UTC"
}
