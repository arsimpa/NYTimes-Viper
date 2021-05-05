
import Foundation // Use Foundation when no UIKit element is used

// Short-hand and easier to use instead of spinng objects by yourself
extension Int {
    var romanNumber : String {
        let number = RomanNumber(number: self)
        return number.convert()
    }
}

struct RomanNumber { // struct is more suitable in this condition, we will get member-wise initializer for free
    
    private let MAX_VALUE = 3000
    private let MIN_VALUE = 0 // Constant should be in CAPS
    
    var number: Int {
        didSet {
            if number >= MAX_VALUE {
                number = MAX_VALUE
            } else if number <= MIN_VALUE {
                number = MIN_VALUE
            }
        }
    }

    func convert() -> String {
        var result = ""
        let thousands = number / 1000
        result += times(thousands, character: "M")
        let hundreds = number / 100 % 10
        result += times(hundreds, o: "C", f: "D", t: "M")
        let tens = number / 10 % 10
        result += times(tens, o: "X", f: "L", t: "C")
        let ones = number % 10
        result += times(ones, o: "I", f: "V", t: "X")
        return result
    }
    
    private func times(_ value: Int, character: String) -> String {
        var result = ""
        for _ in (0..<value) {
            result += character
        }
        return result
    }
    
    private func times(_ value: Int, o: String, f: String, t: String) -> String {
        
        guard value < 10 else {
            print("Only single digits allowed - not " + String(number))
            return ""
        }
        
        switch value {
        case 1: return o
        case 2, 3: return times(value, character: o)
        case 4: return o + f
        case 5: return f
        case 6: return f + o
        case 7, 8: return f + times(value - 5, character: o)
        case 9: return o + t
        default:
            return ""
        }
    }
}

// Usage
1277.romanNumber
1.romanNumber
100.romanNumber
3000.romanNumber

