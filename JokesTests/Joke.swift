//
//  Joke.swift
//  Jokes
//
//  Created by Maitree Bain on 12/3/19.
//  Copyright © 2019 Maitree Bain. All rights reserved.
//

import Foundation

struct Joke: Decodable {
    let id: Int
    let type: String
    let setup: String
    let punchline: String
}
