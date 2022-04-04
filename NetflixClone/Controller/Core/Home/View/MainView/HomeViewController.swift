//
//  HomeViewController.swift
//  NetflixClone
//
//  Created by MOHAMED ABD ELHAMED AHMED on 20/02/2022.
//

import UIKit

enum section:Int {
    case getTrendingMovies = 0
    case getTrendingTvs = 1
    case getPopularMovies = 2
    case getUpcomingMovies = 3
    case getTopRatedvMovies = 4
    
}

class HomeViewController: UIViewController {
    
    //MARK:- variabls
    private var randomTrendingMovies: Titles?
    private var headerView: HeroHeaderUIView?
    let sectionTitle = ["Trending Movies", "Trending Tv", "Popular", "Upcoming Movies", "Top rated"]
    let homeFeedTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionTableViewCell.self, forCellReuseIdentifier: CollectionTableViewCell.identifier )
        return table
    }()
    
    //MARK:- lifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(homeFeedTable)
        configure()
        configurNavbar()
        headerView = HeroHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
        homeFeedTable.tableHeaderView = headerView
        configureHeroHeaderView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    }
}

extension HomeViewController {
    
    private func configureHeroHeaderView() {
        APICaller.shared.getTrendingTvs { [weak self] result in
            switch result {
            case .success(let titles):
                let selectedTitles = titles.randomElement()
                self?.randomTrendingMovies = selectedTitles
                self?.headerView?.configure(with: TitleViewModel(titleName: selectedTitles?.originalTitle ?? "", posterURl: selectedTitles?.posterPath ?? "" ))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func configurNavbar() {
        
        var image = UIImage(named: "netflixLogo")
        image = image?.withRenderingMode(.alwaysOriginal)
        
        navigationItem.leftBarButtonItem =
        UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
        ]
        
        navigationController?.navigationBar.tintColor = .white
        
    }
    
    
}

extension HomeViewController : CollectionTableViewCellDelegate {
    func collectionTableViewCellDidTapCell(_ cell: CollectionTableViewCell  , viewModel: TitlePreviewViewModel) {
        DispatchQueue.main.async { [weak self] in
            let vc  = TitlePreViewViewController()
            vc.configure(with: viewModel)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
