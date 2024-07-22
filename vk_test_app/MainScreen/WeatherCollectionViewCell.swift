//
//  WeatherCollectionViewCell.swift
//  vk_test_app
//
//  Created by Алина on 22.07.2024.
//

import Foundation
import UIKit

// MARK: - Constants

private extension CGFloat {
    static let cornerRadius = 10.0
    static let borderWidth = 3.0
}

// MARK: - WeatherCollectionViewCell

final class WeatherCollectionViewCell: UICollectionViewCell {

    // MARK: - UI Component
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupSelf()
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Methods
    
    func configure(with title: String) {
        label.text = title
    }
    
    // MARK: - Private methods
    
    private func setupSelf() {
        self.backgroundColor = UIColor.white
        self.layer.borderWidth = CGFloat.borderWidth
        self.layer.cornerRadius = CGFloat.cornerRadius
        self.layer.borderColor = UIColor.black.cgColor
        setupHierarchy()
    }
    
    private func setupHierarchy() {
        addSubview(label)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        }
    }

