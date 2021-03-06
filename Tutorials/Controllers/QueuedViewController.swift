//
//  QueuedViewController.swift
//  Tutorials
//
//  Created by Marcus on 7/15/20.
//  Copyright © 2020 Marcus. All rights reserved.
//

import UIKit

// TODO:
// leaving in code to display QueuedBadgeView because I want to get it
// working but as of now, I can not get the badges to display correctly
// going to mimic this behavior using a subview on the QueuedCell instead

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
	private lazy var enabledTrashBarButton: UIBarButtonItem = {
		let trash = UIBarButtonItem(image: UIImage(systemName: "trash"),
																style: .plain,
																target: self,
																action: #selector(trashBarButtonPressed))
		return trash
	}()
	private lazy var disabledTrashBarButton: UIBarButtonItem = {
		// pretty cool how we can change tintColor of SFSymbols
		let disabledTrashImage = UIImage(systemName: "trash")?.withTintColor(.darkGray)
		let trash = UIBarButtonItem(image: disabledTrashImage,
																style: .plain,
																target: self,
																action: #selector(trashBarButtonPressed))
		trash.isEnabled = false // default to not enabled
		return trash
	}()
	private var dataSource: UICollectionViewDiffableDataSource<QueuedSection, Tutorial>!
	private lazy var collectionViewDelegate: QueuedCollectionDelegate = {
		let collectionDelegate = QueuedCollectionDelegate()
		collectionDelegate.delegate = self // become delegate
		return collectionDelegate
	}()
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
		applySnapshot() // applying each time view appears
	}
	
	
	// MARK: edit mode
	override func setEditing(_ editing: Bool, animated: Bool) {
		super.setEditing(editing, animated: animated)
		
		// set editing state within our delegate
		collectionViewDelegate.isEditing = editing
		
		// manage trash bar button state
		manageTrashBarButtonState(forIsEditing: editing)

		// update visible cells
		if !collectionView.indexPathsForVisibleItems.isEmpty {
			var snapShot = dataSource.snapshot()
			let visibleTutorials = collectionView.indexPathsForVisibleItems.map { snapShot.itemIdentifiers[$0.row] }
			snapShot.reloadItems(visibleTutorials)
			dataSource.apply(snapShot, animatingDifferences: true, completion: nil)
		}
	}
	
	
	// MARK: bar buttons
	private func configureBarButtons() {
		navigationItem.leftBarButtonItem = editButtonItem
		// default to disabledTrashBarButton
		navigationItem.rightBarButtonItem = disabledTrashBarButton
	}
	private func manageTrashBarButtonState(forIsEditing editing: Bool) {
		// determine when to enable trash bar button item
		let enableTrashBarButton = (editing &&
		collectionView.indexPathsForSelectedItems != nil &&
		!collectionView.indexPathsForSelectedItems!.isEmpty)

		// switching between bar button items in order to get free animation
		navigationItem.setRightBarButton(enableTrashBarButton ? enabledTrashBarButton : disabledTrashBarButton,
																		 animated: true)
		
		// of course - manage actual isEnabled state for whichever button is set
		navigationItem.rightBarButtonItem!.isEnabled = enableTrashBarButton
	}
	@objc private func trashBarButtonPressed(_ sender: UIBarButtonItem) {
		if let selectedIndexPaths = collectionView.indexPathsForSelectedItems,
			 !selectedIndexPaths.isEmpty {
			// get current snapShot
			var snapShot = dataSource.snapshot()
			// get Tutorial objects from selectedIndexPaths
			let deletedTutorials = selectedIndexPaths.map { snapShot.itemIdentifiers[$0.row] }
			// delete Tutorial objects from controller
			controller.deleteQueuedTutorials(deletedTutorials)
			// delete Tutorial objects from collectionView
			snapShot.deleteItems(deletedTutorials)
			dataSource.apply(snapShot, animatingDifferences: true, completion: nil)
			
			// reset isEditing
			isEditing.toggle()
		}
		manageTrashBarButtonState(forIsEditing: isEditing)
	}
	
	
	// MARK: collectionView config
	private func configureCollectionView() {
		collectionView.register(QueuedCell.self, forCellWithReuseIdentifier: QueuedCell.reuseIdentifier)
		collectionView.delegate = collectionViewDelegate
		collectionView.allowsMultipleSelection = true
		collectionView.backgroundColor = .systemBackground
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
			[weak self] (collectionView, indexPath, tutorial) -> UICollectionViewCell? in
			guard let self = self else { return nil } // unpack conditional self
			guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QueuedCell.reuseIdentifier,
																													for: indexPath) as? QueuedCell else { return nil }
			cell.tutorial = tutorial
			cell.hideCheckbox = !self.isEditing
			return cell
		}
	}
	private func applySnapshot() {
		var snapShot = NSDiffableDataSourceSnapshot<QueuedSection, Tutorial>()
		snapShot.appendSections([.main])
		snapShot.appendItems(controller.queuedTutorials)
		dataSource.apply(snapShot, animatingDifferences: true, completion: nil)
	}
	
}


// MARK: collectionView delegate extension
extension QueuedViewController: QueuedSelectionDelegate {
	func didSelectItem(atIndexPath indexPath: IndexPath) {
		// manage trash bar button state
		manageTrashBarButtonState(forIsEditing: isEditing)
	}
	func didDeselectItem(atIndexPath indexPath: IndexPath) {
		// manage trash bar button state
		manageTrashBarButtonState(forIsEditing: isEditing)
	}
}
