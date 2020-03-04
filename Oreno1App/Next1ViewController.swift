//
//  Next1ViewController.swift
//  Oreno1App
//
//  Created by 矢野涼 on 2020-03-04.
//  Copyright © 2020 Ryo Yano. All rights reserved.
//

import UIKit

class Next1ViewController: UIViewController {

    var resultImage = UIImage()
    var commentString = String()
    var screenshotImage = UIImage()
    
    @IBOutlet weak var resultImageView: UIImageView!
    @IBOutlet weak var commentLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        resultImageView.image = resultImage
        commentLabel.text = commentString
        commentLabel.adjustsFontSizeToFitWidth = true
    }
    @IBAction func shareAction(_ sender: Any) {
        takeScreenShot()
        let items = [screenshotImage] as [Any]
        let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(activityVC,animated: true,completion: nil)
    }
    func takeScreenShot(){
        let width = CGFloat(UIScreen.main.bounds.size.width)
        let height = CGFloat(UIScreen.main.bounds.size.height/1.3)
        let size = CGSize(width: width, height: height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        self.view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        screenshotImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndPDFContext()
    }
    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }


}
