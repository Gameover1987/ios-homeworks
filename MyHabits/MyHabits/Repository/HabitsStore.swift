
import Foundation

public final class HabitsStore {
    
    private lazy var userDefaults: UserDefaults = .standard
    
    private lazy var decoder: JSONDecoder = .init()
    
    private lazy var encoder: JSONEncoder = .init()
    
    private lazy var calendar: Calendar = .current
    
    private init() {
        if userDefaults.value(forKey: "start_date") == nil {
            let startDate = calendar.date(from: calendar.dateComponents([.year, .month, .day], from: Date())) ?? Date()
            userDefaults.setValue(startDate, forKey: "start_date")
        }
        guard let data = userDefaults.data(forKey: "habits") else {
            return
        }
        do {
            habits = try decoder.decode([Habit].self, from: data)
        }
        catch {
            print("Во время загрузки привычек произошла ошибка!", error)
        }
    }
    
    public static let instance: HabitsStore = .init()
    
    public var habits: [Habit] = [] {
        didSet {
            save()
        }
    }
    
    public var dates: [Date] {
        guard let startDate = userDefaults.object(forKey: "start_date") as? Date else {
            return []
        }
        return Date.getDatesBetween(fromDate: startDate, toDate: .init())
    }
    
    /// Возвращает значение от 0 до 1.
    public var todayProgress: Float {
        guard habits.isEmpty == false else {
            return 0
        }
        let takenTodayHabits = habits.filter { $0.isTodayAdded }
        return Float(takenTodayHabits.count) / Float(habits.count)
    }
    
    public func save() {
        do {
            let data = try encoder.encode(habits)
            userDefaults.setValue(data, forKey: "habits")
        }
        catch {
            print("Во время сохранения привычек произошла ошибка", error)
        }
    }
    
    public func track(_ habit: Habit) {
        habit.trackDates.append(.init())
        save()
    }
    
    public func checkHabit(_ habit: Habit, isTrackedIn date: Date) -> Bool {
        habit.trackDates.contains { trackDate in
            calendar.isDate(date, equalTo: trackDate, toGranularity: .day)
        }
    }
}
