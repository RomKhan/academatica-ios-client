//
//  HeatmapCalendarViewController.swift
//  SmartMath
//
//  Created by Roman on 14.01.2022.
//

import UIKit
import CalendarHeatmap

class HeatmapCalendarViewController: UIViewController {
    lazy var data: [String: UIColor] = {
        guard let data = readHeatmap() else { return [:] }
        return data.mapValues { (colorIndex) -> UIColor in
            return UIColor(red: 196 / 256.0, green: 196 / 256.0, blue: 196 / 256.0, alpha: 1)
        }
    }()
    var endDate: Date = Date()
    
    lazy var calendarHeatMap: CalendarHeatmap = {
        var config = CalendarHeatmapConfig()
        config.backgroundColor = UIColor.clear
        // config item
        config.selectedItemBorderColor = .clear
        config.allowItemSelection = false
        // config month header
        config.monthHeight = 27
        config.monthStrings = DateFormatter().shortMonthSymbols
        config.monthFont = UIFont.systemFont(ofSize: 15)
        config.monthColor = UIColor.black
        // config weekday label on left
        config.weekDayFont = UIFont.systemFont(ofSize: 0)
        config.weekDayWidth = 20
        config.weekDayColor = UIColor.black
        config.itemSide = max(12, UIScreen.main.bounds.height / 75)
        config.lineSpacing = 3
        config.interitemSpacing = 3
        
        let calendar: CalendarHeatmap
        if let startDtate = Calendar.current.date(byAdding: .day, value: -364, to: Date()) {
            calendar = CalendarHeatmap(config: config, startDate: startDtate, endDate: Date())
        } else {
            calendar = CalendarHeatmap(config: config, startDate: Date(2019, 5, 1), endDate: Date(2020, 3, 23))
        }
        calendar.delegate = self
        
        return calendar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.clear
        
        view.addSubview(calendarHeatMap)
        calendarHeatMap.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            calendarHeatMap.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 0),
            calendarHeatMap.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 30),
            calendarHeatMap.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0)
        ])
        
        UserService.shared.loadActivity { [weak self] newValue in
            
            if let newValue = newValue {
                self?.data = newValue.mapValues { (colorIndex) -> UIColor in
                    var color: UIColor = UIColor.red
                    if colorIndex == 0 {
                        color = UIColor(red: 196 / 256.0, green: 196 / 256.0, blue: 196 / 256.0, alpha: 1)
                    } else if colorIndex > 0 && colorIndex <= 5 {
                        color = UIColor(red: 151 / 256.0, green: 151 / 256.0, blue: 151 / 256.0, alpha: 1)
                    } else if colorIndex > 5 {
                        color = UIColor(red: 68 / 256.0, green: 68 / 256.0, blue: 68 / 256.0, alpha: 1)
                    }
                    return color
                }
                self?.endDate = Date()
                self?.calendarHeatMap.reload(newStartDate: Calendar.current.date(byAdding: .day, value: -364, to: Date()), newEndDate: Date())
            }
        }
    }
    
    private func readHeatmap() -> [String: Int]? {
        guard let url = Bundle.main.url(forResource: "heatmap", withExtension: "plist") else { return nil }
        return NSDictionary(contentsOf: url) as? [String: Int]
    }
}

extension HeatmapCalendarViewController: CalendarHeatmapDelegate {
    func didSelectedAt(dateComponents: DateComponents) {
        guard let year = dateComponents.year,
            let month = dateComponents.month,
            let day = dateComponents.day else { return }
        // do something here
        print(year, month, day)
    }
    
    func colorFor(dateComponents: DateComponents) -> UIColor {
        guard let year = dateComponents.year,
            let month = dateComponents.month,
            let day = dateComponents.day else { return .clear}
        let dateString = String(format: "%02d-%02d-%02dT00:00:00+00:00", year, month, day)
        return data[dateString] ?? UIColor(red: 196 / 256.0, green: 196 / 256.0, blue: 196 / 256.0, alpha: 1)
    }
    
    func finishLoadCalendar() {
        calendarHeatMap.scrollTo(date: endDate, at: .right, animated: false)
    }
}

extension Date {
    init(_ year:Int, _ month: Int, _ day: Int) {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        self.init(timeInterval:0, since: Calendar.current.date(from: dateComponents)!)
    }
}
