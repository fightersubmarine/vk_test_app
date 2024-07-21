//
//  MainScreenModel.swift
//  vk_test_app
//
//  Created by Александр on 21.07.2024.
//

import Foundation

struct MainScreenModel {
    let title: String
    let type: MainScreenType
    
    enum MainScreenType: Int {
        case clear 
        case rain
        case storm
        case fog
        case snow
    }
}
