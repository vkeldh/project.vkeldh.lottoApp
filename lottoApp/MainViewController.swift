//
//  MainViewController.swift
//  lottoApp
//
//  Created by padio on 2018. 4. 13..
//  Copyright © 2018년 padio. All rights reserved.
//

import UIKit

class MainViewController:UIViewController{
    
    @IBOutlet var numberLabels: [UILabel]!

    var nums:[Int] = []
    
    override func viewDidLoad() {
        self.nums = []
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.randomNum()
    }
    @IBAction func newBtnTap(_ sender: Any) {
        self.randomNum()
    }
  
    func randomNum(){
        self.nums = []
        
        while self.nums.count < 6{
            let num = Int(arc4random_uniform(45))
            var equalCheck:Bool = false
            for i in 0..<self.nums.count{
                if self.nums[i] == num + 1{
                   equalCheck = true
                }
            }
            if !equalCheck{
                  self.nums.append(num + 1)
            }
        }
        self.nums = self.bubbleSort(arr: self.nums)
        
        for i in 0..<6{
            self.numberLabels[i].text = String(self.nums[i])
        }
        print(self.nums)
    }
    func bubbleSort(arr: [Int]) -> [Int]{
        var array:[Int] = arr
        
        var key : Int =  0
        
        for i in 0..<array.count{
            for j in 0..<array.count-1-i{
                if(array[j]>array[j+1]){
                    array.swapAt(j, j+1)
                }
            }
        }
        return array
    }
}
