
import Foundation

public final class HabitsStore {
    
    private lazy var userDefaults: UserDefaults = .standard
    
    private lazy var decoder: JSONDecoder = .init()
    
    private lazy var encoder: JSONEncoder = .init()
    
    public static let instance: HabitsStore = .init()
    
    private lazy var calendar: Calendar = .current
    
    public var habits: [Habit] = [] {
        didSet {
            save()
        }
    }
    
    /// Даты с момента установки приложения с разницей в один день.
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
    
    /// Сохраняет все изменения в привычках в UserDefaults.
    public func save() {
        do {
            let data = try encoder.encode(habits)
            userDefaults.setValue(data, forKey: "habits")
        }
        catch {
            print("Ошибка кодирования привычек для сохранения", error)
        }
    }
    
    /// Добавляет текущую дату в trackDates для переданной привычки.
    /// - Parameter habit: Привычка, в которую добавится новая дата.
    public func track(_ habit: Habit) {
        habit.trackDates.append(.init())
        save()
    }
    
    /// Показывает, была ли затрекана привычка в переданную дату.
    /// - Parameters:
    ///   - habit: Привычка, у которой проверяются затреканные даты.
    ///   - date: Дата, для которой проверяется, была ли затрекана привычка.
    /// - Returns: Возвращает true, если привычка была затрекана в переданную дату.
    public func checkHabit(_ habit: Habit, isTrackedIn date: Date) -> Bool {
        habit.trackDates.contains { trackDate in
            calendar.isDate(date, equalTo: trackDate, toGranularity: .day)
        }
    }
}
