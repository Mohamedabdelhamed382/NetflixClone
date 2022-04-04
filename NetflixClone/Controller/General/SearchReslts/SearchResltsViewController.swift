//
//  SearchResltsViewController.swift
//  NetflixClone
//
//  Created by MOHAMED ABD ELHAMED AHMED on 01/04/2022.
//

import UIKit
protocol SearchResltsViewControllerDelegate: AnyObject {
    func searchResltsViewControllerDidTapItem(_ viewModel: TitlePreviewViewModel)
}

class SearchResltsViewController: UIViewController {
    public weak var delegate: SearchResltsViewControllerDelegate?
    public var titles:[Titles] = [Titles]()
    public let searchResltscollectionview: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 10 , height: 200)
        layout.minimumInteritemSpacing = 0
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        searchResltscollectionview.delegate = self
        searchResltscollectionview.dataSource = self
        view.addSubview(searchResltscollectionview)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.searchResltscollectionview.frame = view.bounds
    }
    
}
extension SearchResltsViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = searchResltscollectionview.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else { return TitleCollectionViewCell() }
        let title = titles[indexPath.row]
        cell.configure(with: title.posterPath ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let title = titles[indexPath.row]
        let titleName = title.originalTitle ?? ""
        APICaller.shared.getMovie(with: titleName + "trailer") { [weak self] result in
            switch result {
            case .success(let videoElement):
                self?.delegate?.searchResltsViewControllerDidTapItem(TitlePreviewViewModel(title: title.originalTitle ?? "", youtubeVide: videoElement, titleOverview: title.overview ?? ""))
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
