//
//  iOSDataFactoryTests.swift
//  iOSDataFactoryTests
//
//  Created by CodeIT LLC on 5/7/18.
//  Copyright © 2018 CodeIT LLC. All rights reserved.
//

import XCTest
@testable import iOSDataFactory

class iOSDataFactoryTests: XCTestCase {

    fileprivate let kIterationCount = 100000

    fileprivate var nameDataValues: DefaultNameDataValues!
    fileprivate var addressDataValues: DefaultAddressDataValues!
    fileprivate var contentDataValues: DefaultContentDataValues!

    override func setUp() {
        super.setUp()

        self.nameDataValues = DefaultNameDataValues()
        self.addressDataValues = DefaultAddressDataValues()
        self.contentDataValues = DefaultContentDataValues()
    }

    override func tearDown() {
        super.tearDown()

        self.nameDataValues = nil
        self.addressDataValues = nil
        self.contentDataValues = nil
    }

    func testShouldReturnRandomWordsOfVariedLength() {
        var index = 0
        while index < kIterationCount {
            // 1. given
            let maxLength = UInt(DataFactory.shared.getNumber(upTo: 12) + 1)
            // 2. when
            XCTAssertNotNil(DataFactory.shared.getRandomWord(from: 0, to: maxLength), "There should be no nil word")
            guard let word = DataFactory.shared.getRandomWord(from: 0, to: maxLength) else { return }
            // 3. then
            XCTAssertLessThanOrEqual(UInt(word.count), maxLength, "Wrong size word")
            index += 1
        }
    }

    func testShouldReturnRandomWordsOfSpecificLength() {
        var index = 0
        while index < kIterationCount {
            // 1. given
            let maxLength = UInt(DataFactory.shared.getNumber(upTo: 12) + 1)
            // 2. when
            XCTAssertNotNil(DataFactory.shared.getRandomWord(length: maxLength), "There should be no nil word")
            guard let word = DataFactory.shared.getRandomWord(length: maxLength) else { return }
            // 3. then
            XCTAssertEqual(UInt(word.count), maxLength, "Wrong size word")
            index += 1
        }
    }

    func testShouldReturnTextOfSpecificLength() {
        var index = 0
        while index < kIterationCount {
            // 1. given
            let textLength = UInt(DataFactory.shared.getNumber(upTo: 40) + 1)
            // 2. when
            XCTAssertNotNil(DataFactory.shared.getRandomText(length: textLength), "There should be no nil text")
            guard let text = DataFactory.shared.getRandomText(length: textLength) else { return }
            // 3. then
            XCTAssertTrue(textLength == text.count, "Length does not match expected value")
            index += 1
        }
    }

    func testShouldReturnTextWithWords() {
        var index = 0
        while index < kIterationCount {
            // 1. given
            let textLength = UInt(512 + DataFactory.shared.getNumber(upTo: 128) + 1)
            // 2. when
            XCTAssertNotNil(DataFactory.shared.getRandomText(length: textLength), "There should be no nil text")
            guard let text = DataFactory.shared.getRandomText(length: textLength) else { return }
            let words = text.split(separator: " ")
            // 3. then
            XCTAssertTrue(textLength == text.count, "Length does not match expected value")
            XCTAssertTrue(words.count > 32, "Long texts should contain spaces")
            XCTAssertFalse(text.contains("  "), "Text should not contain double spaces")
            index += 1
        }
    }

    func testShouldReturnRandomWordsUpToLength() {
        var index = 0
        while index < kIterationCount {
            // 1. given
            let maxLength = UInt(DataFactory.shared.getNumber(upTo: 30) + 1)
            // 2. when
            XCTAssertNotNil(DataFactory.shared.getRandomWord(from: 0, to: maxLength), "There should be no nil word")
            guard let word = DataFactory.shared.getRandomWord(from: 0, to: maxLength) else { return }
            // 3. then
            XCTAssertTrue(word.count <= maxLength, "Wrong size word")
            index += 1
        }
    }

    func testShouldReturnTextWithinBoundedLengths() {
        var index = 0
        while index < kIterationCount {
            // 1. given
            let minLength = UInt(10 + DataFactory.shared.getNumber(upTo: 20) + 1)
            let maxLength = minLength + UInt(DataFactory.shared.getNumber(upTo: 10) + 1)
            // 2. when
            XCTAssertNotNil(DataFactory.shared.getRandomText(from: minLength, to: maxLength), "There should be no nil text")
            guard let text = DataFactory.shared.getRandomText(from: minLength, to: maxLength) else { return }
            // 3. then
            XCTAssertTrue(minLength <= text.count, "Text length is less than expected minimum")
            XCTAssertTrue(maxLength >= text.count, "Text length is more than expected maximum")
            index += 1
        }
    }

    func testShouldReturnNegativeNumber() {
        // 1. given
        // 2. when
        let random = DataFactory.shared.getNumber(between: Int.min, and: -1)
        // 3. then
        XCTAssertTrue(random < 0, "Random number should be negative")
    }

    func testShouldReturnMinValue() {
        // 1. given
        // 2. when
        let random = DataFactory.shared.getNumber(between: Int.min, and: Int.min)
        // 3. then
        XCTAssertEqual(random, Int.min, "Random number should be minimum")
    }

    func testShouldReturnMaxValue() {
        // 1. given
        // 2. when
        let random = DataFactory.shared.getNumber(between: Int.max, and: Int.max)
        // 3. then
        XCTAssertEqual(random, Int.max, "Random number should be maximum")
    }

    func testShouldNilOnInvalidSizeLenForRandomWord() {
        // 1. given
        // 2. when
        let random = DataFactory.shared.getRandomWord(from: 10, to: 2)
        // 3. then
        XCTAssertNil(random, "There should be no word")
    }

    func testShouldNilOnInvalidSizeLenForRandomText() {
        // 1. given
        // 2. when
        let random = DataFactory.shared.getRandomText(from: 10, to: 2)
        // 3. then
        XCTAssertNil(random, "There should be no text")
    }

    func testShouldNilOnInvalidSizeLenForRandomChars() {
        // 1. given
        // 2. when
        let random = DataFactory.shared.getRandomChars(from: 10, to: 2)
        // 3. then
        XCTAssertNil(random, "There should be no char")
    }

    // MARK: Additional tests

    func testShouldNilOnEmptyArrayForGetItem() {
        // 1. given
        let randomArray = [Any]()
        // 2. when
        let item = DataFactory.shared.getItem(randomArray)
        // 3. then
        XCTAssertNil(item, "There should be no item")
    }

    func testShouldNilOnEmptyArrayForGetItemWithOneProbability() {
        // 1. given
        let randomArray = [Any]()
        let defaultItem = "Default"
        // 2. when
        let item = DataFactory.shared.getItem(randomArray, 100, defaultItem)
        // 3. then
        XCTAssertNil(item, "There should be no item")
    }

    func testShouldNilOnEmptyArrayForGetItemWithZeroProbability() {
        // 1. given
        let randomArray = [Any]()
        let defaultItem = "Default"
        // 2. when
        let item = DataFactory.shared.getItem(randomArray, 0, defaultItem)
        // 3. then
        XCTAssertNil(item, "There should be no item")
    }

    func testShouldReturnRandomValueForGetItemWithOneProbability() {
        // 1. given
        let randomArray = ["Non-Default"]
        let defaultItem = "Default"
        // 2. when
        let item = DataFactory.shared.getItem(randomArray, 100, defaultItem)
        // 3. then
        XCTAssertEqual(item, randomArray[0], "Choosed item should be equal to the random one")
    }

    func testShouldReturnDefaultValueForGetItemWithZeroProbability() {
        // 1. given
        let randomArray = ["Non-Default"]
        let defaultItem = "Default"
        // 2. when
        let item = DataFactory.shared.getItem(randomArray, 0, defaultItem)
        // 3. then
        XCTAssertEqual(item, defaultItem, "Choosed item should be equal to the default one")
    }

    func testShouldNotReturnDefaultNameForGetFirstName() {
        var index = 0
        while index < kIterationCount {
            // 1. given
            let name = DataFactory.shared.getFirstName()
            // 2. when
            XCTAssertNotNil(name, "There shouldn't be nil name")
            // 3. then
            XCTAssertNotEqual(name, self.nameDataValues.defaultFirstName, "There shouldn't be default name")
            index += 1
        }
    }

    func testShouldNotReturnDefaultNameForGetLastName() {
        var index = 0
        while index < kIterationCount {
            // 1. given
            let name = DataFactory.shared.getLastName()
            // 2. when
            XCTAssertNotNil(name, "There shouldn't be nil name")
            // 3. then
            XCTAssertNotEqual(name, self.nameDataValues.defaultLastName, "There shouldn't be default name")
            index += 1
        }
    }

    func testShouldNotReturnDefaultCityForGetCity() {
        var index = 0
        while index < kIterationCount {
            // 1. given
            let city = DataFactory.shared.getCity()
            // 2. when
            XCTAssertNotNil(city, "There shouldn't be nil city")
            // 3. then
            XCTAssertNotEqual(city, self.addressDataValues.defaultCity, "There shouldn't be default city")
            index += 1
        }
    }

    func testShouldNotReturnDefaultStreetNameForGetStreet() {
        var index = 0
        while index < kIterationCount {
            // 1. given
            let street = DataFactory.shared.getStreetName()
            // 2. when
            XCTAssertNotNil(street, "There shouldn't be nil street")
            // 3. then
            XCTAssertNotEqual(street, self.addressDataValues.defaultStreetName, "There shouldn't be default street")
            index += 1
        }
    }

    func testShouldNotReturnBaseBirthDateForGetBirthDate() {
        var index = 0
        var birthDateEqualityIndex = 0
        while index < kIterationCount {
            // 1. given
            let birthDate = DataFactory.shared.getBirthDate()
            // 2. when
            if birthDate == Date(timeIntervalSince1970: 0) { birthDateEqualityIndex += 1 }
            index += 1
        }
        // 3. then
        XCTAssertNotEqual(birthDateEqualityIndex, index, "There shouldn't be all default birth dates")
    }

    func testShouldNotReturnBirthDateGreaterOrLessThanBorderForGetBirthDate() {
        var index = 0
        let lowerBound = Calendar.current.date(byAdding: .day, value: -15 * 365, to: Date(timeIntervalSince1970: 0))
        let upperBound = Calendar.current.date(byAdding: .day, value: 15 * 365, to: Date(timeIntervalSince1970: 0))
        while index < kIterationCount {
            // 1. given
            let birthDate = DataFactory.shared.getBirthDate()
            // 2. when
            XCTAssertNotNil(lowerBound)
            XCTAssertNotNil(upperBound)
            // 3. then
            XCTAssertLessThanOrEqual(birthDate, upperBound!, "The birth date should be less than upper bound")
            XCTAssertGreaterThanOrEqual(birthDate, lowerBound!, "The birth date should be greater than lower bound")
            index += 1
        }
    }

    func testShouldNotReturnBaseDateForGetDate() {
        var index = 0
        var dateEqualityIndex = 0
        while index < kIterationCount {
            // 1. given
            let baseDate = Date()
            let date = DataFactory.shared.getDate(at: baseDate, from: 0, to: 1000)
            // 2. when
            if date == baseDate { dateEqualityIndex += 1 }
            index += 1
        }
        // 3. then
        XCTAssertNotEqual(dateEqualityIndex, index, "There shouldn't be all default dates")
    }

    func testShouldReturnBaseDateWithViseVersaParametersForGetDate() {
        var index = 0
        var dateEqualityIndex = 0
        while index < kIterationCount {
            // 1. given
            let baseDate = Date()
            let date = DataFactory.shared.getDate(at: baseDate, from: 100, to: -100)
            // 2. when
            if date == baseDate { dateEqualityIndex += 1 }
            index += 1
        }
        // 3. then
        XCTAssertEqual(dateEqualityIndex, index, "There should be all default dates")
    }

    func testShouldReturnOneDateWithEqualParametersForGetDate() {
        var index = 0
        while index < kIterationCount {
            // 1. given
            let baseDate = Date()
            let date = DataFactory.shared.getDate(at: baseDate, from: 100, to: 100)
            // 2. when
            let finiteDate = Calendar.current.date(byAdding: .day, value: 100, to: baseDate)
            // 3. then
            XCTAssertEqual(finiteDate, date, "Random date should be equal to the finite date")
            index += 1
        }
    }

    func testShouldReturnNumberFromZeroToUpperBoundExcludeIt() {
        var index = 0
        while index < kIterationCount {
            // 1. given
            // 2. when
            let number = DataFactory.shared.getNumber(upTo: 100)
            // 3. then
            XCTAssertLessThan(number, 100, "Upper bound should be excluded")
            XCTAssertGreaterThanOrEqual(number, 0, "Lower bound should be included")
            index += 1
        }
    }

    func testShouldReturnZeroInCaseOFWrongParameter() {
        var index = 0
        while index < kIterationCount {
            // 1. given
            // 2. when
            let number = DataFactory.shared.getNumber(upTo: -100)
            // 3. then
            XCTAssertEqual(number, 0, "Random number should be equal to the wrong parameter")
            index += 1
        }
    }

    func testShouldReturnTheSameNumberInCaseEqualParameters() {
        var index = 0
        while index < kIterationCount {
            // 1. given
            // 2. when
            let number = DataFactory.shared.getNumber(between: -5, and: -5)
            // 3. then
            XCTAssertEqual(number, -5, "Random number should be equal to the equal parameters")
            index += 1
        }
    }

    func testShouldReturnCharInLatinLowercase() {
        var index = 0
        while index < kIterationCount {
            // 1. given
            let uppercase = "a"..."z"
            // 2. when
            let char = DataFactory.shared.getRandomChar()
            // 3. then
            XCTAssertTrue(uppercase.contains(String(char)), "Random char should be between 'a' and 'z'")
            index += 1
        }
    }

    func testShouldReturnWithZeroBorder() {
        var index = 0
        while index < kIterationCount {
            // 1. given
            // 2. when
            let char = DataFactory.shared.getRandomChars(from: 0, to: 2)
            // 3. then
            XCTAssertNotNil(char, "Char has zero border")
            index += 1
        }
    }

    func testShouldReturnCharWithConstantLength() {
        var index = 0
        while index < kIterationCount {
            // 1. given
            // 2. when
            let char = DataFactory.shared.getRandomChars(from: 3, to: 3)
            XCTAssertNotNil(char)
            // 3. then
            guard let charCount = char?.count else { return }
            XCTAssertEqual(charCount, 3, "Char should has constant length")
            index += 1
        }
    }
}
