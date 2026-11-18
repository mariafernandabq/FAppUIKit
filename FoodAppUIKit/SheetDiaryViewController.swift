//
//  SheetDiaryViewController.swift
//  FoodAppUIKit
//
//  Created by Maria Fernanda Braga Queiroz on 18/11/26.
//

import UIKit

final class SheetDiaryViewController: UIViewController {
    
    private let notes = UITextView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "backgroundColor")

        let closeButton = UIButton(type: .system)
        closeButton.setImage(UIImage(systemName: "xmark.circle"), for: .normal)
        closeButton.accessibilityLabel = "Fechar notas"
        closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        closeButton.translatesAutoresizingMaskIntoConstraints = false

        notes.font = .preferredFont(forTextStyle: .body)
        notes.adjustsFontForContentSizeCategory = true
        notes.backgroundColor = .secondarySystemBackground
        notes.layer.cornerRadius = 15
        notes.accessibilityLabel = "Bloco de notas"
        notes.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(closeButton)
        view.addSubview(notes)

        let areaSegura = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: areaSegura.topAnchor, constant: 12),
            closeButton.trailingAnchor.constraint(equalTo: areaSegura.trailingAnchor, constant: -16),
            closeButton.widthAnchor.constraint(equalToConstant: 44),
            closeButton.heightAnchor.constraint(equalToConstant: 44),

            notes.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 8),
            notes.leadingAnchor.constraint(equalTo: areaSegura.leadingAnchor, constant: 16),
            notes.trailingAnchor.constraint(equalTo: areaSegura.trailingAnchor, constant: -16),
            notes.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor, constant: -16)
        ])
    }

    @objc private func close() {
        dismiss(animated: true)
    }
}

#Preview {
    UINavigationController(
        rootViewController: SheetDiaryViewController()
    )
}
