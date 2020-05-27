//
//  ViewController.swift
//  Oreno1App
//
//  Created by 矢野涼 on 2020-03-04.
//  Copyright © 2020 Ryo Yano. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage
import Photos

class ViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var topicImageView: UIImageView!
    @IBOutlet weak var commentTextView: UITextView!
    var count = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        commentTextView.layer.cornerRadius = 20.0
        PHPhotoLibrary.requestAuthorization{(states) in
            switch(states){
            case .authorized:break
            case .notDetermined:break
            case .restricted:break
            case .denied:break
            @unknown default:break
            }
        }
        getImages(keyword: "baseball")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchTextField.text = ""
        commentTextView.text = ""
    }
    //    検索キーワードの値をもとに画像を引っ張ってくる
        func getImages(keyword:String){
            let text = "https://pixabay.com/api/?key=2963093-768f9ffc11d874c5a568a82ee&q=\(keyword)"
            let url = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    //        Alamofireを使ってhttpリストを投げます。
            Alamofire.request(url, method: .get,parameters: nil, encoding:JSONEncoding.default).responseJSON{(response) in
                switch response.result{
                    //        値が帰ってきてそれをJson解析を行う
                    //        imageView.image に貼り付ける

                case .success:
                    let json:JSON = JSON(response.data as Any)
                    var imageString = json["hits"][self.count]["webformatURL"].string
                    if imageString == nil{
                        var imageString = json["hits"][0]["webformatURL"].string
                        self.topicImageView.sd_setImage(with: URL(string: imageString!), completed: nil)

                    }else{
                        self.topicImageView.sd_setImage(with: URL(string: imageString!), completed: nil)
                    }
                    
                case .failure(let error):
                    print(error)
                }
            }
        }
    @IBAction func nextTopic(_ sender: Any) {
        count = count + 1
        if searchTextField.text == ""{
            getImages(keyword: "baseball")
        }else{
            getImages(keyword: searchTextField.text!)
        }
    }
    @IBAction func searchAction(_ sender: Any) {
        self.count = 0
        if searchTextField.text == ""{
            getImages(keyword: "baseball")
        }else{
            getImages(keyword: searchTextField.text!)
        }
    }
    @IBAction func decisionAction(_ sender: Any) {
        performSegue(withIdentifier: "next", sender: nil)
        }

        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let nextVC = segue.destination as! Next1ViewController
            nextVC.resultImage = topicImageView.image!
            nextVC.commentString = commentTextView.text
    }
    
}

