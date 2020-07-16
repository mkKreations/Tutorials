//
//  TutorialDetailViewController.swift
//  Tutorials
//
//  Created by Marcus on 7/14/20.
//  Copyright © 2020 Marcus. All rights reserved.
//

import UIKit

class TutorialDetailViewController: UIViewController {
	// MARK: dependencies
	var tutorial: Tutorial! {
		didSet {
			topView.tutorialImageView.image = UIImage(named: tutorial.thumbnail)
			topView.tutorialTitleLabel.text = tutorial.title
			topView.tutorialPublishLabel.text = tutorial.publishDate.formattedPublishDateString
			topView.tutorialBackgroundView.backgroundColor = UIColor(hexString: tutorial.artworkColor)
		}
	}
	
	
	// MARK: subview properties
	private let topView = TutorialDetailTopView(frame: .zero)
	// passing in default collectionViewLayout for instantiation
	private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
	private var dataSource: UICollectionViewDiffableDataSource<Section, Video>!
	
	
	// MARK: view life cycle methods
	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = tutorial.title
		navigationController?.navigationBar.prefersLargeTitles = false

		view.backgroundColor = .black
		
		edgesForExtendedLayout = []
		
		configureTutorialSubviews()
		layoutTutorialSubviews()
		configureDatasource()
		applySnapshot()
	}
	
	
	// MARK: actions
	@objc private func queueButtonPressed(_ sender: UIButton) {
		// update model
		tutorial.isQueued.toggle()
		
		// determine buttonTitle for model state
		let buttonTitle = self.tutorial.isQueued ? "Remove from Queue" : "Add to Queue"
		
		// animate button title change with withoutAnimation closure
		// with a system button this animation works well
		UIView.performWithoutAnimation {
			topView.tutorialQueueButton.setTitle(buttonTitle, for: .normal)
			topView.tutorialQueueButton.layoutIfNeeded()
		}
	}
	
	
	// MARK: view configuration
	private func configureTutorialSubviews() {
		topView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(topView)
		
		// become target for queue button
		topView.tutorialQueueButton.addTarget(self, action: #selector(queueButtonPressed), for: .touchUpInside)
		
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.backgroundColor = .black
		collectionView.register(VideoCell.self, forCellWithReuseIdentifier: VideoCell.reuseIdentifier)
		collectionView.register(TitleHeaderView.self,
														forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
														withReuseIdentifier: TitleHeaderView.reuseIdentifier)
		collectionView.setCollectionViewLayout(configureCollectionViewLayout(), animated: false)
		view.addSubview(collectionView)
	}
	private func layoutTutorialSubviews() {
		topView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		topView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		topView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

		collectionView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 16.0).isActive = true
		collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 6.0).isActive = true
		collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -6.0).isActive = true
		collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 6.0).isActive = true
	}
	
	
	// MARK: collectionView config
	private func configureCollectionViewLayout() -> UICollectionViewCompositionalLayout {
		let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
																					heightDimension: .fractionalHeight(1.0))
		let item = NSCollectionLayoutItem(layoutSize: itemSize)
		
		let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
																					 heightDimension: .absolute(44.0))
		let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
																								 subitems: [item])
		
		let section = NSCollectionLayoutSection(group: group)
		section.contentInsets = NSDirectionalEdgeInsets(top: 10.0,
																										leading: 10.0,
																										bottom: 20.0,
																										trailing: 10.0)

		// header logic
		let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
																						heightDimension: .estimated(44.0))
		let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
																																		elementKind: UICollectionView.elementKindSectionHeader,
																																		alignment: .topLeading)
		section.boundarySupplementaryItems = [sectionHeader]
		
		return UICollectionViewCompositionalLayout(section: section)
	}
	private func configureDatasource() {
		dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView) {
			(collectionView, indexPath, video) -> UICollectionViewCell? in
			guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoCell.reuseIdentifier,
																													for: indexPath) as? VideoCell else { return nil }
			cell.displayText = video.title
			return cell
		}
		
		// adding logic to dataSource for section headers
		configureDatasourceSectionHeaders()
	}
	private func configureDatasourceSectionHeaders() {
		dataSource.supplementaryViewProvider = { [weak self] // weak self to avoid retain cycles
			collectionView, kind, indexPath in
			// only expecting section headers
			guard kind == UICollectionView.elementKindSectionHeader else { return nil }
			
			// get our headerView of TitleHeaderView type
			guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
																																						 withReuseIdentifier: TitleHeaderView.reuseIdentifier,
																																						 for: indexPath) as? TitleHeaderView else { return nil }
			
			// get our current section using indexPath
			guard let section = self?.dataSource.snapshot().sectionIdentifiers[indexPath.section] else { return nil }
			
			// set values on headerView
			headerView.displayText = section.title
			
			return headerView
		}
	}
	private func applySnapshot() {
		var snapShot = NSDiffableDataSourceSnapshot<Section, Video>()
		let sections = tutorial.content // get our Section collection from Tutorial
		snapShot.appendSections(sections)
		sections.forEach { section in
			snapShot.appendItems(section.videos, toSection: section)
		}
		dataSource.apply(snapShot)
	}
}
