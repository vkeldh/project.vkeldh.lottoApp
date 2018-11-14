//
//  MainViewController.swift
//  lottoApp
//
//  Created by padio on 2018. 4. 13..
//  Copyright © 2018년 padio. All rights reserved.
//

import UIKit
import GoogleMobileAds


class MainViewController:UIViewController{
    
    @IBOutlet var numberLabels: [UILabel]!

    var nums:[Int] = []
    
    @IBOutlet weak var bannerView: GADBannerView!
    
    let request:GADRequest = GADRequest()
    var interstitial: GADInterstitial!
    
    override func viewDidLoad() {
        
        self.creatdBannerLoad()
        self.nums = []
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
      
        self.navigationItem.title = "로또착히"
        self.navigationController?.setNavigationBarHidden(false, animated: true)
      
        self.navigationItem.hidesBackButton = true
        
        let images:UIImage = UIImage(named: "qrcodeIcon")!
        
        let imagelotto:UIImage = UIImage(named:"lottoSiteImage")!
        
      
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: images.resizedImage(newSize: CGSize(width: 30, height: 30)) ,style: .plain, target: self, action: #selector(self.leftBtnTap))
        //self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: imagelotto.resizedImage(newSize: CGSize(width: 30, height: 30)) ,style: .plain, target: self, action: #selector(self.rightBtnTap))
        
        self.navigationItem.rightBarButtonItem =   UIBarButtonItem(title: "나눔로또", style: .plain, target: self, action: #selector(self.rightBtnTap))
        //self.navigationItem.leftBarButtonItem =   UIBarButtonItem(title: "QR코드", style: .plain, target: self, action: #selector(self.leftBtnTap))
      //self.randomNum()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
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
            lottoDecoration(label: self.numberLabels[i],num: self.nums[i])
            
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
    
    @objc func rightBtnTap(){
        if let url = URL(string: "http://www.nlotto.co.kr") {
            UIApplication.shared.open(url, options: [:])
        }
        //"http://www.nlotto.co.kr/common.do?method=getLottoNumber&drwNo=+\(DataSwift.shared.num)"
       /* let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewcontroller = storyboard.instantiateViewController(withIdentifier: "ResultNumController")
        self.navigationController?.pushViewController(viewcontroller, animated: true)*/
    }
    
    @objc func leftBtnTap(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewcontroller = storyboard.instantiateViewController(withIdentifier: "QRcodeController")
        self.navigationController?.pushViewController(viewcontroller, animated: true)
    }
    
    
   
    
    func creatdBannerLoad(){
        self.bannerView.delegate = self
        //self.bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        self.bannerView.adUnitID = "ca-app-pub-7712497758110194/7119646855"
        self.bannerView.rootViewController = self
        self.bannerView.load(request)
    }
    
    func lottoDecoration(label:UILabel, num:Int){
        
        label.layer.cornerRadius  = label.frame.size.height/2
        label.clipsToBounds = true
        if 0<num && num<=10{
            //label.backgroundColor = UIColor.yellow
            label.backgroundColor = UIColor(red: 1, green: 204/255, blue: 0, alpha: 1)
            print("deco 1")
        }else if 10<num && num<=20{
            //label.backgroundColor = UIColor.blue
            label.backgroundColor = UIColor(red: 51/255, green: 51/255, blue: 1, alpha: 1)
            print("deco 2")
        }else if 20<num && num<=30{
            //  label.backgroundColor = UIColor.orange
            label.backgroundColor = UIColor(red: 255/255, green: 102/255, blue: 0, alpha: 1)
            print("deco 3")
        }else if 30<num && num<=40{
            //  label.backgroundColor = UIColor.gray
            label.backgroundColor = UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1)
            print("deco 4")
        }else if 40<num && num<=45{
            //  label.backgroundColor = UIColor.green
            label.backgroundColor = UIColor(red: 51/255, green: 153/255, blue: 51/255, alpha: 1)
            print("deco 5")
        }
      
    }
}



extension MainViewController:GADBannerViewDelegate{
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("adViewDidReceiveAd")
        
        bannerView.alpha = 0
        UIView.animate(withDuration: 1, animations: {
            bannerView.alpha = 1
        })
    }
    
    /// Tells the delegate an ad request failed.
    func adView(_ bannerView: GADBannerView,
                didFailToReceiveAdWithError error: GADRequestError) {
        print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }
    
    /// Tells the delegate that a full-screen view will be presented in response
    /// to the user clicking on an ad.
    func adViewWillPresentScreen(_ bannerView: GADBannerView) {
        print("adViewWillPresentScreen")
        
        
    }
    
    /// Tells the delegate that the full-screen view will be dismissed.
    func adViewWillDismissScreen(_ bannerView: GADBannerView) {
        print("adViewWillDismissScreen")
    }
    
    /// Tells the delegate that the full-screen view has been dismissed.
    func adViewDidDismissScreen(_ bannerView: GADBannerView) {
        print("adViewDidDismissScreen")
    }
    
    /// Tells the delegate that a user click will open another app (such as
    /// the App Store), backgrounding the current app.
    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
        print("adViewWillLeaveApplication")
        print("tap ad click")
        
    }
}
