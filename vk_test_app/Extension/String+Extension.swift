//
//  String+Extension.swift
//  vk_test_app
//
//  Created by Александр on 21.07.2024.
//

import Foundation

extension String {
    
    var localized: String {
        NSLocalizedString(
            self,
            comment: "\(self) could not be found localized.strings"
        )
    }
}
