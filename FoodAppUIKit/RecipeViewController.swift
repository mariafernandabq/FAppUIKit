//
//  RecipeViewController.swift
//  FoodAppUIKit
//
//  Created by Maria Fernanda Braga Queiroz on 13/11/26.
//

import UIKit

class RecipeViewController: UIViewController {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Recipe"
        label.font = .systemFont(ofSize: 34, weight: .light)
        label.textColor = UIColor(named: "winePinkColor")
        label.textAlignment = .center
        return label
    }()
    
//    private let colorButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("Color Rectangle", for: .normal)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
    
    private let infoCard: UIView = {
        let card = UIView()
        card.backgroundColor = UIColor(named: "brownColor")
        card.layer.cornerRadius = 32
        return card
    }()

    private let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Infos"
        label.textColor = .white
        label.font = .systemFont(ofSize: 32)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18)
        return label
    }()

    private let itemsStack: UIStackView = {
        let stack = UIStackView()
           stack.axis = .vertical
           stack.spacing = 12
           return stack
    }()
    
    private let preparationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.textColor = UIColor(named: "brownColor")
        label.numberOfLines = 0
        return label
    }()
    
    private func display(_ recipe: Recipe) {
        titleLabel.text = recipe.name
        titleLabel.numberOfLines = 0
        infoLabel.text = """
        Tempo: \(recipe.time) min
        Dificuldade: \(recipe.level)
        Categoria: \(recipe.category)
        Porções: \(recipe.portions)
        """

        preparationLabel.text = recipe.steps
            .sorted { $0.order < $1.order }
            .map { "\($0.order). \($0.instruction)" }
            .joined(separator: "\n")

        for view in itemsStack.arrangedSubviews {
            itemsStack.removeArrangedSubview(view)
            view.removeFromSuperview()
        }

        for ingredient in recipe.ingredients {
            let label = UILabel()
            let ingredientText = [ingredient.quantity, ingredient.unit, ingredient.name]
                .filter { !$0.isEmpty }
                .joined(separator: " ")
            label.text = "• \(ingredientText)"
            label.font = .systemFont(ofSize: 18)
            label.textColor = UIColor(named: "brownColor")
            label.numberOfLines = 0
            itemsStack.addArrangedSubview(label)
        }
    }

    private func loadRecipe() {
        do {
            let recipes = try RecipeLoader.load()

            guard let recipe = recipes.randomElement() else {
                titleLabel.text = "Nenhuma receita disponível"
                
                return
            }

            display(recipe)
        } catch {
            titleLabel.text = "Não foi possível carregar as receitas"
            infoCard.isHidden = true
            print("Erro ao carregar JSON:", error)
        }
    }
    
    private let ingredientsSection = UIStackView()
    private let contentStack = UIStackView()

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(named: "backgroundColor")

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "xmark.circle"),
            primaryAction: UIAction() { [weak self] _ in
                self?.navigationController?.pushViewController(
                    ViewController(),
                    animated: true
                )
            }
        )
        
        setupViews()
        setupConstraints()
        loadRecipe()
    }

    private func setupViews() {
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentStack)
        infoCard.addSubview(infoLabel)

        ingredientsSection.axis = .vertical
        ingredientsSection.spacing = 8
        ingredientsSection.addArrangedSubview(
            makeSectionHeader("Ingredientes")
        )
        ingredientsSection.addArrangedSubview(itemsStack)

        contentStack.axis = .vertical
        contentStack.alignment = .fill
        contentStack.spacing = 16
        contentStack.setCustomSpacing(40, after: titleLabel)
        contentStack.translatesAutoresizingMaskIntoConstraints = false

        [
            titleLabel,
            infoCard,
            ingredientsSection,
            makeSectionHeader("Modo de Preparo"),
            preparationLabel
        ].forEach {
            contentStack.addArrangedSubview($0)
        }
    }

    private func setupConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        let contentGuide = scrollView.contentLayoutGuide
        let frameGuide = scrollView.frameLayoutGuide

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(
                equalTo: safeArea.topAnchor),
            scrollView.bottomAnchor.constraint(
                equalTo: safeArea.bottomAnchor),
            scrollView.leadingAnchor.constraint(
                equalTo: safeArea.leadingAnchor),
            scrollView.trailingAnchor.constraint(
                equalTo: safeArea.trailingAnchor),

            contentStack.topAnchor.constraint(
                equalTo: contentGuide.topAnchor,
                constant: 24),
            contentStack.bottomAnchor.constraint(
                equalTo: contentGuide.bottomAnchor,
                constant: -24),
            contentStack.leadingAnchor.constraint(
                equalTo: contentGuide.leadingAnchor,
                constant: 24
            ),
            contentStack.trailingAnchor.constraint(
                equalTo: contentGuide.trailingAnchor,
                constant: -24
            ),
            contentStack.widthAnchor.constraint(
                equalTo: frameGuide.widthAnchor,
                constant: -48
            ),

            infoLabel.topAnchor.constraint(equalTo: infoCard.topAnchor, constant: 16),
            infoLabel.bottomAnchor.constraint(equalTo: infoCard.bottomAnchor, constant: -16),
            infoLabel.leadingAnchor.constraint(equalTo: infoCard.leadingAnchor, constant: 16),
            infoLabel.trailingAnchor.constraint(equalTo: infoCard.trailingAnchor, constant: -16)
        ])
    }
    
    private func makeSectionHeader(_ title: String) -> UIStackView {
        let configuration = UIImage.SymbolConfiguration(
            pointSize: 30,
            weight: .regular
        )

        let star = UIImageView(
            image: UIImage(
                systemName: "star.fill",
                withConfiguration: configuration
            )
        )
        star.tintColor = UIColor(named: "brownColor")
        star.contentMode = .scaleAspectFit
        star.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            star.widthAnchor.constraint(equalToConstant: 32),
            star.heightAnchor.constraint(equalToConstant: 32)
        ])

        let label = UILabel()
        label.text = title
        label.font = .systemFont(ofSize: 26, weight: .light)
        label.textColor = UIColor(named: "brownColor")
        label.numberOfLines = 0

        let stack = UIStackView(arrangedSubviews: [star, label])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 16

        return stack
    }
}

#Preview {
    UINavigationController(
        rootViewController: RecipeViewController()
    )
}
