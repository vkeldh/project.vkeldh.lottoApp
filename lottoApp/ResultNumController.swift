//
//  ResultNumController.swift
//  lottoApp
//
//  Created by 파디오 on 14/11/2018.
//  Copyright © 2018 padio. All rights reserved.
//

import UIKit

class ResultNumController: UIViewController{
    
    override func viewDidLoad() {
        ApiLoad()
    }
    let MainUrl:String = "http://www.nlotto.co.kr/common.do"//?method=getLottoNumber&drwNo=+"
    
    func ApiLoad(){
        let urlString =  (MainUrl as! String) + String(DataSwift.shared.Num)
        // self.channelSongs.removeAll()
        
        let url = NSURL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
        let request = NSMutableURLRequest(url: url as URL)
        
        //request.hea
        
      //  request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        // print("header\(UserDefaults.standard.string(forKey: "indj_token")! as! String)")
        
        // request.addValue(UserDefaults.standard.string(forKey: "indj_token")! as! String, forHTTPHeaderField: "Authentication")// 인증토근 추가 입력 공간
        request.timeoutInterval = 20 // 접속 데이터 받는 대기시간
        
        
        print("This URL \(urlString)")
        
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            guard error == nil else {
                print("This Api Error. Check it plz")
                print(error!)
             
                let alertController = UIAlertController(title: "네트워크오류",
                                                        message: "네트워크를 확인해 주세요.",
                                                        preferredStyle: .alert)
                let cancle = UIAlertAction(title: "OK", style: .default, handler: nil)
               
                
                
                return
            }
            guard let data = data else {
                print("Data is empty")
                
                
                let alertController = UIAlertController(title: "데이터 오류",
                                                        message: "데이터 정보나 url을 확인해주세요",
                                                        preferredStyle: .alert)
                let cancle = UIAlertAction(title: "OK", style: .default, handler: nil)
              
                
                return
            }
            
            do {
                
                let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
                
               
                print("complete this API. DATA check it\(json)")
                
              
            } catch {
                print("Error deserializing JSON: \(error)")
              
                
                
                let alertController = UIAlertController(title: "네트워크오류",
                                                        message: "네트워크를 확인해 주세요.",
                                                        preferredStyle: .alert)
                let cancle = UIAlertAction(title: "OK", style: .default, handler: nil)
            
                
            }
        }
        
        task.resume()
        
    }
}
