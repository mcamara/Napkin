//
//  NapkinViewController.swift
//  Pods
//
//  Created by Daniel Green on 10/07/2015.
//
//

import Luncheon
import XLForm

public class NapkinViewController: XLFormViewController {
    private var currentSection: XLFormSectionDescriptor?
    
    public required override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        initializeForm()
    }
    
    public required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeForm()
    }
    
    private func initializeForm() {
        let form = XLFormDescriptor(title: "Add \(subject()!.remote.subjectClassNameUnderscore().titleize())")
        self.form = form
        
        sectionSeparator()
        setupFields()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    public func subject() -> Lunch? {
        return nil
    }
    
    public func setupFields() {
        
    }
    
    func subjectClass() -> AnyObject.Type {
        return object_getClass(subject()) as AnyObject.Type
    }
    
    public func input(fieldName: String, collection: [Int: String]? = nil, type: InputType? = nil, required: Bool = false, var label: String = "") {
        let modelValue = subject()!.valueForKey(fieldName)
        
        if label.isEmpty {
            label = fieldName.underscoreCase().titleize()
        }
        
        var fieldType = ClassInspector.propertyTypes(subjectClass())[fieldName]
        if fieldType == nil {
            fieldType = PropertyType.Other
        }
        
        var rowType: String
        
        if type != nil {
            rowType = type!.rawValue
        } else {
            switch fieldType! {
            case .NSDate:
                rowType = XLFormRowDescriptorTypeDateTimeInline
            case .BOOL:
                rowType = XLFormRowDescriptorTypeBooleanSwitch
            default:
                rowType = XLFormRowDescriptorTypeText
            }
        }
        
        let row: XLFormRowDescriptor
        if let c = collection {
            rowType = XLFormRowDescriptorTypeSelectorPush
            row = XLFormRowDescriptor(tag: fieldName, rowType: rowType)
            var options = [XLFormOptionsObject]()
            
            let sortedKeys = Array(c.keys).sort(<)
            
            for key in sortedKeys {
                let option = XLFormOptionsObject(value: key, displayText: c[key])
                if key == modelValue as! Int {
                    row.value = option
                }
                options.append(option)
            }
            
            
            row.selectorTitle = label
            row.selectorOptions = options
            if modelValue == nil { row.value = options.first }
            
        } else {
            row = XLFormRowDescriptor(tag: fieldName, rowType: rowType)
            row.value = modelValue
        }
        
        if isRowTypeText(rowType) {
            row.cellConfigAtConfigure["textField.placeholder"] = label
        } else if rowType == XLFormRowDescriptorTypeTextView {
            row.cellConfigAtConfigure["textView.placeholder"] = "Notes"
        } else {
            row.title = label
        }
        
        row.required = required
        currentSection?.addFormRow(row)
    }
    
    private func isRowTypeText(rowType: String) -> Bool {
        return rowType == XLFormRowDescriptorTypeText
            || rowType == XLFormRowDescriptorTypeURL
            || rowType == XLFormRowDescriptorTypeEmail
            || rowType == XLFormRowDescriptorTypePassword
    }
    
    public func sectionSeparator() {
        currentSection = XLFormSectionDescriptor.formSection()
        form.addFormSection(currentSection)
    }
}