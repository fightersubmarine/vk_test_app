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
    static let clear = "clear"
    static let rain = "rain"
    static let storm = "storm"
    static let fog = "fog"
    static let snow = "_snow"
    
    static let allCases = [clear, rain, storm, fog, snow]
}

// MARK: - Protocols

protocol MainScreenPresenterProtocol: AnyObject {
    func didTapWeatherButton(type: MainScreenModel.MainScreenType)
}

// MARK: - MainScreenPresenter

final class MainScreenPresenter {
    
    // MARK: - Properties
    
    weak var viewController: MainScreenViewController?
    
    // MARK: - Methods
        
    private func setUpGifBackground(gifName: String) {
        if let gifImage = UIImage.gifImage(name: gifName) {
            viewController?.animateBackgroundTransition(to: gifImage)
        } else {
            return
        }
    }
    
    func setUpRandomGifBackground() {
        let randomGifName = GifNameStrings.allCases.randomElement() ?? GifNameStrings.clear
        setUpGifBackground(gifName: randomGifName)
    }
}

// MARK: -  Extension for MainScreenPresenterProtocol

extension MainScreenPresenter: MainScreenPresenterProtocol {
    func didTapWeatherButton(type: MainScreenModel.MainScreenType) {
        switch type {
        case .clear:
            setUpGifBackground(gifName: GifNameStrings.clear)
        case .rain:
            setUpGifBackground(gifName: GifNameStrings.rain)
        case .storm:
            setUpGifBackground(gifName: GifNameStrings.storm)
        case .fog:
            setUpGifBackground(gifName: GifNameStrings.fog)
        case .snow:
            setUpGifBackground(gifName: GifNameStrings.snow) 
        }
    }
}
