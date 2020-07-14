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
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		configureCollectionView()
	}
	
	private func configureCollectionView() {
		// passing in standard flow layout for now
		collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.backgroundColor = .purple
		view.addSubview(collectionView)
		
		layoutCollectionView()
	}
	private func layoutCollectionView() {
		collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
		collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
	}
}
