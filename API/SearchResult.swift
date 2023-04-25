//
//  SearchResult.swift
//  MyPlants
//
//  Created by Mathias Vinther Søndergaard on 17/04/2023.
//

import Foundation


import Foundation

// This struct models search results from Perenual API
struct SearchResult: Codable {
	
	var data: [PerenualPlant]? = []
	var to: Int?    = nil
	var perPage: Int?    = nil
	var currentPage: Int?    = nil
	var from: Int?    = nil
	var lastPage: Int?    = nil
	var total: Int?    = nil

	enum CodingKeys: String, CodingKey {
		
		case data = "data"
		case to = "to"
		case perPage = "per_page"
		case currentPage = "current_page"
		case from = "from"
		case lastPage = "last_page"
		case total = "total"
  }
	init(from decoder: Decoder) throws {
		
		let values = try decoder.container(keyedBy: CodingKeys.self)
		data = try values.decodeIfPresent([PerenualPlant].self, forKey: .data)
		to = try values.decodeIfPresent(Int.self, forKey: .to)
		perPage = try values.decodeIfPresent(Int.self, forKey: .perPage)
		currentPage = try values.decodeIfPresent(Int.self, forKey: .currentPage)
		from = try values.decodeIfPresent(Int.self, forKey: .from)
		lastPage = try values.decodeIfPresent(Int.self, forKey: .lastPage)
		total = try values.decodeIfPresent(Int.self, forKey: .total)
  }
  init() {}
}
