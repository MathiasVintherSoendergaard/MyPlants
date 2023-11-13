//
//  Perenualplant.swift
//  MyPlants
//
//  Created by Mathias Vinther Søndergaard on 17/04/2023.
//

import Foundation

// this struct models the data that is sent from the Perenual API
// Codable used to decode and encode JSON objects
// Identifiable to let the app iterate over collections of PerenualPlant

struct PlantAPIData: Codable, Identifiable {

	var id: Int? = nil
	var commonName: String? = nil
	var scientificName: [String]? = []
	var otherName: [String]? = []
	var cycle: String? = nil
	var watering: String? = nil
	var sunlight: [String]? = []
	var defaultImage: DefaultImage? = DefaultImage()

	// CodingKeys is used for encoding and decoding
	enum CodingKeys: String, CodingKey {

		case id             = "id"
		case commonName     = "common_name"
		case scientificName = "scientific_name"
		case otherName      = "other_name"
		case cycle          = "cycle"
		case watering       = "watering"
		case sunlight       = "sunlight"
		case defaultImage   = "default_image"
  }
	
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)

		id = try values.decodeIfPresent(Int.self, forKey: .id)
		commonName = try values.decodeIfPresent(String.self, forKey: .commonName)
		scientificName = try values.decodeIfPresent([String].self, forKey: .scientificName)
		otherName = try values.decodeIfPresent([String].self, forKey: .otherName)
		cycle = try values.decodeIfPresent(String.self, forKey: .cycle)
		watering = try values.decodeIfPresent(String.self, forKey: .watering)
		sunlight = try values.decodeIfPresent([String].self, forKey: .sunlight)
		defaultImage = try values.decodeIfPresent(DefaultImage.self, forKey: .defaultImage)
	}
  init() {}
}
