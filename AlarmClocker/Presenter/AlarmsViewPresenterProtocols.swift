
import Foundation

protocol AlarmsViewControllerProtocol {
    func showCreateAlarmView()
}

protocol AlarmsViewPresenterProtocol{
    var alarmsViewController: AlarmsViewControllerProtocol { get set }
    var tableViewDataSource: AlarmClocksTableViewDataSourceProtocol { get set }
    func createAlarmTapped()
    func createAlarm(alarmString: String)
}
