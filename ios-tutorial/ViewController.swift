//
//  ViewController.swift
//  ios-tutorial
//
//  Created by 岩田彬広 on 2017/07/11.
//  Copyright © 2017年 com.Akihiro.Iwata. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    let indicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tapButton(_ sender: Any) {
        self.indicator.showIndicator(vc: self)
        DispatchQueue.global(qos: .default).async {
            sleep(2) // これがないと一瞬で終わってしまう
            self.getShowInfo()
            DispatchQueue.main.async {
                self.indicator.hideIndicator()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = indexPath.row.description
        return cell
    }
    
    func getShowInfo() {
        let url = NSURL(string:"https://slsstg.tokyodisneyresort.jp/api/GetShowInfo.php")!

        let request = NSMutableURLRequest(url: url as URL)
        let params = "Key=155&CheckType=1"
            
        request.httpMethod = "POST"
        request.httpBody = params.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            if error != nil{
                self.indicator.hideIndicator()
            }
            if let resData: Data = data {
                do {
                    if let json =  try JSONSerialization.jsonObject(with: resData, options: []) as? [String: Any] {
                        print(json["ShowList"])
                    }
                    self.indicator.hideIndicator()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
}

