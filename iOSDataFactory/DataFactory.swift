//
//  DataFactory.swift
//  iOSDataFactory
//
//  Created by CodeIT LLC on 5/8/18.
//  Copyright © 2018 CodeIT LLC. All rights reserved.
//

import Foundation

private let kRangeOfRandom: Int = 93285

public final class DataFactory {

    // MARK: - Private properties

    private lazy var nameDataValues = DefaultNameDataValues()
    private lazy var addressDataValues = DefaultAddressDataValues()
    private lazy var contentDataValues = DefaultContentDataValues()

    // MARK: - Initializer

    public static let shared = DataFactory()

    // MARK: - Public API

    // Generic

    public func getItem<T>(_ items: [T], _ probability: Int = 100, _ defaultItem: T? = nil) -> T? {
        guard items.count != 0 else { return nil }
        return chance(probability) ? items[self.getRandom(from: items.count)] : defaultItem
    }

    // Name

    public func getFirstName() -> String {
        return self.getItem(self.nameDataValues.getFirstNames()) ?? self.nameDataValues.defaultFirstName
    }

    public func getLastName() -> String {
        return self.getItem(self.nameDataValues.getLastNames()) ?? self.nameDataValues.defaultLastName
    }

    public func getFullName() -> String {
        let firstName = self.getFirstName()
        let lastName = self.getLastName()
        return firstName + " " + lastName
    }

    public func getBusinessName() -> String {
        let city = self.getCity()
        let businessType = self.getItem(self.contentDataValues.getBusinessTypes()) ?? self.contentDataValues.defaultBusinessType
        return city + " " + businessType
    }

    // Address

    public func getStreetName() -> String {
        return self.getItem(self.addressDataValues.getStreetNames()) ?? self.addressDataValues.defaultStreetName
    }

    public func getStreetSuffix() -> String {
        return self.getItem(self.addressDataValues.getAddressSuffixes()) ?? self.addressDataValues.defaultAddressSuffix
    }

    public func getCity() -> String {
        return self.getItem(self.addressDataValues.getCities()) ?? self.addressDataValues.defaultCity
    }

    public func getAddress() -> String {
        let number = 404 + self.getRandom(from: 1400)
        let streetName = self.getStreetName()
        let streetSuffix = self.getStreetSuffix()
        return "\(number) " + streetName + " " + streetSuffix
    }

    public func getSecondAddressLine(_ probability: Int = 100, _ defaultValue: String? = nil) -> String? {
        let secondAddressType = (self.getRandom(from: 100) < 50) ? "Apt # " : "Suite # "
        let secondAddressNumber = "\(100 + self.getRandom(from: 1000))"

        return self.chance(probability) ? secondAddressType + secondAddressNumber : defaultValue
    }

    public func getEmailAddress() -> String {
        var email = ""
        if self.getRandom(from: 100) < 50 {
            let firstName = self.getFirstName()
            let lastName = self.getLastName()
            email = firstName + "_" + lastName
        } else {
            let firstRandom = self.getRandomWord()
            let secondRandom = self.getRandomWord()
            email = firstRandom + secondRandom
        }

        if self.getRandom(from: 100) > 80 {
            email = email + "\(self.getRandom(from: 100))"
        }

        let emailHost = self.getItem(self.contentDataValues.getEmailHosts()) ?? self.contentDataValues.defaultEmailHost
        let tld = self.getItem(self.contentDataValues.getTlds()) ?? self.contentDataValues.defaultTld

        email = email + "@" + emailHost + "." + tld

        return email.lowercased()
    }

    // Date

    // Creates a random birthdate within the range of 1955 to 1985
    public func getBirthDate() -> Date {
        let base = Date(timeIntervalSince1970: 0)
        return self.getDate(at: base, from: -15 * 365, to: 15 * 365)
    }

    public func getDate(at baseDate: Date, from minDays: Int, to maxDays: Int) -> Date {
        if maxDays < minDays { return baseDate }
        let deltaDays = minDays + self.getRandom(from: maxDays - minDays)
        return Calendar.current.date(byAdding: .day, value: deltaDays, to: baseDate) ?? baseDate
    }

    public func getDate(between minDate: Date, and maxDate: Date) -> Date {
        let deltaDaysComponent = Calendar.current.dateComponents([.day], from: minDate, to: maxDate)
        guard let deltaDays = deltaDaysComponent.day else { return minDate }

        return Calendar.current.date(byAdding: .day, value: self.getRandom(from: deltaDays), to: minDate) ?? minDate
    }

    // Number

    public func getNumber() -> Int {
        return self.getRandom()
    }

    public func getNumber(between min: Int, and max: Int) -> Int {
        if max <= min { return min }
        return min + self.getRandom(from: max - min)
    }

    public func getNumber(upTo max: Int) -> Int {
        return self.getNumber(between: 0, and: max)
    }

    // Char

    // Returns lowercase latin alphabet letter
    public func getRandomChar() -> Character {
        let letterASCIICode = 97 + self.getRandom(from: 25)
        if let unicode = UnicodeScalar(letterASCIICode) { return Character(unicode) }
        return Character("a")
    }

    public func getRandomChars(length: UInt) -> String? {
        return self.getRandomChars(from: length, to: length)
    }

    public func getRandomChars(from minLength: UInt, to maxLength: UInt) -> String? {
        guard minLength <= maxLength else { return nil }

        var randomText = String()
        var length = Int(minLength) + self.getRandom(from: Int(maxLength) - Int(minLength))

        while length > 0 {
            let randomChar = self.getRandomChar()
            randomText.append(randomChar)
            length -= 1
        }

        return randomText
    }

    // Text

    public func getRandomText(length: UInt) -> String? {
        return self.getRandomText(from: length, to: length)
    }

    public func getRandomText(from minLength: UInt, to maxLength: UInt) -> String? {
        guard minLength <= maxLength else { return nil }

        var randomText = String()
        var length = Int(minLength) + self.getRandom(from: Int(maxLength) - Int(minLength))

        while length > 0 {
            let desiredWordLengthNormalDistributed = self.getNumber(between: 1, and: 10)
            let usedWordLength = min(desiredWordLengthNormalDistributed, length)

            if let word = getRandomWord(length: UInt(usedWordLength)) {
                randomText.append(word)
                length -= word.count
                if length >= 1 { randomText.append(" "); length -= 1 }
            }
        }

        return randomText
    }

    public func getNumberText(_ digits: Int) -> String {
        var digits = digits
        var randomText = ""

        while digits != 0 {
            randomText.append("\(self.getRandom(from: 10))")
            digits -= 1
        }

        return randomText
    }

    // Word

    public func getRandomWord() -> String {
        return self.getItem(self.contentDataValues.getWords()) ?? self.contentDataValues.defaultWord
    }

    public func getRandomWord(length: UInt) -> String? {
        return self.getRandomWord(from: length, to: length)
    }

    public func getRandomWord(from minLength: UInt, to maxLength: UInt) -> String? {
        guard minLength <= maxLength else { return nil }

        // special case if we need a single char
        if maxLength == 1 { return self.chance(50) ? "a" : "I" }
        // we haven't a word for this length so generate one
        else if minLength > 10 { return getRandomChars(from: minLength, to: maxLength) }

        // start from random pos and find the first word of the right size
        let words = self.contentDataValues.getWords()

        var pos = self.getRandom(from: words.count)
        var randomWord = words[pos]

        while randomWord.count < minLength || randomWord.count > maxLength {
            pos = self.getRandom(from: words.count)
            randomWord = words[pos]
        }
        return randomWord
    }

    // Suffix

    public func getSuffix(_ chance: Int) -> String? {
        return self.getItem(self.nameDataValues.getSuffixes(), chance)
    }

    // Prefix

    public func getPrefix(_ chance: Int) -> String? {
        return self.getItem(self.nameDataValues.getPrefixes(), chance)
    }

    // Setter

    public func setNameDataValues(_ nameDataValues: DefaultNameDataValues) {
        self.nameDataValues = nameDataValues
    }

    public func setAddressDataValues(_ addressDataValues: DefaultAddressDataValues) {
        self.addressDataValues = addressDataValues
    }

    public func setContentDataValues(_ contentDataValues: DefaultContentDataValues) {
        self.contentDataValues = contentDataValues
    }

    // MARK: - Private API

    private func chance(_ chance: Int) -> Bool {
        return getRandom(from: 100) < chance
    }

    private func getRandom(from number: Int = kRangeOfRandom) -> Int {
        return number == 0 ? 0 : Int.random(in: Range(uncheckedBounds: (lower: 0, upper: number)))
    }
}
