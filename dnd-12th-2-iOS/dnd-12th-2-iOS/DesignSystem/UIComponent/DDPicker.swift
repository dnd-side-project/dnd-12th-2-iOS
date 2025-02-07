//
//  DDPicker.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/7/25.
//
import SwiftUI
import UIKit

struct DDPicker: UIViewRepresentable {
    let items: [String]
    
    func makeUIView(context: Context) -> UIPickerView {
        let picker = UIPickerView()
        picker.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        picker.dataSource = context.coordinator
        picker.delegate = context.coordinator
        picker.frame.size.height = 168
        return picker
    }
    
    func updateUIView(_ uiView: UIPickerView, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return DDPicker.Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
        let parent: DDPicker
        
        init(parent: DDPicker) {
            self.parent = parent
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return parent.items.count
        }
        
        // Picker를 몇개 띄울지
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        
        func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
            pickerView.subviews[1].alpha = 0
            
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 56))
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
                        
            label.textColor = (row == pickerView.selectedRow(inComponent: component)) ? UIColor.purple800 : UIColor.gray200
            label.textAlignment = .center
            label.font = UIFont(name: "Pretendard-Medium", size: 22)
            
            if let numberItem = Int(parent.items[row])  {
                label.text = String(format: "%02d", numberItem)
            } else {
                label.text = parent.items[row]
            }
            
            view.addSubview(label)
            
            return view
        }
        
        func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
            return 56
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            pickerView.reloadComponent(component)
        }
    }
}
