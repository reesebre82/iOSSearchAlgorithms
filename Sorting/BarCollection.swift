//
//  BarCollection.swift
//  Sorting
//
//  Created by Brendan Reese on 12/18/19.
//  Copyright © 2019 BrendanReese. All rights reserved.
//

import UIKit

class BarCollection{
    
    private var rows: Int
    private var width: CGFloat
    private var view: UIView
    private var sorted: Bool
    
    private var collection: [Bar]
    
    init(bars: Int, box: UIView){
        rows = bars
        view = UIView(frame: CGRect(x: 0, y: 0, width: box.frame.width, height: box.frame.height))
        collection = [Bar]()
        width = CGFloat(Int(view.frame.width) / rows)
        sorted = false
        addBars()
    }
    
    func addBars(){
        for _ in 0 ..< rows{
            let height = CGFloat(Int.random(in: 1 ... Int(view.frame.height)))
            let bar = Bar(width: width, height: height)
            collection.append(bar)
            view.addSubview(bar.getView())
        }
        createDisplay()
    }
    
    func createDisplay(){
        for bar in view.subviews{
            bar.removeFromSuperview()
        }
        var i = 0
        for bar in collection{
            let height = bar.getView().frame.height
            let center = CGPoint(x: (width * CGFloat(i)), y: view.frame.height - height)
            bar.origin(point: center)
            i += 1
            view.addSubview(bar.getView())
        }
    }
    
    func getView() -> UIView{
        return view
    }
    
    func getSorted() -> Bool{
        return sorted
    }
    
    func bubble(){
        let length = collection.count
        var swapped = false
        DispatchQueue.global(qos: .background).async {
            repeat {
                swapped = false
                for i in 1 ... length - 1{
                    if self.collection[i - 1].getValue() > self.collection[i].getValue(){
                        let hold = self.collection[i - 1]
                        self.collection[i - 1] = self.collection[i]
                        self.collection[i] = hold
                        DispatchQueue.main.async {
                            self.collection[i].getView().backgroundColor = .green
                            self.collection[i - 1].getView().backgroundColor = .red
                        }
                        swapped = true
                    }else{
                        DispatchQueue.main.async {
                            self.collection[i].getView().backgroundColor = .white
                        }
                    }
                }
                DispatchQueue.main.async{
                    self.collection[0].getView().backgroundColor = .white
                    self.createDisplay()
                }
                let second: Double = 1000000
                usleep(useconds_t(0.01 * second))
                
                
            }while swapped == true//waits until after for loop
            DispatchQueue.main.async {
                self.clearChanges()
                self.sorted = true
            }
        }
    }
    
    func selection(){
        let length = collection.count
        DispatchQueue.global(qos: .background).async {
            for i in 0 ..< length-1{
                print(i)
                var min = i;
                for j in i+1 ..< length{
                    print(j)
                    if self.collection[j].getValue() < self.collection[min].getValue(){
                        min = j
                    }
                }
                let hold = self.collection[min]
                self.collection[min] = self.collection[i]
                self.collection[i] = hold
                DispatchQueue.main.async {
                    self.collection[i].getView().backgroundColor = .green
                    self.collection[min].getView().backgroundColor = .red
                    for test in 0..<self.collection.count{
                        if test != min && test != i{
                            self.collection[test].getView().backgroundColor = .white
                        }
                    }
                    self.createDisplay()
                }
                let second: Double = 1000000
                usleep(useconds_t(0.01 * second))
            }
            DispatchQueue.main.async {
                self.clearChanges()
                self.sorted = true
            }
        }
    }
    
    func quickSetup(){
        let length = collection.count - 1
        DispatchQueue.global(qos: .background).async {
            self.quick(low: 0, high: length)
            DispatchQueue.main.async {
                self.checkCollection()
            }
        }
    }
    
    
    private func partion(low:Int, high:Int) -> Int{
        let pivot = collection[high].getValue()
        var i = low - 1
        
        for j in low ... high-1{
            if collection[j].getValue() < pivot{
                i += 1
                let hold = self.collection[i]
                self.collection[i] = self.collection[j]
                self.collection[j] = hold
                DispatchQueue.main.async {
                    self.collection[i].getView().backgroundColor = .green
                    self.collection[j].getView().backgroundColor = .red
                    self.createDisplay()
                }
            }
        }
        let hold = self.collection[i+1]
        self.collection[i+1] = self.collection[high]
        self.collection[high] = hold
        DispatchQueue.main.async {
            self.collection[i+1].getView().backgroundColor = .green
            self.collection[high].getView().backgroundColor = .red
            self.createDisplay()
        }
        let second: Double = 1000000
        usleep(useconds_t(0.01 * second))
        DispatchQueue.main.async {
            self.clearChanges()
        }
        return i+1
    }
    
    
    func quick(low:Int, high:Int){
        if low < high{
            let pi = self.partion(low: low, high: high)
            self.quick(low: low, high: pi-1)
            self.quick(low: pi + 1, high: high)
        }
    }
    
    private func checkCollection(){
        var clear = true
        for i in 1 ..< collection.count{
            if(i-1 > i){
                clear = false
            }
        }
        if clear {
            self.sorted = true
            DispatchQueue.main.async {
                self.clearChanges()
            }
        }
    }
    
    func clearChanges(){
        for bar in collection{
            bar.getView().backgroundColor = UIColor.white
        }
    }
    
    func displayCollection(){
        for i in 0..<collection.count{
            print(collection[i].getValue())
        }
    }
}

