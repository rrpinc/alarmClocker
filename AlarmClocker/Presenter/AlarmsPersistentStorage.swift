
import Foundation

struct AlarmsPersistentStorage{
    
    static let provider = UserDefaults.standard
    static let key = "alarms"
    static var cachedAlarms: [Alarm] = []
    
    static func addAlarm(alarm: Alarm) -> [Alarm]{
        
        if cachedAlarms.contains(where: { currentAlarm in currentAlarm.time == alarm.time }){
            return self.cachedAlarms
        }
        
        cachedAlarms.append(alarm)
        self.cachedAlarms = cachedAlarms.sorted(by: {
            (alarm, otherAlarm) in
            alarm.time < otherAlarm.time
        })
        
        let encodedAlarms = NSKeyedArchiver.archivedData(withRootObject: self.cachedAlarms)
        provider.set(encodedAlarms, forKey:key)
        
        return self.cachedAlarms
    }
    
    static func getAlarms() -> [Alarm]{
        guard let storedAlarms = provider.value(forKey: key) as? Data, let decodedStoredAlarms = NSKeyedUnarchiver.unarchiveObject(with: storedAlarms as Data) as? [Alarm] else {
            return []
        }
        self.cachedAlarms = decodedStoredAlarms
        return self.cachedAlarms
    }
}
