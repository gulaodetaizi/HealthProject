//
//  BLPickerViewController.swift
//  Bodylogical
//
//  Created by appledev096 on 17/3/22.
//  Copyright © 2017年 Bodylogical. All rights reserved.
//

import UIKit

//protocol BLPickerDelegate: NSObjectProtocol {
//  func doneAction(value: String, index: Int)
//}

let TITLEVIEW_HEIGHT: CGFloat = 50
class BLPickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var pickerView: UIPickerView!
    var dataSource:NSArray?
    //weak var pickerDelegate: BLPickerDelegate?
    var selectedText: String?
    var selectedIndex: Int?
    
    var selectedBackBlock:((String, Int)->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.backgroundView.backgroundColor = UIColor.black
        self.backgroundView.alpha = 0.45
        self.view.bringSubview(toFront: self.pickerView)
        self.pickerView.isHidden = true
        self.titleView.isHidden = true
      
        let time: TimeInterval = 0.3
        let delay = DispatchTime.now() + Double(Int64(time * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: delay) {
            self.popAnimation()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let screenHeight = UIScreen.main.bounds.height
        let width = self.pickerView.bounds.width
        let height = self.pickerView.bounds.height
        self.titleView.frame = CGRect(x: 0, y: screenHeight, width: width, height: TITLEVIEW_HEIGHT)
        self.pickerView.frame = CGRect(x: 0, y: screenHeight + TITLEVIEW_HEIGHT, width: width, height: height)
        self.pickerView.selectRow(self.selectedIndex ?? 0, inComponent: 0, animated: true)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.setVisualEffectView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setVisualEffectView() {
        //set Visual Effect View
        self.providesPresentationContextTransitionStyle = true
        self.definesPresentationContext = true
        self.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
    }
    
    func popAnimation() {
        self.titleView.isHidden = false
        self.pickerView.isHidden = false
        let screenHeight = UIScreen.main.bounds.height
        let width = self.pickerView.bounds.width
        let height = self.pickerView.bounds.height
        self.titleView.frame = CGRect(x: 0, y: screenHeight, width: width, height: TITLEVIEW_HEIGHT)
        self.pickerView.frame = CGRect(x: 0, y: screenHeight + TITLEVIEW_HEIGHT, width: width, height: height)
        UIView.animate(withDuration: 0.2) {
            self.titleView.frame = CGRect(x: 0, y: screenHeight - height - TITLEVIEW_HEIGHT, width: width, height: height)
            self.pickerView.frame = CGRect(x: 0, y: (screenHeight - height), width: width, height: height)
        }
    }
    
    func dismissAnimation() {
        self.backgroundView.backgroundColor = UIColor.clear
        self.backgroundView.alpha = 1.0
        UIView.animate(withDuration: 0.1) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        let touchedPoint = touches.first
        if let point = touchedPoint?.location(in: self.view) {
            if !(self.pickerView.frame.contains(point)) {
                self.dismissAnimation()
            }
        }
    }
    
    func selectPicker(index: Int, dataSource: NSArray) {
        
        guard dataSource.count > 0 else {
            return
        }
        self.dataSource = dataSource
        selectedText = dataSource[index] as? String
        selectedIndex = index
        
    }
    
    @IBAction func clickDoneButton(_ sender: UIButton) {
        self.pickerView.endEditing(true)
        if selectedText != nil {
            if let selectedIndex = self.dataSource?.index(of: selectedText!) {
                self.selectedBackBlock?(selectedText!, selectedIndex)
            }
            self.dismissAnimation()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataSource?.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataSource?[row] as? String
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedText = dataSource?[row] as? String
    }
    
}
