//
//  MainScreenViewController.swift
//  vk_test_app
//
//  Created by Александр on 21.07.2024.
//

import UIKit

// MARK: - Constants

private enum MainScreenStrings {
    static let idCell = "CollectionViewCellID"
    static let defaultCellID = "DefaultCellID"
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
        
    // MARK: - UI Components
    
    private lazy var weatherCollectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: self.layoutCollectionView)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        collection.alpha = CGFloat(CGFloat.alphaForCollectionView)
        collection.showsHorizontalScrollIndicator = false
        collection.dataSource = self
        collection.delegate = self
        collection.register(WeatherCollectionViewCell.self,
                            forCellWithReuseIdentifier: MainScreenStrings.idCell)
        collection.register(UICollectionViewCell.self,
                            forCellWithReuseIdentifier: MainScreenStrings.defaultCellID)
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
        view.addSubview(weatherCollectionView)
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
            
            weatherCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            weatherCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            weatherCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            weatherCollectionView.heightAnchor.constraint(equalToConstant: Constraint.constant78)
        ])
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension MainScreenViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.weatherButtons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainScreenStrings.idCell, for: indexPath) as? WeatherCollectionViewCell else {
            return UICollectionViewCell()
        }
        let title = presenter.weatherButtons[indexPath.item].title
        cell.configure(with: title)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedButton = presenter.weatherButtons[indexPath.item]
        presenter.didTapWeatherButton(type: selectedButton.type)
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MainScreenViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constraint.constant100, height: Constraint.constant50)
    }
}
