//
//  JokesTests.swift
//  JokesTests
//
//  Created by Maitree Bain on 12/3/19.
//  Copyright © 2019 Maitree Bain. All rights reserved.
//

import XCTest
@testable import Jokes

class JokesTests: XCTestCase {

    func testJokeModel() {
        let jsonData = """
[{
"id": 73,
"type": "programming",
    "setup": "The punchline often arrives before the set-up.",
    "punchline": "Do you know the problem with UDP jokes?"

},
{
    "id": 379,
    "type": "programming",
    "setup": "A programmer puts two glasses on his bedside table before going to sleep.",
    "punchline": "A full one, in case he gets thirsty, and an empty one, in case he doesn’t."
}]
""".data(using: .utf8)!
        let expectedJokesCount = 2
        
        do {
            let jokes = try JSONDecoder().decode([Joke].self, from: jsonData)
            XCTAssertEqual(jokes.count, expectedJokesCount, "there should be \(expectedJokesCount) created")
        } catch {
            XCTFail("decoding error: \(error)")
        
    
    }

}
}
