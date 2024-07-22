//
//  MainScreenPresenter.swift
//  vk_test_app
//
//  Created by Александр on 21.07.2024.
//

import Foundation
import UIKit

// MARK: - Constants

private enum GifNameStrings {
    static let gifClear = "clear"
    static let gifRain = "rain"
    static let gifStorm = "storm"
    static let gifFog = "fog"
    static let gifSnow = "_snow"
    
    static let allCases = [gifClear, gifRain, gifStorm, gifFog, gifSnow]
}

private enum MainScreenLocalizedStrings {
    static let clear = "for_clear".localized
    static let rain = "for_rain".localized
    static let storm = "for_storm".localized
    static let fog = "for_fog".localized
    static let snow = "for_snow".localized
}

// MARK: - Protocols

protocol MainScreenPresenterProtocol: AnyObject {
    func didTapWeatherButton(type: MainScreenModel.MainScreenType)
}

// MARK: - MainScreenPresenter

final class MainScreenPresenter {
    
    // MARK: - Properties
    
    weak var viewController: MainScreenViewController?
    
    let weatherButtons: [MainScreenModel] = [
        MainScreenModel(title: MainScreenLocalizedStrings.clear, type: .clear),
        MainScreenModel(title: MainScreenLocalizedStrings.rain, type: .rain),
        MainScreenModel(title: MainScreenLocalizedStrings.storm, type: .storm),
        MainScreenModel(title: MainScreenLocalizedStrings.fog, type: .fog),
        MainScreenModel(title: MainScreenLocalizedStrings.snow, type: .snow),
    ]
    
    // MARK: - Methods
        
    private func setUpGifBackground(gifName: String) {
        if let gifImage = UIImage.gifImage(name: gifName) {
            viewController?.animateBackgroundTransition(to: gifImage)
        } else { return }
    }
    
    func setUpRandomGifBackground() {
        let randomGifName = GifNameStrings.allCases.randomElement() ?? GifNameStrings.gifClear
        setUpGifBackground(gifName: randomGifName)
    }
}

// MARK: -  Extension for MainScreenPresenterProtocol

extension MainScreenPresenter: MainScreenPresenterProtocol {
    func didTapWeatherButton(type: MainScreenModel.MainScreenType) {
        switch type {
        case .clear:
            setUpGifBackground(gifName: GifNameStrings.gifClear)
        case .rain:
            setUpGifBackground(gifName: GifNameStrings.gifRain)
        case .storm:
            setUpGifBackground(gifName: GifNameStrings.gifStorm)
        case .fog:
            setUpGifBackground(gifName: GifNameStrings.gifFog)
        case .snow:
            setUpGifBackground(gifName: GifNameStrings.gifSnow)
        }
    }
}
