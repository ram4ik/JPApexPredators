//
//  Predators.swift
//  JPApexPredators
//
//  Created by Ramill Ibragimov on 7/6/25.
//

import Foundation

class Predators {
    var allApexPredators: [ApexPredator] = []
    var apexPredators: [ApexPredator] = []

    init() {
        decodeApexPredatorData()
    }

    func decodeApexPredatorData() {
        if let url = Bundle.main.url(forResource: "jpapexpredators", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                allApexPredators = try decoder.decode([ApexPredator].self, from: data)
                apexPredators = allApexPredators
            } catch {
                print("Error decoding JSON data: \(error)")
            }
        }
    }

    func search(for searchText: String) -> [ApexPredator] {
        if searchText.isEmpty {
            return apexPredators
        } else {
            return apexPredators.filter {
                $0.name.lowercased().contains(searchText.lowercased())
            }
        }
    }

    func sort(by alphabetical: Bool) {
        apexPredators.sort { predator1, predator2 in
            if alphabetical {
                return predator1.name < predator2.name
            } else {
                return predator1.id < predator2.id
            }
        }
    }

    func filter(by type: APType) {
        if type == .all {
            apexPredators = allApexPredators
        } else {
            apexPredators = allApexPredators.filter { predator in
                predator.type == type
            }
        }
    }
}
