//
//  HeatpapCalendarView.swift
//  SmartMath
//
//  Created by Roman on 14.01.2022.
//

import SwiftUI
import CalendarHeatmap

struct HeapmapCalendarView: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> HeatmapCalendarViewController {
        let calendarHeatmap = HeatmapCalendarViewController()
        
        return calendarHeatmap
    }
    
    func updateUIViewController(_ heapmapCalendar: HeatmapCalendarViewController, context: Context) {
        
    }
}
