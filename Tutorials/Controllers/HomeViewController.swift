//
//  HomeViewController.swift
//  Tutorials
//
//  Created by Marcus on 7/12/20.
//  Copyright © 2020 Marcus. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
	private var collectionView: UICollectionView!
	private var dataSource: UICollectionViewDiffableDataSource<Topic, Tutorial>!
	private let controller = TutorialsController.shared
	
	
	// MARK: view life cycle methods
	override func viewDidLoad() {
		super.viewDidLoad()
		
		configureCollectionView()
		configureDatasource()
		applySnapshot()
	}
	
	
	// MARK: collectionView configuration
	private func configureCollectionView() {
		// passing in standard flow layout for now
		collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCompositionalLayout())
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.register(TutorialCell.self, forCellWithReuseIdentifier: TutorialCell.reuseIdentifier)
		collectionView.backgroundColor = .black
		view.addSubview(collectionView)
		
		layoutCollectionView()
	}
	private func layoutCollectionView() {
		collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
		collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
	}
	
	
	// MARK: collectionView dependencies configuration
	private func configureCompositionalLayout() -> UICollectionViewCompositionalLayout {
		let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
																					heightDimension: .fractionalHeight(1.0))
		let item = NSCollectionLayoutItem(layoutSize: itemSize)
		item.contentInsets = NSDirectionalEdgeInsets(top: 10.0,
																								 leading: 10.0,
																								 bottom: 10.0,
																								 trailing: 10.0)
		
		let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.6),
																					 heightDimension: .fractionalHeight(0.3))
		let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
																									 subitems: [item])
		
		let section = NSCollectionLayoutSection(group: group)
		section.orthogonalScrollingBehavior = .continuous
		section.contentInsets = NSDirectionalEdgeInsets(top: 10.0,
																										leading: 10.0,
																										bottom: 10.0,
																										trailing: 10.0)
		section.interGroupSpacing = 10.0
		
		return UICollectionViewCompositionalLayout(section: section)
	}
	private func configureDatasource() {
		dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView) {
			(collectionView, indexPath, tutorial) -> UICollectionViewCell? in
			guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TutorialCell.reuseIdentifier,
																													for: indexPath) as? TutorialCell else {
				return nil
			}
			cell.tutorialImageName = tutorial.thumbnail
			cell.tutorialText = tutorial.title
			return cell
		}
	}
	private func applySnapshot() {
		var snapShot = NSDiffableDataSourceSnapshot<Topic, Tutorial>()
		snapShot.appendSections(controller.topics)
		controller.topics.forEach { topic in
			snapShot.appendItems(topic.tutorials, toSection: topic)
		}
		dataSource.apply(snapShot)
	}
}
