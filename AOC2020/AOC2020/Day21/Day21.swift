import Foundation
import AdventOfCode

public final class Day21: Day {
	private var input: String = ""
	private var recipes: [Recipe] = []

	struct Recipe {
		var ingredients: [String]
		var allergens: [String]
	}

	public init(input: String = Input().trimmedRawInput()) {
		super.init()
		self.input = input

		for line in input.lines {
			let ingToAllgn = line.components(separatedBy: " (contains ")

			let ings = ingToAllgn[0].components(separatedBy: " ")
			let allergens = String(ingToAllgn[1].dropLast()).components(separatedBy: ", ")

			let recipe = Recipe(ingredients: ings, allergens: allergens)
			recipes.append(recipe)
		}
	}

	public override func part1() -> String {
		let ingredientsWithKnownAllergens = potentialAllergenList().values.flatMap { $0 }

		let result = recipes.flatMap({ $0.ingredients }).count(where: { !ingredientsWithKnownAllergens.contains($0) })

		return "\(result)"
	}

	public override func part2() -> String {
		var maybeAllergens = potentialAllergenList()

		var notModified = false
		while !notModified {
			notModified = true
			for kv in maybeAllergens {
				if kv.value.count == 1 {
					for k in maybeAllergens.keys {
						if k != kv.key {
							maybeAllergens[k]?.removeAll(where: { $0 == kv.value[0] })
						}
					}
				} else {
					notModified = false
				}
			}
		}

		let sortedIngredients = maybeAllergens.sorted { kv1, kv2 in kv1.key < kv2.key }.reduce("") { $0 + $1.value[0] + "," }.dropLast()


		return String(sortedIngredients)
	}

	private func potentialAllergenList() -> [String: [String]] {
		// For each allergen listed, any missing ingredients are NOT the allergen.

		var maybeAllergenList: [String: [String]] = [:]

		for recipe in recipes {
			for allergen in recipe.allergens {
				if let existingIngredients = maybeAllergenList[allergen] {
					maybeAllergenList[allergen] = existingIngredients.intersection(of: recipe.ingredients)
				} else {
					maybeAllergenList[allergen] = recipe.ingredients
				}
			}
		}

		return maybeAllergenList
	}
}
