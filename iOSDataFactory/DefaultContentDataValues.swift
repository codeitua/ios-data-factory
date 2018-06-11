//
//  DefaultContentDataValues.swift
//  iOSDataFactory
//
//  Created by CodeIT LLC on 5/8/18.
//  Copyright © 2018 CodeIT LLC. All rights reserved.
//

import Foundation

public class DefaultContentDataValues {
    
    // MARK: - Initializer
    
    public init() {}
    
    // MARK: - Public properties
    
    public let defaultWord = "leaf"
    public let defaultBusinessType = "Supermarket"
    public let defaultEmailHost = "anyma1l"
    public let defaultTld = "gov"
    
    // MARK: - Private properties
    
    fileprivate let words = ["throw", "ball", "hat", "red", "worn",
    "list", "words", "computer", "in", "out", "hot", "cold", "warp",
    "speed", "captain", "assert", "hold", "room", "ship", "lost", "is",
    "television", "show", "about", "plane", "crash", "island",
    "monster", "trees", "banging", "smoke", "where", "are", "we",
    "was", "asked", "no", "rescue", "came", "build", "fire", "waited",
    "days", "moved", "to", "caves", "found", "with", "ghost", "dad",
    "in", "white", "rabbit", "lock", "discovered", "hatch", "with",
    "boon", "secretly", "hid", "it", "while", "trying", "to", "open",
    "it", "until", "sidekick", "died", "as", "sacrifice", "island",
    "demanded", "many", "had", "dreams", "or", "visions", "others",
    "came", "took", "people", "who", "are", "they", "what", "do",
    "they", "want", "light", "came", "on", "through", "window",
    "leader", "is", "a", "good", "man", "numbers", "in", "room",
    "enter", "keys", "computer", "end", "of", "world", "wicket",
    "magnetic", "pull", "shepherd", "always", "wrong", "much",
    "suspense", "what", "to", "do", "when", "it", "ends", "I", "will",
    "have", "to", "find", "something", "else", "to", "pique", "my",
    "interest", "or maybe", "write", "lots", "of", "code", "probably",
    "should", "have", "generated", "this", "text", "automatically",
    "so", "will", "from", "the", "web", "ending", "badly", "library",
    "handled", "books", "constantly", "headphones", "of", "ill", "on",
    "it's", "sill", "sits", "sofa"]
    
    fileprivate let businessTypes = ["Furnishings", "Bakery",
    "Accounting", "Textiles", "Manufacturing", "Industries",
    "Pro Services", "Landscaping", "Realty", "Travel",
    "Medical supplies", "Office supplies", "Insurance", "Software",
    "Motors", "Cafe", "Services", "Gymnasium", "Motor Services",
    "Signs", "Development", "Studios", "Engineering", "Development"]
    
    fileprivate let emailHosts = ["gma1l", "hotma1l", "yah00",
    "somema1l", "everyma1l", "ma1lbox", "b1zmail", "ma1l2u"]
    
    fileprivate let tlds = ["org", "net", "com", "biz", "us", "co.uk"]
    
    // MARK: - Public API
    
    public func getWords() -> [String] {
        return words
    }
    
    public func getBusinessTypes() -> [String] {
        return businessTypes
    }
    
    public func getEmailHosts() -> [String] {
        return emailHosts
    }
    
    public func getTlds() -> [String] {
        return tlds
    }
}
