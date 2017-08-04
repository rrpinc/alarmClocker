
import UIKit

protocol AlarmCellProtocol {
    func populate(alarm: Alarm)
}

class AlarmTableViewCell: UITableViewCell, AlarmCellProtocol {
    
    @IBOutlet weak var alarmLabel: UILabel!
    
    func populate(alarm: Alarm) {
        self.alarmLabel?.text = alarm.toString()
        self.alarmLabel.textColor = (alarm.time < Date()) ? UIColor.lightGray : UIColor.black
    }
}
