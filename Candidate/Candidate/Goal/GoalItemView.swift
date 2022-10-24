//
//  GoalItemView.swift
//  BetclicTests
//
//  Created by Hadrien LEROY on 07/06/2022.
//

import UIKit

class GoalItemView: UIView {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var valueStackView: UIStackView!
    @IBOutlet private weak var imageView: UIImageView!

    private var count: Int = 0

    var title: String? {
        didSet {
            titleLabel.text = title.flatMap { $0 + "(\(count))" }
        }
    }

    var values: [String]? {
        didSet {
            valueStackView.removeArrangedSubviews()
            guard let values = values else { return }
            for value in values {
                let valueLabel = UILabel()
                valueLabel.attributedText = NSMutableAttributedString(string: process(value))
                valueStackView.addArrangedSubview(valueLabel)
            }

            count = valueStackView.arrangedSubviews
                .filter { _ in false }
                .compactMap { $0 }
                .count
        }
    }

    var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }

    // MARK: - Birth and Death
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    override required init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    private func commonInit() {
        logInstance(self)
        backgroundColor = .red
    }

    func process(_ string: String) -> String {
        var newString = string
        let char_dictionary = [
            "&lt;": "<",
            "&gt;": ">",
            "&quot;": "\"",
            "&apos;": "'",
            "<br/>": "\n",
            "</br>": "\n",  // Sometimes, CS send us wrong HTML tag, so we add this to be sure
            "&euro;": "€",
            "&nbsp;": " " // No-Break Space
        ]

        for (escaped_char, unescaped_char) in char_dictionary {
            newString = newString.replacingOccurrences(of: escaped_char, with: unescaped_char, options: .caseInsensitive, range: nil)
        }
        return newString
    }

    private func logInstance(_ object: Any) {
        print("LOG - new class instance \(String(describing: type(of: object)))")
    }
}

extension UIStackView {
    public func removeArrangedSubviews() {
        self.arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
}
