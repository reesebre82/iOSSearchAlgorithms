//
//  ViewController.swift
//  Sorting
//
//  Created by Brendan Reese on 12/18/19.
//  Copyright © 2019 BrendanReese. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var sliderBox = UITextView()
    var timeBox = UITextView()
    var lastKnownSliderValue = 0
    var barCollection = BarColletion(bars: 20, box: UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50)))
    var box = UIView()
    var slider = UISlider()
    var timeMillis = 0
    var timeSeconds = 0
    var timer = Timer()
    
    var buttons = [UIButton]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.black
        
        setScene()
    }
    
    
    
    func setScene(){
        let shift = self.view.frame.width * 0.2
        let topView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height * 0.1))
        topView.center = CGPoint(x: self.view.frame.width * 0.5, y: self.view.frame.height * 0.05)
        topView.backgroundColor = UIColor(red:0.24, green:0.67, blue:1.00, alpha:1.0)
        self.view.addSubview(topView)
        
        slider = UISlider(frame: CGRect(x: 0, y: 0, width: self.view.frame.width * 0.15, height: topView.frame.height * 0.25))
        slider.center = CGPoint(x: (topView.frame.width * 0.2) + shift, y: topView.frame.height * 0.5)
        slider.maximumValue = 238
        slider.minimumValue = 20
        slider.addTarget(self, action: #selector(sliderValueDidChange(sender:)), for: .valueChanged)
        topView.addSubview(slider)
        
        sliderBox = UITextView(frame: CGRect(x: 0, y: 0, width: topView.frame.width * 0.05, height: topView.frame.height * 0.75))
        sliderBox.center = CGPoint(x: (topView.frame.width * 0.085) + shift, y: topView.frame.height * 0.5)
        sliderBox.layer.cornerRadius = 8.0
        sliderBox.layer.masksToBounds = true
        sliderBox.font = UIFont.init(name: "CourierNewPSMT", size: 16)
        sliderBox.backgroundColor = UIColor.white
        sliderBox.textColor = UIColor.black
        sliderBox.centerVertically()
        sliderBox.text = "0"
        sliderBox.textAlignment = .center
        sliderBox.isEditable = false
        topView.addSubview(sliderBox)
        
        box = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width * 0.8, height: self.view.frame.height * 0.8))
        box.backgroundColor = UIColor.black
        box.center = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height * 0.55)
        self.view.addSubview(box)
        
        let randomButton = UIButton(frame: CGRect(x: 0, y: 0, width: topView.frame.width * 0.11, height: topView.frame.height * 0.75))
        randomButton.setTitle("Randomize", for: .normal)
        randomButton.addTarget(self, action: #selector(randomize(sender:)), for: .touchUpInside)
        randomButton.center = CGPoint(x: (topView.frame.width * 0.35) + shift, y: topView.frame.height / 2)
        randomButton.backgroundColor = UIColor.white
        randomButton.setTitleColor(UIColor.black, for: .normal)
        randomButton.layer.cornerRadius = 8.0
        randomButton.layer.masksToBounds = true
        randomButton.titleLabel?.font = UIFont.init(name: "CourierNewPSMT", size: 16)
        randomButton.titleLabel?.textAlignment = .center
        buttons.append(randomButton)
        topView.addSubview(randomButton)
        
        let bubbleButton = UIButton(frame: CGRect(x: 0, y: 0, width: topView.frame.width * 0.075, height: topView.frame.height * 0.75))
        bubbleButton.setTitle("Bubble", for: .normal)
        bubbleButton.addTarget(self, action: #selector(bubbleSort(sender:)), for: .touchUpInside)
        bubbleButton.center = CGPoint(x: (topView.frame.width * 0.45) + shift, y: topView.frame.height / 2)
        bubbleButton.backgroundColor = UIColor.white
        bubbleButton.setTitleColor(UIColor.black, for: .normal)
        bubbleButton.layer.cornerRadius = 8.0
        bubbleButton.layer.masksToBounds = true
        bubbleButton.titleLabel?.font = UIFont.init(name: "CourierNewPSMT", size: 16)
        bubbleButton.titleLabel?.textAlignment = .center
        buttons.append(bubbleButton)
        topView.addSubview(bubbleButton)
        
        let selectionButton = UIButton(frame: CGRect(x: 0, y: 0, width: topView.frame.width * 0.11, height: topView.frame.height * 0.75))
        selectionButton.setTitle("Selection", for: .normal)
        selectionButton.addTarget(self, action: #selector(selectionSort(sender:)), for: .touchUpInside)
        selectionButton.center = CGPoint(x: (topView.frame.width * 0.55) + shift, y: topView.frame.height / 2)
        selectionButton.backgroundColor = UIColor.white
        selectionButton.setTitleColor(UIColor.black, for: .normal)
        selectionButton.layer.cornerRadius = 8.0
        selectionButton.layer.masksToBounds = true
        selectionButton.titleLabel?.font = UIFont.init(name: "CourierNewPSMT", size: 16)
        selectionButton.titleLabel?.textAlignment = .center
        buttons.append(selectionButton)
        topView.addSubview(selectionButton)
        
        let quickButton = UIButton(frame: CGRect(x: 0, y: 0, width: topView.frame.width * 0.075, height: topView.frame.height * 0.75))
        quickButton.setTitle("Quick", for: .normal)
        quickButton.addTarget(self, action: #selector(quickSort(sender:)), for: .touchUpInside)
        quickButton.center = CGPoint(x: (topView.frame.width * 0.65) + shift, y: topView.frame.height / 2)
        quickButton.backgroundColor = UIColor.white
        quickButton.setTitleColor(UIColor.black, for: .normal)
        quickButton.layer.cornerRadius = 8.0
        quickButton.layer.masksToBounds = true
        quickButton.titleLabel?.font = UIFont.init(name: "CourierNewPSMT", size: 16)
        quickButton.titleLabel?.textAlignment = .center
        buttons.append(quickButton)
        topView.addSubview(quickButton)
        
        timeBox = UITextView(frame: CGRect(x: 0, y: 0, width: topView.frame.width * 0.2, height: topView.frame.height * 0.75))
        timeBox.center = CGPoint(x: (topView.frame.width * 0.15), y: topView.frame.height * 0.5)
        timeBox.layer.cornerRadius = 8.0
        timeBox.layer.masksToBounds = true
        timeBox.font = UIFont.init(name: "CourierNewPSMT", size: 16)
        timeBox.backgroundColor = UIColor.white
        timeBox.textColor = UIColor.black
        timeBox.centerVertically()
        updateTime()
        timeBox.isEditable = false
        topView.addSubview(timeBox)
        sliderValueDidChange(sender: slider)
    }
    
    @objc func sliderValueDidChange(sender:UISlider!){
        sliderBox.text = "\(Int(sender.value))"
        if(Int(sender.value) != lastKnownSliderValue){
            lastKnownSliderValue = Int(sender.value)
            for i in box.subviews{
                i.removeFromSuperview()
            }
            for collection in box.subviews{
                collection.removeFromSuperview()
            }
            barCollection = BarColletion(bars: Int(sender.value), box: box)
            box.addSubview(barCollection.getView())
        }
    }
    
    @objc func randomize(sender: UIButton){
        print("randomized pressed")
        for i in box.subviews{
            i.removeFromSuperview()
        }
        for collection in box.subviews{
            collection.removeFromSuperview()
        }
        barCollection = BarColletion(bars: lastKnownSliderValue, box: box)
        box.addSubview(barCollection.getView())
    }
    
    @objc func bubbleSort(sender: UIButton){
        print("bubbleSortPressed")
        if(!barCollection.getSorted()){
            stopButtons()
            startTimer()
            barCollection.bubble()
        }
    }
    
    @objc func quickSort(sender: UIButton){
        print("quickSortPressed")
        if(!barCollection.getSorted()){
            stopButtons()
            startTimer()
            barCollection.quickSetup()
        }
    }
    
    @objc func selectionSort(sender: UIButton){
        print("selectionSortPressed")
        if(!barCollection.getSorted()){
            stopButtons()
            startTimer()
            barCollection.selection()
        }
    }
    
    func startTimer(){
        timeMillis = 0
        timeSeconds = 0
        updateTime()
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(checkTimer(sender:)), userInfo: nil, repeats: true)
    }
    
    @objc func checkTimer(sender: Timer){
        if barCollection.getSorted() {
            sender.invalidate()
        }
        timeMillis += 1
        if timeMillis >= 100{
            timeMillis = 0
            timeSeconds += 1
        }
        updateTime()
    }
    
    func updateTime(){
        if timeMillis > 9{
            timeBox.text = "Sort Time: \(timeSeconds).\(timeMillis)"
        } else {
            timeBox.text = "Sort Time: \(timeSeconds).0\(timeMillis)"
        }
    }
    
    func stopButtons(){
        for button in buttons{
            button.isEnabled = false
        }
        slider.isEnabled = false
        DispatchQueue.global(qos: .background).async {
            repeat{
                print("not enabled")
                let second: Double = 1000000
                usleep(useconds_t(1 * second))
            } while !self.barCollection.getSorted()
            DispatchQueue.main.async {
                print("enabled")
                for button in self.buttons{
                    button.isEnabled = true
                }
                self.slider.isEnabled = true
            }
        }
    }
}



extension UITextView {
    
    func centerVertically() {
        let fittingSize = CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let size = sizeThatFits(fittingSize)
        let topOffset = (bounds.size.height - size.height * zoomScale) / 2
        let positiveTopOffset = max(1, topOffset)
        contentOffset.y = -positiveTopOffset
    }
    
}
