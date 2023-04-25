//
//  DefaultImage.swift
//  MyPlants
//
//  Created by Mathias Vinther Søndergaard on 17/04/2023.
//

import Foundation

// This struct models the default image from the Perenual API
struct DefaultImage: Codable {
	
	var license: Int? = nil
	var licenseName: String? = nil
	var licenseUrl: String? = nil
	var originalUrl: String? = nil
	var regularUrl: String? = nil
	var mediumUrl: String? = nil
	var smallUrl: String? = nil
	var thumbnail: String? = nil

	enum CodingKeys: String, CodingKey {
		
		case license = "license"
		case licenseName = "license_name"
		case licenseUrl = "license_url"
		case originalUrl = "original_url"
		case regularUrl = "regular_url"
		case mediumUrl = "medium_url"
		case smallUrl = "small_url"
		case thumbnail = "thumbnail"
  }

	init(from decoder: Decoder) throws {
		
		let values = try decoder.container(keyedBy: CodingKeys.self)

		license = try values.decodeIfPresent(Int.self, forKey: .license)
		licenseName = try values.decodeIfPresent(String.self, forKey: .licenseName)
		licenseUrl = try values.decodeIfPresent(String.self, forKey: .licenseUrl)
		originalUrl = try values.decodeIfPresent(String.self, forKey: .originalUrl)
		regularUrl = try values.decodeIfPresent(String.self, forKey: .regularUrl)
		mediumUrl = try values.decodeIfPresent(String.self, forKey: .mediumUrl)
		smallUrl = try values.decodeIfPresent(String.self, forKey: .smallUrl)
		thumbnail = try values.decodeIfPresent(String.self, forKey: .thumbnail)
	}

  init() {}
}
