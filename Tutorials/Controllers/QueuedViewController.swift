//
//  QueuedViewController.swift
//  Tutorials
//
//  Created by Marcus on 7/15/20.
//  Copyright © 2020 Marcus. All rights reserved.
//

import UIKit

class QueuedViewController: UIViewController {
	// MARK: stored properties
	private var collectionView: UICollectionView!
	private var dataSource: UICollectionViewDiffableDataSource<QueuedSection, Tutorial>!
	private let controller = TutorialsController.shared
	lazy var queuedTabBarItem: UITabBarItem = {
		UITabBarItem(title: title,
								 image: UIImage(systemName: "bookmark"),
								 selectedImage: UIImage(systemName: "bookmark.fill"))
	}()
	
	
	// MARK: nested enum to represent collectionView sections
	enum QueuedSection {
		case main
	}
	
	
	// MARK: view life cycle methods
	override func viewDidLoad() {
		super.viewDidLoad()
		
		configureCollectionView()
		configureDatasource()
	}
	
	
	// MARK: collectionView config
	private func configureCollectionView() {
		collectionView = UICollectionView(frame: .zero,
																			collectionViewLayout: configureCollectionViewLayout())
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.register(QueuedCell.self, forCellWithReuseIdentifier: QueuedCell.reuseIdentifier)
		view.addSubview(collectionView)
		
		layoutCollectionView()
	}
	private func layoutCollectionView() {
		collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
		collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
	}
	
	
	// MARK: collectionView dependencies config
	private func configureCollectionViewLayout() -> UICollectionViewCompositionalLayout {
		let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
																					heightDimension: .fractionalHeight(1.0))
		let item = NSCollectionLayoutItem(layoutSize: itemSize)
		item.contentInsets = NSDirectionalEdgeInsets(top: 10.0,
																								 leading: 10.0,
																								 bottom: 10.0,
																								 trailing: 10.0)

		let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
																					 heightDimension: .absolute(148.0))
		let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
																									 subitems: [item])
		
		let section = NSCollectionLayoutSection(group: group)
		
		return UICollectionViewCompositionalLayout(section: section)
	}
	private func configureDatasource() {
		dataSource = UICollectionViewDiffableDataSource<QueuedSection, Tutorial>(collectionView: collectionView) {
			(collectionView, indexPath, tutorial) -> UICollectionViewCell? in
			guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QueuedCell.reuseIdentifier,
																													for: indexPath) as? QueuedCell else { return nil }
			cell.tutorial = tutorial
			return cell
		}
	}
}
