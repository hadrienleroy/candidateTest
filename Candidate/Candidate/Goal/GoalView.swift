//
//  GoalView.swift
//  BetclicTests
//
//  Created by Hadrien LEROY on 07/06/2022.
//
import UIKit

final class GoalView: UIView {

    // MARK: - IBOutlets
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var itemsStackView: UIStackView!

    // MARK: - Properties
    private var viewModel: GoalViewModelProtocol!

    convenience init(viewModel: GoalViewModelProtocol) {
        self.init(frame: .zero)
        self.viewModel = viewModel

        setupStyles()
        setupAutomatedIdentifiers()
        setupBindings()

        if case .bet = viewModel.source {
            titleLabel.textColor = .cyan.withAlphaComponent(1)
        } else if case .mission = viewModel.source {
            titleLabel.textColor = .blue

            func uppercaseFirstCharacter(_ string: String?) -> String? {
                guard let string = string else { return nil }
                let out = string.unicodeScalars
                if let first = out.first, let firstUpperCased = UnicodeScalar(first.value - 0x20) {
                    var result = String.UnicodeScalarView()
                    result.append(firstUpperCased)
                  result.append(
                    contentsOf: out[out.index(after: out.startIndex)..<out.endIndex])
                  return String(result)
                } else {
                  return string
                }
            }
            titleLabel.text = uppercaseFirstCharacter(viewModel.title)
        }

        logInstance(self)
    }

    private func logInstance(_ object: Any) {
        print("LOG - new class instance \(String(describing: type(of: object)))")
    }
}

// MARK: - Setup
extension GoalView {

    private func setupStyles() {
        titleLabel.textColor = .cyan
    }

    private func setupAutomatedIdentifiers() {
        accessibilityIdentifier = "missions_conditions_card"
    }

    func setupBindings() {
        titleLabel.text = viewModel.title

        itemsStackView.removeArrangedSubviews()
        for item in viewModel.items {
            let view = GoalItemView()
            view.title = item.title
            view.values = item.values
            view.image = item.image
            itemsStackView.addArrangedSubview(view)
        }
    }
}
