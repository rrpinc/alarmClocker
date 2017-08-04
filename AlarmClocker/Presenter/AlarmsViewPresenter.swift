
import Foundation

struct AlarmsViewPresenter : AlarmsViewPresenterProtocol{
    
    var tableViewDataSource: AlarmClocksTableViewDataSourceProtocol = AlarmClocksTableViewDataSource()
    var alarmsViewController: AlarmsViewControllerProtocol
    
    init(alarmsViewController: AlarmsViewControllerProtocol){
        self.alarmsViewController = alarmsViewController
    }
    
    func createAlarmTapped(){
        self.alarmsViewController.showCreateAlarmView()
    }
    
    func createAlarm(alarmString: String) {
        let alarm = Alarm(alramString: alarmString)
        self.tableViewDataSource.addAlarm(alarm: alarm)
        setLocalNotification(alarm: alarm)
    }
    
    func setLocalNotification(alarm: Alarm){
        AlarmClockNotificationScheduler.scheduleLocalNotification(alarmNotification: AlarmsNotificationMapper.map(alarm: alarm))
    }
}
