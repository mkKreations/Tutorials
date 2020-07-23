//
//  HomeViewController.swift
//  Tutorials
//
//  Created by Marcus on 7/12/20.
//  Copyright © 2020 Marcus. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
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
																					collectionViewLayout: configureCompositionalLayout())
	}()
	private var dataSource: UICollectionViewDiffableDataSource<Topic, Tutorial>!
	private let controller = TutorialsController.shared
	lazy var homeTabBarItem: UITabBarItem = {
		UITabBarItem(title: title,
								 image: UIImage(systemName: "book"),
								 selectedImage: UIImage(systemName: "book.fill"))
	}()
	// unique string for our QueuedBadgeView
	private static let queuedBadgeKind: String = String(describing: self) + String(describing: QueuedBadgeView.self)
	
	
	// MARK: view life cycle methods
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// removes view from going under navBar & tabBar
		edgesForExtendedLayout = []
		
		configureCollectionView()
		configureDatasource()
		applySnapshot()
	}
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)

		// reload visible cells to display
		// bookmarked Tutorials or not
		reloadVisibleTutorialCells()
	}
	
	
	// MARK: collectionView configuration
	private func configureCollectionView() {
		// override standard flow layout with our custom one
		collectionView.delegate = self
		collectionView.register(TutorialCell.self,
														forCellWithReuseIdentifier: TutorialCell.reuseIdentifier)
		collectionView.register(TitleHeaderView.self,
														forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
														withReuseIdentifier: TitleHeaderView.reuseIdentifier)
		// check QueuedBadgeView file to see why
		// this supplementary view is being hidden
		collectionView.register(QueuedBadgeView.self,
														forSupplementaryViewOfKind: Self.queuedBadgeKind,
														withReuseIdentifier: QueuedBadgeView.reuseIdentifier)
		collectionView.backgroundColor = .black
		view.addSubview(collectionView)
	}

	
	// MARK: collectionView dependencies configuration
	private func configureCompositionalLayout() -> UICollectionViewCompositionalLayout {
		// queued badge
		let badgeSize = NSCollectionLayoutSize(widthDimension: .estimated(20.0),
																					 heightDimension: .absolute(20.0))
		let badgeAnchor = NSCollectionLayoutAnchor(edges: [.top, .leading],
																							 absoluteOffset: CGPoint(x: 16.0, y: 16.0))
		let badgeView = NSCollectionLayoutSupplementaryItem(layoutSize: badgeSize,
																												elementKind: Self.queuedBadgeKind,
																												containerAnchor: badgeAnchor)

		// item
		let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
																					heightDimension: .fractionalHeight(1.0))
		let item = NSCollectionLayoutItem(layoutSize: itemSize,
																			supplementaryItems: [badgeView])
		item.contentInsets = NSDirectionalEdgeInsets(top: 10.0,
																								 leading: 10.0,
																								 bottom: 10.0,
																								 trailing: 10.0)
		
		// group
		let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.6),
																					 heightDimension: .fractionalHeight(0.3))
		let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
																									 subitems: [item])
		
		// section
		let section = NSCollectionLayoutSection(group: group)
		section.orthogonalScrollingBehavior = .groupPaging
		section.contentInsets = NSDirectionalEdgeInsets(top: 10.0,
																										leading: 10.0,
																										bottom: 10.0,
																										trailing: 10.0)
		section.interGroupSpacing = 10.0
		
		// section header
		let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44.0))
		let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
																																		elementKind: UICollectionView.elementKindSectionHeader,
																																		alignment: .topLeading)
		section.boundarySupplementaryItems = [sectionHeader]
		
		return UICollectionViewCompositionalLayout(section: section)
	}
	private func configureDatasource() {
		// instantiating dataSource as well as configuring reusable cells
		dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView) {
			(collectionView, indexPath, tutorial) -> UICollectionViewCell? in
			guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TutorialCell.reuseIdentifier,
																													for: indexPath) as? TutorialCell else { return nil }
			cell.tutorialImageName = tutorial.thumbnail
			cell.tutorialText = tutorial.title
			cell.tutorialBackgroundColor = tutorial.artworkColor
			cell.isQueued = tutorial.isQueued
			return cell
		}
		
		// configure supplementary views for collectionView
		configureDatasourceSupplementaryViews()
	}
	private func configureDatasourceSupplementaryViews() {
		dataSource.supplementaryViewProvider = { [weak self] // weak self to avoid retain cycles
			collectionView, kind, indexPath -> UICollectionReusableView? in // full closure signature for clarity
			
			// unpack topic with conditional self to pass into helper methods
			// mainly so we don't have to access self within helper methods
			guard let topic = self?.dataSource.snapshot().sectionIdentifiers[indexPath.section] else { return nil }
			
			switch kind {
			case UICollectionView.elementKindSectionHeader: // secion headers
				return self?.configureDatasourceSectionHeaders(collectionView, kind, indexPath, topic)
			case Self.queuedBadgeKind: // badge view
				// check QueuedBadgeView file to see why
				// this supplementary view is being hidden
				return self?.configureDatasourceQueuedBadges(collectionView, kind, indexPath, topic)
			default:
				return nil
			}
		}
	}
	private func configureDatasourceSectionHeaders(_ collectionView: UICollectionView,
																								 _ kind: String,
																								 _ indexPath: IndexPath,
																								 _ topic: Topic) -> UICollectionReusableView? {
		// get our headerView of TitleHeaderView type
		guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
																																					 withReuseIdentifier: TitleHeaderView.reuseIdentifier,
																																					 for: indexPath) as? TitleHeaderView else { return nil }
		headerView.displayText = topic.title // set values on headerView
		return headerView
	}
	private func configureDatasourceQueuedBadges(_ collectionView: UICollectionView,
																							 _ kind: String,
																							 _ indexPath: IndexPath,
																							 _ topic: Topic) -> UICollectionReusableView? {
		// dequeue reusable QueuedBadgeView
		guard let badgeView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
																																					withReuseIdentifier: QueuedBadgeView.reuseIdentifier,
																																					for: indexPath) as? QueuedBadgeView else { return nil }
				
		// get tutorial
		let tutorial = topic.tutorials[indexPath.row]
		
		// set values on badgeView
		badgeView.isQueued = tutorial.isQueued
		
		return badgeView
	}
	private func applySnapshot() {
		var snapShot = NSDiffableDataSourceSnapshot<Topic, Tutorial>()
		snapShot.appendSections(controller.topics)
		controller.topics.forEach { topic in
			snapShot.appendItems(topic.tutorials, toSection: topic)
		}
		// animate changes
		dataSource.apply(snapShot, animatingDifferences: true, completion: nil)
	}
	private func reloadVisibleTutorialCells() {
		let visibleTutorials: [Tutorial] = collectionView.indexPathsForVisibleItems.map { visibleIndexPath in
			let topic = dataSource.snapshot().sectionIdentifiers[visibleIndexPath.section]
			return topic.tutorials[visibleIndexPath.row]
		}
		var snapShot = dataSource.snapshot()
		snapShot.reloadItems(visibleTutorials)
		dataSource.apply(snapShot, animatingDifferences: true, completion: nil)
	}
}


// MARK: UICollectionViewDelegate conformance
extension HomeViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		// get selectedTutorial
		guard let selectedTutorial = dataSource.itemIdentifier(for: indexPath) else { return }
		let detailVC = TutorialDetailViewController()
		detailVC.delegate = self // conformance to delegate
		detailVC.tutorial = selectedTutorial
		navigationController?.pushViewController(detailVC, animated: true)
	}
}


// MARK: QueuedTutorialDelegate conformance
extension HomeViewController: QueuedTutorialDelegate {
	func queuedButtonPressed(forTutorial tutorial: Tutorial) {
		// pass tutorial onto controller
		controller.queueTutorial(tutorial)
	}
}
