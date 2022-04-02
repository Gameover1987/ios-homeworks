
import Foundation
import UIKit

public final class Habit : Decodable, Encodable, Equatable {
    
    private var r: CGFloat
    private var g: CGFloat
    private var b: CGFloat
    private var a: CGFloat
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.timeStyle = .short
        return formatter
    }()
    
    private lazy var calendar: Calendar = .current
    
    public init(name: String, date: Date, trackDates: [Date] = [], color: UIColor) {
        self.name = name
        self.date = date
        self.trackDates = trackDates
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        color.getRed(&r, green: &g, blue: &b, alpha: &a)
        self.r = r
        self.g = g
        self.b = b
        self.a = a
    }

    public var name: String
    
    public var date: Date

    public var trackDates: [Date] = [Date]()
    
    public var color: UIColor {
        get {
            return .init(red: r, green: g, blue: b, alpha: a)
        }
        set {
            var r: CGFloat = 0
            var g: CGFloat = 0
            var b: CGFloat = 0
            var a: CGFloat = 0
            newValue.getRed(&r, green: &g, blue: &b, alpha: &a)
            self.r = r
            self.g = g
            self.b = b
            self.a = a
        }
    }
    
    public var isAlreadyTakenToday: Bool {
        guard let lastTrackDate = trackDates.last else {
            return false
        }
        return calendar.isDateInToday(lastTrackDate)
    }
    
    public var dateDescription: String {
        "Каждый день в " + dateFormatter.string(from: date)
    }
    
    public static func == (habitA: Habit, habitB: Habit) -> Bool {
        habitA.name == habitB.name &&
        habitA.date == habitB.date &&
        habitA.trackDates == habitB.trackDates &&
        habitA.r == habitB.r &&
        habitA.g == habitB.g &&
        habitA.b == habitB.b &&
        habitA.a == habitB.a
    }
}
