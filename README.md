# iOS Data Factory

iOSDataFactory is a project based on the project [DataFactory](https://github.com/andygibson/datafactory) created by Andy Gibson.
It allows you to easily generate test data: values for names, addresses, email addresses, phone numbers, text and dates.

## Installing

iOSDataFactory can be installed as a CocoaPod and builds as a Swift framework. To install, include this in your Podfile.
```
use_frameworks!

pod 'iOSDataFactory'
```

## Generating Test Data

The main feature of swift realization is singletone. To generate random data just call the class name, it shared property and method.
```
DataFactory.shared.getRandomWord()
```
The iOSDataFactory class can generate different types of values, from addresses to random text to random dates, to dates within a fixed time period.

### Numbers

There three different options to get a random number:
* from zero to maximum Integer:    
```
DataFactory.shared.getNumber() -> <Int>
```
* from zero to right custom bound: 
```
DataFactory.shared.getNumber(upTo: <Int>) -> <Int>
```
* from left to right custom bounds:
```
DataFactory.shared.getNumber(between: <Int>, and: <Int>) -> <Int>
```

### Characters

There three different options to get a random character(s) from `a` to `z`:
* a single character: 
```
DataFactory.shared.getRandomChar() -> <Character>
```
* string from one to `length`:
```
DataFactory.shared.getRandomChars(length: <Int>) -> <String?>
```
* string from `minLength` to `maxLength`: 
```
DataFactory.shared.getRandomChars(from minLength: <Int>, to maxLength: <Int>) -> <String?>
```

### Word

There three different options to get a random word from `contentDataValues`:
* from zero to thirteen: 
```
DataFactory.shared.getRandomWord() -> <String>
```
* from two to `length`:
``` 
DataFactory.shared.getRandomWord(length: <Int>) -> <String?>
```
* from `minLength` to `maxLength`:
``` 
DataFactory.shared.getRandomWord(from minLength: <Int>, to maxLength: <Int>) -> <String?>
```  

### Text

There three different options to get a random text from `DefaultContentDataValues`:
* from zero to `digits`: 
```
DataFactory.shared.getNumberText(_ digits: Int) -> <String>
```
* from two to `length`:
``` 
DataFactory.shared.getRandomText(length: Int) -> <String?>
```
* from `minLength` to `maxLength`:
``` 
DataFactory.shared.getRandomText(from minLength: Int, to maxLength: Int) -> <String?>
```  

### Name

There three different options to get a random name from `DefaultNameDataValues`:
* first name: 
```
DataFactory.shared.getFirstName() -> <String>
```
* last name:
``` 
DataFactory.shared.getLastName() -> <String>
```
* full name:
``` 
DataFactory.shared.getFullName() -> <String>
```  

### Address

There several different options to get a random address from `DefaultAddressDataValues`:
* street name: 
```
DataFactory.shared.getStreetName() -> <String>
```
* street suffix:
``` 
DataFactory.shared.getStreetSuffix() -> <String>
```
* city name:
``` 
DataFactory.shared.getCity() -> <String>
```  
* address:
``` 
DataFactory.shared.getAddress() -> <String>
```  
* second address line, which depends on `probability`:
``` 
DataFactory.shared.getSecondAddressLine(_ probability: Int = 100, _ defaultValue: String? = nil) -> <String?>
```  
* email address:
``` 
DataFactory.shared.getEmailAddress() -> String
```  
* business name:
``` 
DataFactory.shared.getBusinessName() -> String
```  

### Date

There three different options to get a random date:
* returns random date from `1955` to `1985`: 
```
DataFactory.shared.getBirthDate() -> Date
```
* returns random date, which lies in the interval from `minDate` to `maxDate` of current date:
``` 
DataFactory.shared.getDate(between minDate: Date, and maxDate: Date)
```  
* returns random date, which lies in the interval from `minDays` to `maxDays` of `baseDate`:
``` 
DataFactory.shared.getDate(at baseDate: Date, from minDays: Int, to maxDays: Int) -> Date
```

### Examples

The iOSDataFactory class can generate different types of values, from addresses to random text to random dates, to dates within a fixed time period. Addresses and business names can be created using the following code:
```
for _ in 1...10 {
    let address = DataFactory.shared.getAddress() + ", " + DataFactory.shared.getCity() + ", " + DataFactory.shared.getNumberText(5)
    let business = DataFactory.shared.getBusinessName()
    print(business + " located at " + address)
}
```
The produced output is :
```
Dacula Insurance located at 726 Sandra Park, Monroe, 70567
Blackshear Insurance located at 603 Granger Run, Nankin, 93250
Bogart Office supplies located at 674 Stalling Ave, Surrency, 87090
Uvalda Manufacturing located at 1793 Palmeraway Drv, Stillmore, 94901
Inaha Engineering located at 933 Grove Court, Mcintyre, 91245
College Park Software located at 1779 Chandlersville Path, Doerun, 56435
Lawrenceville Bakery located at 1328 Bowman Run, Temple, 49766
Osterfield Accounting located at 484 Alameda Path, South Newport, 64096
Doerun Insurance located at 1798 Larzelere Boulevard, Tarver, 87907
Hinesville Realty located at 753 Flintridge Rd, Cartersville, 17976
```

There are a number of features to create dates, the first being creating a random date which is usually in a given sensible date range.
```
let dateFormatter = DateFormatter()
dateFormatter.dateStyle = .medium
var dateComponents = DateComponents()
dateComponents.year = 1980
dateComponents.month = 7
dateComponents.day = 11

let optionalMinDate = Calendar.current.date(from: dateComponents)
let maxDate = Date()

guard let minDate = optionalMinDate else { return }

for _ in 1...10 {
    let startDate = DataFactory.shared.getDate(between: minDate, and: maxDate)
    print("Date = \(dateFormatter.string(from: startDate))")
}
```
The result is list of date in selected bounds:
```
Date = Dec 26, 2005
Date = Feb 1, 2015
Date = Jun 16, 1996
Date = Mar 13, 1998
Date = Sep 2, 1983
Date = Jun 16, 1998
Date = Jul 26, 1988
Date = Jun 11, 1991
Date = May 17, 1991
Date = Oct 18, 2011

```

Typically, a random date might be constrained by some other date, for example you can’t have an end date that occurs before the start date. In this case, you would plug the start date in as the minimum date value:
```
for _ in 1...10 {
    let startDate = DataFactory.shared.getDate(between: minDate, and: maxDate)
    let endDate = DataFactory.shared.getDate(between: startDate, and: maxDate)
    print("Date range = \(dateFormatter.string(from: startDate)) to \(dateFormatter.string(from: endDate))")
}
```
The result is a list of dates where the second date is always later than the first:
```
Date range = Sep 27, 1981 to Apr 14, 2001
Date range = Jan 10, 1991 to Jun 24, 2001
Date range = Oct 7, 2008 to Jul 15, 2013
Date range = Jun 2, 2004 to Dec 9, 2007
Date range = Jan 29, 1987 to Jul 8, 1989
Date range = Nov 20, 1992 to Nov 27, 2006
Date range = Dec 24, 2015 to Jun 1, 2018
Date range = Oct 24, 2003 to Apr 27, 2008
Date range = Oct 19, 2002 to Jun 18, 2014
Date range = Mar 21, 1994 to Feb 10, 2009
```

In many cases, you might want your end date to be only within a few days of the start date. For example, helpdesk support tickets or hotel stays don’t last for years. To do this, you can specify the number of days from the base date you want to generate a result. In this case, we make the end date within 10 days of the begin date:
```
for _ in 1...10 {
    let startDate = DataFactory.shared.getDate(between: minDate, and: maxDate)
    let endDate = DataFactory.shared.getDate(at: startDate, from: 0, to: 10)
    print("Date range = \(dateFormatter.string(from: startDate)) to \(dateFormatter.string(from: endDate))")
}
```
And the result:
```
Date range = Aug 7, 2010 to Aug 12, 2010
Date range = Mar 30, 1992 to Mar 31, 1992
Date range = Jan 7, 1995 to Jan 15, 1995
Date range = Apr 25, 1989 to Apr 29, 1989
Date range = Aug 14, 2000 to Aug 22, 2000
Date range = Dec 10, 1988 to Dec 12, 1988
Date range = Oct 17, 2004 to Oct 17, 2004
Date range = Oct 8, 1982 to Oct 10, 1982
Date range = Feb 7, 2004 to Feb 9, 2004
Date range = May 5, 1995 to May 7, 1995
```

You can also specify a negative minimum days value that could return a date prior to the base date or a positive minimum date value to get a later date. Here’s a more complex example that uses different date rules to come up with some complex test data.
```
for _ in 1...10 {
    // Generate an order date
    let orderDate = DataFactory.shared.getDate(between: minDate, and: maxDate)
    // Estimate delivery 4-10 days after ordering
    let estimatedDeliveryDate = DataFactory.shared.getDate(at: orderDate, from: 4, to: 10)
    // Deliver between 2 days prior and 3 days after delivery estimate
    let actualDeliveryDate = DataFactory.shared.getDate(at: estimatedDeliveryDate, from: -2, to: 3)
    var message = "Ordered on \(dateFormatter.string(from: orderDate)) deliver by = \(dateFormatter.string(from: estimatedDeliveryDate)) delivered on \(dateFormatter.string(from: actualDeliveryDate))"
    if estimatedDeliveryDate < actualDeliveryDate {
        message += " - LATE"
    } else if estimatedDeliveryDate > actualDeliveryDate {
        message += " - EARLY"
    }
    print(message)
}
```
Here we calculate an order date, and create a delivery date that is at least 4 days out but no more than 10, and then we created an actual delivery date that is between 2 days prior and 3 days after the expected delivery date.
Notice how we cherry picked the dates, the estimated delivery date is at least 4 days out from the order date, and the actual delivery date will only be at most 2 days prior to the estimated date. This means the actual delivery date is always at least 2 days out from the order date and we won’t get a delivery date value that is before the item was ordered. This code produces the following values:
```
Ordered on Jan 9, 1995 deliver by = Jan 15, 1995 delivered on Jan 16, 1995 - LATE
Ordered on Oct 4, 2009 deliver by = Oct 13, 2009 delivered on Oct 13, 2009
Ordered on Nov 21, 1994 deliver by = Nov 26, 1994 delivered on Nov 28, 1994 - LATE
Ordered on Sep 24, 2016 deliver by = Sep 28, 2016 delivered on Sep 27, 2016 - EARLY
Ordered on Nov 23, 1986 deliver by = Nov 30, 1986 delivered on Dec 1, 1986 - LATE
Ordered on May 25, 2006 deliver by = May 30, 2006 delivered on Jun 1, 2006 - LATE
Ordered on Sep 26, 2002 deliver by = Oct 1, 2002 delivered on Oct 2, 2002 - LATE
Ordered on Mar 26, 2012 deliver by = Mar 31, 2012 delivered on Mar 31, 2012
Ordered on Apr 27, 1997 deliver by = May 2, 1997 delivered on May 2, 1997
Ordered on May 11, 1997 deliver by = May 17, 1997 delivered on May 16, 1997 - EARLY
```

## Textual Data

Random text data comes in two forms, absolutely random data and text data made up of words. You can generate either using the following methods:
```
print(DataFactory.shared.getRandomText(from: 20, to: 25)!)
print(DataFactory.shared.getRandomChars(length: 20)!)
print(DataFactory.shared.getRandomWord(from: 4, to: 10)!)
```
which produces
```
monster island rescue
huqttachmujxhlhbfwrr
waited
```
All three of these methods can be passed a single length which returns a fixed length string, or a min/max length which produces a random string with a length somewhere between the min/max. For the single word method, if there are no words in the dictionary of suitable length, then a word is generated using random characters.

Changing the test data values produced
The data used to generate the values come from classes that can be replaced with other versions. For example, the suffix values can be changed by creating the DefaultNameDataValues instance and calling setter for DataFactory. Notice, that you override only values, that you pass into the initializer.
Here is a simple code that implements custom academic suffixes into the DefaultNameDataValues.
```
let academicSuffixes = ["Ph.D.", "Ed.D.", "D.Phil.", "D.B.A.", "LL.D", "Eng.D."]
let customNameData = DefaultNameDataValues(suffixes: academicSuffixes)
DataFactory.shared.setNameDataValues(customNameData)
for _ in 1..<10 {
    print(DataFactory.shared.getSuffix(100)!)
}
```
Our results are:
```
Ph.D.
LL.D
Ph.D.
D.Phil.
Ed.D.
Ph.D.
D.B.A.
Ph.D.
D.Phil.
```
You can always start working with the default implementation and use a more locale specific implementation if you need it later.

The different pieces that can be replaced are as follows :
* DefaultNameDataValues – Generates names and suffix/prefixes;
* DefaultContentDataValues – Generates words, business types, email domain names and top level domain values;
* DefaultAddressDataValues – Generates city names, street names and address suffixes.

Note that if you intend on replacing the component that generates words, you should have a good collection of words of various lengths from 2 up to say 8 or more characters.

## Authors

* **CodeIT** - *Initial work* - [iOSDataFactory](https://github.com/codeitua/ios-data-factory)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details
