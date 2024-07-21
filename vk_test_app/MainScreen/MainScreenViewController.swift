//
//  MainScreenViewController.swift
//  vk_test_app
//
//  Created by Александр on 21.07.2024.
//

import UIKit

// MARK: - Constants

private enum MainScreenStrings {
    static let clear = "for_clear".localized
    static let rain = "for_rain".localized
    static let storm = "for_storm".localized
    static let fog = "for_fog".localized
    static let snow = "for_snow".localized
}

private extension CGFloat {
    static let cornerRadiusForTopCell = 10.0
    static let borderWidth = 2.0
    static let minimumLineSpacing: CGFloat = 12
    static let sectionInset: CGFloat = 12
    static let alphaForCollectionView = 0.7
    static let maxAlpha = 1
    static let duration = 1
}

// MARK: - MainScreenViewController

final class MainScreenViewController: UIViewController {
    
    // MARK: - Properties

    
    private var presenter = MainScreenPresenter()
    
    let weatherButtons: [MainScreenModel] = [
        MainScreenModel(title: MainScreenStrings.clear, type: .clear),
        MainScreenModel(title: MainScreenStrings.rain, type: .rain),
        MainScreenModel(title: MainScreenStrings.storm, type: .storm),
        MainScreenModel(title: MainScreenStrings.fog, type: .fog),
        MainScreenModel(title: MainScreenStrings.snow, type: .snow),
    ]
        
    // MARK: - UI Components
    
    private lazy var topCollectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: self.layoutCollectionView)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        collection.alpha = CGFloat(CGFloat.alphaForCollectionView)
        collection.showsHorizontalScrollIndicator = false
        collection.dataSource = self
        collection.delegate = self
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DefaultCellID")
        return collection
    }()
    
    private lazy var layoutCollectionView: UICollectionViewLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = CGFloat.minimumLineSpacing
        layout.sectionInset = UIEdgeInsets(top: .zero, left: CGFloat.sectionInset, bottom: .zero, right: CGFloat.sectionInset)
        return layout
    }()
    
     lazy var backgroundView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var newBackgroundView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.alpha = .zero
        return imageView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewController = self
        presenter.setUpRandomGifBackground()
        setupView()
        viewHierarchy()
        setuplayout()
    }
    
    // MARK: - Methods
    
    func animateBackgroundTransition(to newImage: UIImage) {
        newBackgroundView.image = newImage
        UIView.animate(withDuration: TimeInterval(CGFloat.duration), animations: {
            self.newBackgroundView.alpha = CGFloat(CGFloat.maxAlpha)
            self.backgroundView.alpha = .zero
        }, completion: { _ in
            self.backgroundView.image = newImage
            self.backgroundView.alpha = CGFloat(CGFloat.maxAlpha)
            self.newBackgroundView.alpha = .zero
        })
    }
    
}

// MARK: - Extension for private methods

private extension MainScreenViewController {
    
    func setupView() {
        view.backgroundColor = .white
    }
    
    func viewHierarchy() {
        view.addSubview(backgroundView)
        view.addSubview(newBackgroundView)
        view.addSubview(topCollectionView)
        
    }
    
    func setuplayout() {
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            newBackgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            newBackgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            newBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            topCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topCollectionView.heightAnchor.constraint(equalToConstant: Constraint.constant78)
        ])
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension MainScreenViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        weatherButtons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCellID", for: indexPath)
        
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = weatherButtons[indexPath.item].title
        
        cell.contentView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: cell.contentView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: Constraint.constant8),
            label.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -Constraint.constant8)
        ])
        
        cell.backgroundColor = .white
        cell.layer.cornerRadius = CGFloat.cornerRadiusForTopCell
        cell.layer.borderWidth = CGFloat.borderWidth
        cell.layer.borderColor = UIColor.black.cgColor
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedButton = weatherButtons[indexPath.item]
        presenter.didTapWeatherButton(type: selectedButton.type)
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MainScreenViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constraint.constant100, height: Constraint.constant50)
    }
}
