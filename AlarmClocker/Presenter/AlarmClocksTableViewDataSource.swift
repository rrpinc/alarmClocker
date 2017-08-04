
import UIKit

protocol AlarmClocksTableViewDataSourceProtocol : UITableViewDelegate, UITableViewDataSource {
    func getCellReuseIdentifier() -> String
    func addAlarm(alarm: Alarm)
}

class AlarmClocksTableViewDataSource: NSObject, AlarmClocksTableViewDataSourceProtocol {
    let reuseIdentifier = "AlarmCell"
    var alarms: [Alarm] = AlarmsPersistentStorage.getAlarms()
    
    func getCellReuseIdentifier() -> String{
        return reuseIdentifier
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.alarms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        if cell is AlarmCellProtocol{
            (cell as! AlarmCellProtocol).populate(alarm: self.alarms[indexPath.row])
        }
        
        return cell
    }
    
    func addAlarm(alarm: Alarm){
        let fullAlarmDateTime = AlarmsNotificationMapper.TimeToFullDate(date: alarm.time)
        self.alarms = AlarmsPersistentStorage.addAlarm(alarm: Alarm(time: fullAlarmDateTime))
    }
}
