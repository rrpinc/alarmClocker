
import Foundation

class Alarm : NSObject, NSCoding{
    var time: Date
    static let dateFormat = "HH:mm"
    private static let dateFormatter = DateFormatter()
    
    static var AlarmDateFormatter: DateFormatter {
        get {
            dateFormatter.dateFormat = dateFormat
            return dateFormatter
        }
    }
    
    init(time: Date){
        self.time = time
    }
    
    init(alramString: String){
        self.time = Alarm.toDate(alarmString: alramString)
    }
    
    //NSCoding
    
    required init(coder decoder: NSCoder) {
        self.time = decoder.decodeObject(forKey: "time") as? Date ?? Date()
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(time, forKey: "time")
    }
    
    func toString() -> String{
        Alarm.dateFormatter.dateFormat = Alarm.dateFormat
        return Alarm.dateFormatter.string(from: time)
    }
    
    static func toDate(alarmString: String) -> Date{
        dateFormatter.dateFormat = Alarm.dateFormat
        return dateFormatter.date(from: alarmString) ?? Date()
    }
}

