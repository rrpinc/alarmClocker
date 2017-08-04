
import Foundation
import UserNotifications

struct AlarmClockNotificationScheduler{
    static let notificationInstance = AlarmClockNotificationScheduler()
    
    static func scheduleLocalNotification(alarmNotification: AlarmNotification) {
        if #available(iOS 10.0, *) {
            let notificationContent = getNotificationContent(title: alarmNotification.title)
            let notificationTrigger = getNotificationTrigger(date: alarmNotification.date)
            let notificationRequest = UNNotificationRequest(identifier:Alarm(time: alarmNotification.date).toString(), content: notificationContent, trigger: notificationTrigger)
            
            addNotificationRequest(notificationRequest: notificationRequest)
            
        } else {
            // iOS 9 is not supported in this sample project
        }
        
    }
    
    static func addNotificationRequest(notificationRequest: UNNotificationRequest){
        UNUserNotificationCenter.current().add(notificationRequest){
            error in
            if let unhandledError = error{
                   print(unhandledError.localizedDescription)
            }
        }
    }
    
    static func getNotificationContent(title: String) -> UNMutableNotificationContent {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.body = NSString.localizedUserNotificationString(forKey: title, arguments: nil)
        notificationContent.sound = UNNotificationSound.default()
        return notificationContent
    }
    
    static func getNotificationTrigger(date: Date) -> UNCalendarNotificationTrigger{
        return UNCalendarNotificationTrigger.init(dateMatching: NSCalendar.current.dateComponents([.day, .month, .year, .hour, .minute], from: date), repeats: false)
    }
}

