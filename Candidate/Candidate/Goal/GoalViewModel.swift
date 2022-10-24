//
//  GoalViewModel.swift
//  BetclicTests
//
//  Created by Hadrien LEROY on 07/06/2022.
//

import UIKit

enum GoalSourceType {
    case bet
    case mission
}

struct Availability {
    let minDate: Date
    let maxDate: Date
}

struct GoalItem {

    // MARK: - Properties
    var title: String
    var values: [String]
    var image: UIImage?

    init(title: String, values: [String], image: UIImage?) {
        self.title = title.uppercased()
        self.values = values
        self.image = image
    }
}

protocol GoalViewModelProtocol {

    var source: GoalSourceType { get }
    var title: String { get }
    var items: [GoalItem] { get }
}

final class GoalViewModel: GoalViewModelProtocol {

    let source: GoalSourceType
    let title: String
    let items: [GoalItem]

    init(availability: Availability,
         minOdds: Double?,
         minStake: Double?,
         event: String?,
         source: GoalSourceType,
         dateFormatter: DateFormatter) {
        self.source = source

        title = "Objectifs"

        var itemss = [GoalItem]()

        // Date
        itemss.append(GoalItem(title: "Date", values: [dateFormatter.string(from: availability.minDate), dateFormatter.string(from: availability.maxDate)], image: UIImage(named: "GoalDate")))

        // Event
        if let event = event {
            itemss.append(GoalItem(title: "Event",
                                   values: [event],
                                   image: UIImage(named: "GoalEvent")))
        }

        // Odd
        let oddNumberFormatter = NumberFormatter()
        if let minOdds = minOdds,
           let minOddsValue = oddNumberFormatter.string(from: NSNumber(value: minOdds)) {
            itemss.append(GoalItem(title: "Cote minimum",
                                   values: [minOddsValue],
                                   image: UIImage(named: "GoalOdd")))
        }

        // Stake
        let stakeNumberFormatter = NumberFormatter()
        if let minStake = minStake,
           let minStakeValue = stakeNumberFormatter.string(from: NSNumber(value: minStake)) {
            itemss.append(GoalItem(title: "Mise minimum",
                                   values: [minStakeValue],
                                   image: UIImage(named: "GoalStake")))
        }

        self.items = itemss.sorted {
            $0.title > $1.title
        }
        .reversed()
        .filter {
            $0.image != nil
        }

        logInstance(self)
    }

    private func logInstance(_ object: Any) {
        print("LOG - new class instance \(String(describing: type(of: object)))")
    }
}
