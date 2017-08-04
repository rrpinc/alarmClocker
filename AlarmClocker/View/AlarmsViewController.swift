
import UIKit
import UserNotifications

class AlarmsViewController: UIViewController, AlarmsViewControllerProtocol {
    
    let cellNibName = "AlarmTableViewCell"
    let addAlarmTitle = "Add An Alarm"
    let addActionButtonTitle = "Add Alarm"
    let newAlarmTextFieldPlaceholder = "Alert time"
    
    @IBOutlet weak var alarmsTableView: UITableView!
    @IBOutlet weak var addAlarmButton: UIButton!
    let datePicker = UIDatePicker()
    var textFied : UITextField?
    var alarmsPresenter : AlarmsViewPresenterProtocol!
    
    //Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.alarmsPresenter = AlarmsViewPresenter(alarmsViewController: self)
        setupSubViews()
        UNUserNotificationCenter.current().delegate = self
        
        self.datePicker.datePickerMode = .time
        self.datePicker.addTarget(self, action: #selector(onDatePickerChange(datePicker:)), for: .valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.alarmsTableView.dataSource = self.alarmsPresenter.tableViewDataSource
        self.alarmsTableView.delegate = self.alarmsPresenter.tableViewDataSource
    }
    
    //AlarmsViewControllerProtocol Impl.
    
    @objc func createAlarmTapped(){
        self.alarmsPresenter.createAlarmTapped()
    }
    
    func showCreateAlarmView(){
        let createAlarmView = getCreateAlarmView()
        self.present(createAlarmView, animated: true, completion: nil)
    }
    
    //UIDatePicker Delegate
    
    @objc func onDatePickerChange(datePicker: UIDatePicker){
        self.textFied?.text = Alarm.AlarmDateFormatter.string(from: datePicker.date)
    }
    
    //SubViews Setup
    
    func getCreateAlarmView() -> UIAlertController{
        let alertController = UIAlertController(title: addAlarmTitle, message: "", preferredStyle: .alert)
        alertController.addTextField(configurationHandler: {
            textField in
            self.configureTextField(textField: textField)
        })
        
        alertController.addAction(UIAlertAction(title: addActionButtonTitle, style:.default, handler: {
            action in
            self.alarmsPresenter.createAlarm(alarmString: alertController.textFields?.first?.text ?? "")
            self.alarmsTableView.reloadData()
        }))
        return alertController
    }
    
    func configureTextField(textField: UITextField){
        textField.placeholder = newAlarmTextFieldPlaceholder
        textField.textAlignment = .center
        textField.inputView = self.datePicker
        self.textFied = textField
    }
    
    func setupSubViews(){
        self.alarmsTableView.register(UINib(nibName: cellNibName, bundle: nil), forCellReuseIdentifier: self.alarmsPresenter.tableViewDataSource.getCellReuseIdentifier())
        self.addAlarmButton.addTarget(self, action: #selector(createAlarmTapped), for: .touchUpInside)
        self.addAlarmButton.layer.cornerRadius = self.addAlarmButton.frame.height / 2.0
        self.addAlarmButton.layer.masksToBounds = true
    }
}

extension AlarmsViewController: UNUserNotificationCenterDelegate {
    
    //Alows display of in-app notifications in this controller
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert])
    }
}

