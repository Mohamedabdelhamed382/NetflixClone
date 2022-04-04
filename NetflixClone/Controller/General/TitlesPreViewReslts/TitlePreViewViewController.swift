//
//  TitlePreViewViewController.swift
//  NetflixClone
//
//  Created by MOHAMED ABD ELHAMED AHMED on 02/04/2022.
//

import UIKit
import WebKit

class TitlePreViewViewController: UIViewController {
    
    private let webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.text = "harry potter"
        return label
    }()
    
    private let overViewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 0
        label.text = "this is best movie ever to watch as a kide"
        return label
    }()
    
    private let DownloadButton: UIButton =  {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        button.setTitle("Download", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        view.addSubview(titleLabel)
        view.addSubview(overViewLabel)
        view.addSubview(DownloadButton)
        view.backgroundColor = .systemBackground
        configureConstraints()
    }
    
    private func configureConstraints() {
        
        //webViewConstraints
        let webViewConstraints = [
            webView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.heightAnchor.constraint(equalToConstant: 300)
        ]
        
        //titleLabelConstraints
        let titleLabelConstraints = [
            titleLabel.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ]
        
        //overViewLabelConstraints
        let overViewLabelConstraints = [
            overViewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            overViewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            overViewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),

        ]
        
        //DownloadButtonConstraints
        let DownloadButtonConstraints = [
            DownloadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            DownloadButton.topAnchor.constraint(equalTo: overViewLabel.bottomAnchor, constant: 25),
            DownloadButton.widthAnchor.constraint(equalToConstant: 140),
            DownloadButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        //makeConstraintsActive
        NSLayoutConstraint.activate(webViewConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(overViewLabelConstraints)
        NSLayoutConstraint.activate(DownloadButtonConstraints)
    }
    
    func configure(with model: TitlePreviewViewModel) {
        titleLabel.text = model.title
        overViewLabel.text = model.titleOverview
        guard let url = URL(string: "https://www.youtube.com/embed/\(model.youtubeVide.id.videoId)") else {
                   return
               }
        webView.load(URLRequest(url: url))
        print(url)
    }
}
