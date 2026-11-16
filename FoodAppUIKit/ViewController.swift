//
//  ViewController.swift
//  FoodAppUIKit
//
//  Created by Maria Fernanda Braga Queiroz on 11/11/26.
//

import UIKit

class ViewController: UIViewController {
    
    private let rectangleView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "backgroundColor")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    public func makeGlassButton(
        configuration: UIButton.Configuration,
        systemImageName: String? = nil,
        contentInsets: NSDirectionalEdgeInsets = .init(
            top: 12,
            leading: 12,
            bottom: 12,
            trailing: 12
        )
    ) -> UIButton {
        var configuration = configuration

        configuration.contentInsets = contentInsets

        if let systemImageName {
            configuration.image = UIImage(systemName: systemImageName)
        }

        let button = UIButton(configuration: configuration)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }

//    private let colorButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("Color Rectangle", for: .normal)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupViews()
        setupConstraints()
        setupActions()

    }

    private func setupViews() {
        view.addSubview(rectangleView)
        view.addSubview(colorButton)
    }

    private func setupConstraints() {
//        let safeArea = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            rectangleView.topAnchor.constraint(equalTo: view.topAnchor),
            rectangleView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            rectangleView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            rectangleView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            rectangleView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            rectangleView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            rectangleView.widthAnchor.constraint(equalToConstant: 70),
//            rectangleView.heightAnchor.constraint(equalToConstant: 70),
            colorButton.centerXAnchor.constraint(equalTo: rectangleView.centerXAnchor),
            colorButton.centerYAnchor.constraint(equalTo: rectangleView.centerYAnchor)
        ])
        
    }
    
    private lazy var colorButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.image = UIImage(systemName: "shuffle")

        return makeGlassButton(configuration: configuration)
    }()
//    public func makeGlassButton(
//        configuration: UIButton.Configuration,
//        systemImageName: String? = nil,
//        contentInsets: NSDirectionalEdgeInsets = .init(
//            top: 12,
//            leading: 12,
//            bottom: 12,
//            trailing: 12
//        )
//    ) -> UIButton {
//        var configuration = configuration
//
//        configuration.contentInsets = contentInsets
//
//        if let systemImageName {
//            configuration.image = UIImage(systemName: systemImageName)
//        }
//
//        let button = UIButton(configuration: configuration)
//        button.translatesAutoresizingMaskIntoConstraints = false
//
//        return button
//    }

    private func setupActions() {
        colorButton.addTarget(
            self,
            action: #selector(colorButtonTapped),
            for: .touchUpInside
        )
    }

    @objc private func colorButtonTapped() {
        if rectangleView.backgroundColor == UIColor.green {
            rectangleView.backgroundColor = .black
        }
        else if rectangleView.backgroundColor == UIColor.white {
            rectangleView.backgroundColor = .systemPink
        } else {
            rectangleView.backgroundColor = .green
        }
    }
}

#Preview {
    ViewController()
}

