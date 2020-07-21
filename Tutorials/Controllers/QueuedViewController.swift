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
	private lazy var collectionView: UICollectionView = {
		let statusBarHeight: CGFloat = 20.0 // not using windowScene and UIApplication.shared.statusBarFrame is deprecated iOS13
		let viewHeight: CGFloat = view.frame.size.height
		let navBarHeight: CGFloat = navigationController!.navigationBar.frame.size.height
		let tabBarHeight: CGFloat = tabBarController!.tabBar.frame.size.height
		// using frames because autoLayout resizes collectionView
		// cells when overriding edgesForExtendedLayout in viewDidLoad
		return UICollectionView(frame: CGRect(x: view.frame.minX,
																					y: view.frame.minY,
																					width: view.frame.size.width,
																					height: viewHeight - (statusBarHeight + navBarHeight + tabBarHeight)),
																					collectionViewLayout: configureCollectionViewLayout())
	}()
	private lazy var trashBarButton: UIBarButtonItem = {
		let trash = UIBarButtonItem(image: UIImage(systemName: "trash"),
																style: .plain,
																target: self,
																action: #selector(trashBarButtonPressed))
		trash.isEnabled = false // default to not enabled
		return trash
	}()
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
		
		// removes view from going under navBar & tabBar
		edgesForExtendedLayout = []
		
		configureBarButtons()
		configureCollectionView()
		configureDatasource()
	}
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		applySnapshot() // this applies the snapShot
	}
	
	override func setEditing(_ editing: Bool, animated: Bool) {
		super.setEditing(editing, animated: animated)
		
		// manage trashBarButton enabled state
		trashBarButton.isEnabled = (isEditing && collectionView.indexPathsForSelectedItems != nil)
	}
	
	// MARK: bar buttons
	private func configureBarButtons() {
		navigationItem.leftBarButtonItem = editButtonItem
		navigationItem.rightBarButtonItem = trashBarButton
	}
	@objc private func trashBarButtonPressed(_ sender: UIBarButtonItem) {
		print("Trash bar button pressed")
	}
	
	
	// MARK: collectionView config
	private func configureCollectionView() {
		// override standard flow layout with our custom one
		collectionView.register(QueuedCell.self, forCellWithReuseIdentifier: QueuedCell.reuseIdentifier)
		collectionView.backgroundColor = .black
		view.addSubview(collectionView)
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
	private func applySnapshot() {
		var snapShot = NSDiffableDataSourceSnapshot<QueuedSection, Tutorial>()
		snapShot.appendSections([.main])
		snapShot.appendItems(controller.queuedTutorials) // not actual data - sample data for now
		dataSource.apply(snapShot, animatingDifferences: true, completion: nil)
	}
}
