
import Foundation

public extension Date {
    static func getDatesBetween(fromDate: Date, toDate: Date) -> [Date] {
        var dates: [Date] = []
        var date = fromDate

        while date <= toDate {
            dates.append(date)
            guard let newDate = Calendar.current.date(byAdding: .day, value: 1, to: date) else {
                break
            }
            date = newDate
        }
        return dates
    }
}
