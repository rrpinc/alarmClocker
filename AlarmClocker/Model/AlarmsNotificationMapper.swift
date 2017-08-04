
import Foundation

struct AlarmNotification{
    let title: String
    let date: Date
}

struct AlarmsNotificationMapper{
    static let notificationTitle = "Sound the alarm"
    
    static func map(alarm: Alarm) -> AlarmNotification{
        return AlarmNotification(title: notificationTitle, date: TimeToFullDate(date: alarm.time))
    }
    
    static func TimeToFullDate(date: Date) -> Date{
        let calendar = Calendar(identifier: .gregorian)
        let currentDate = Date()
        var currentComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: currentDate)
        let alarmComponents = calendar.dateComponents([.hour, .minute], from: date)

        currentComponents.hour = alarmComponents.hour
        currentComponents.minute = alarmComponents.minute
        
        return calendar.date(from: currentComponents)!
    }
}
