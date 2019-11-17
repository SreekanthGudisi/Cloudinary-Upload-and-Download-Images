//
//  NextViewController.swift
//  assignment
//
//  Created by I0006 on 15/11/19.
//  Copyright © 2019 I0006. All rights reserved.
//

import UIKit
import Cloudinary
import GradientCircularProgress

class NextViewController: BaseViewController {
  
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var firstImage: UIImageView!
    @IBOutlet weak var secondImage: UIImageView!
    
    // Must Change To Your CloudName
    var cld = CLDCloudinary(configuration: CLDConfiguration(cloudName: "Your-Cloud-Name", secure: false))
    var publicIDArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func fristButtonTapped(_ sender: Any) {
        
        firstImage.image = nil
        secondImage.image = nil
        let alertController = UIAlertController(title: "Downlaoding", message: "Width Resolution is 900 \n Height Resolution is 900 ", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in

            self.firstImagedownload()
        })
        let CancelAction = UIAlertAction(title: "Cancel", style: .default, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
        })
        alertController.addAction(OKAction)
        alertController.addAction(CancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func secondButtonTapped(_ sender: Any) {
        
        firstImage.image = nil
        secondImage.image = nil
        let alertController = UIAlertController(title: "Downlaoding", message: "Width Resolution is 1800 \n Height Resolution is 1800 ", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in

            self.firstImageDownloadForButton2()
        })
        let CancelAction = UIAlertAction(title: "Cancel", style: .default, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
        })
        alertController.addAction(OKAction)
        alertController.addAction(CancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func thirdButtonTapped(_ sender: Any) {
        
        firstImage.image = nil
        secondImage.image = nil
        let alertController = UIAlertController(title: "Downlaoding", message: "Width Resolution is 2700 \n Height Resolution is 2700 ", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in

            self.firstImageDownloadForButton3()
        })
        let CancelAction = UIAlertAction(title: "Cancel", style: .default, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
        })
        alertController.addAction(OKAction)
        alertController.addAction(CancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

extension NextViewController {

    fileprivate func getRect(_ view: UIView) -> CGRect {
        
        return view.bounds
    }
    
    func firstImagedownload() {

        let transformation = CLDTransformation().setWidth(340).setHeight(456).setCrop(.crop)
        // Get the image from cache or download it
        firstImage.cldSetImage(publicId: "true", cloudinary: cld, transformation: transformation)
        self.showLoadingIndicator()
        let count = publicIDArray.count
        if count == 1 {
            return
        } else {
         
            let arraySlice = publicIDArray.suffix(2)
            let newArray = Array(arraySlice)
            print("newArray is -", newArray)
          
            // Must Change To Your CloudName
            let yourCloudName = "Your-Cloud-Name"
            let url = "https://res.cloudinary.com/" + yourCloudName + "/image/upload/v1573812890/" + newArray[1] + ".jpg"

            let url1 = URL(string: url)
            self.cld.createDownloader().fetchImage(url, { (progress) in
        
            self.showMessage("Downloading from Cloudinary: \(Int(progress.fractionCompleted * 100))%")
            self.messageLabel.text = "Downloading from Cloudinary: \(Int(progress.fractionCompleted * 100))%"
            print("Downloading from Cloudinary: \(Int(progress.fractionCompleted * 100))%")
        }, completionHandler: { (result,error) in
            
            if let error = error {
                self.hideLoadingIndicator()
                print("Error downloading image %@", error)
            }
            else {
                print("Image downloaded from Cloudinary successfully")
                DispatchQueue.main.async {
                    
                    self.showMessage("Image downloaded from Cloudinary successfully")
                    self.messageLabel.text = "Image downloaded from Cloudinary successfully"
                }
                do{
                    let data = try Data(contentsOf: url1!)
                    DispatchQueue.main.async {
                        self.firstImage.image = UIImage(data: data)
                        self.hideMessage()
                        self.hideLoadingIndicator()
                        
                        self.firstImage.cldSetImage(self.cld.createUrl().setType( "fetch").setTransformation(CLDTransformation().setWidth(900).setHeight(900).setGravity("face").setRadius("max").setCrop("fill").setFetchFormat("auto")).generate(url)!, cloudinary: self.cld)
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
                        if self.publicIDArray.count != 1 {
                            self.secondImageDownload()
                        }
                    }
                }
                catch _ as NSError{
                    
                    self.hideLoadingIndicator()
                    self.showAlert(title: "Error", message: "There is error when downloading")
                }
            }
        })
        }
        
    }
    
    func secondImageDownload() {

        let transformation = CLDTransformation().setWidth(340).setHeight(456).setCrop(.crop)
        // Get the image from cache or download it
        firstImage.cldSetImage(publicId: "true", cloudinary: cld, transformation: transformation)
        self.showLoadingIndicator()
        let count = publicIDArray.count
        if count == 1 {
            return
        } else {
         
            let arraySlice = publicIDArray.suffix(2)
            let newArray = Array(arraySlice)
            print("newArray is -", newArray)
          
            // Must Change To Your CloudName
            let yourCloudName = "Your-Cloud-Name"
            let url = "https://res.cloudinary.com/" + yourCloudName + "/image/upload/v1573812890/" + newArray[1] + ".jpg"

            let url1 = URL(string: url)
            self.cld.createDownloader().fetchImage(url, { (progress) in
        
            self.showMessage("Downloading from Cloudinary: \(Int(progress.fractionCompleted * 100))%")
            self.messageLabel.text = "Downloading from Cloudinary: \(Int(progress.fractionCompleted * 100))%"
            print("Downloading from Cloudinary: \(Int(progress.fractionCompleted * 100))%")
        }, completionHandler: { (result,error) in
            
            if let error = error {
                self.hideLoadingIndicator()
                print("Error downloading image %@", error)
            }
            else {
                print("Image downloaded from Cloudinary successfully")
                DispatchQueue.main.async {
                    
                    self.showMessage("Image downloaded from Cloudinary successfully")
                    self.messageLabel.text = "Image downloaded from Cloudinary successfully"
                }
                do{
                    let data = try Data(contentsOf: url1!)
                    DispatchQueue.main.async {
                        self.secondImage.image = UIImage(data: data)
                        self.hideMessage()
                        self.hideLoadingIndicator()
                        
                        self.secondImage.cldSetImage(self.cld.createUrl().setType( "fetch").setTransformation(CLDTransformation().setWidth(900).setHeight(900).setGravity("face").setRadius("max").setCrop("fill").setFetchFormat("auto")).generate(url)!, cloudinary: self.cld)
                    }
                }
                catch _ as NSError{
                    
                    self.hideLoadingIndicator()
                    self.showAlert(title: "Error", message: "There is error when downloading")
                }
            }
        })
        }
        
    }
}

extension NextViewController {

    
    func firstImageDownloadForButton2() {

        let transformation = CLDTransformation().setWidth(340).setHeight(456).setCrop(.crop)
        // Get the image from cache or download it
        firstImage.cldSetImage(publicId: "true", cloudinary: cld, transformation: transformation)
        self.showLoadingIndicator()
        let count = publicIDArray.count
        if count == 1 {
            return
        } else {
         
            let arraySlice = publicIDArray.suffix(2)
            let newArray = Array(arraySlice)
            print("newArray is -", newArray)
          
            // Must Change To Your CloudName
            let yourCloudName = "Your-Cloud-Name"
            let url = "https://res.cloudinary.com/" + yourCloudName + "/image/upload/v1573812890/" + newArray[1] + ".jpg"

            let url1 = URL(string: url)
            self.cld.createDownloader().fetchImage(url, { (progress) in
        
            self.showMessage("Downloading from Cloudinary: \(Int(progress.fractionCompleted * 100))%")
            self.messageLabel.text = "Downloading from Cloudinary: \(Int(progress.fractionCompleted * 100))%"
            print("Downloading from Cloudinary: \(Int(progress.fractionCompleted * 100))%")
        }, completionHandler: { (result,error) in
            
            if let error = error {
                self.hideLoadingIndicator()
                print("Error downloading image %@", error)
            }
            else {
                print("Image downloaded from Cloudinary successfully")
                DispatchQueue.main.async {
                    
                    self.showMessage("Image downloaded from Cloudinary successfully")
                    self.messageLabel.text = "Image downloaded from Cloudinary successfully"
                }
                do{
                    let data = try Data(contentsOf: url1!)
                    DispatchQueue.main.async {
                        self.firstImage.image = UIImage(data: data)
                        self.hideMessage()
                        self.hideLoadingIndicator()
                        
                        self.firstImage.cldSetImage(self.cld.createUrl().setType( "fetch").setTransformation(CLDTransformation().setWidth(1800).setHeight(1800).setGravity("face").setRadius("max").setCrop("fill").setFetchFormat("auto")).generate(url)!, cloudinary: self.cld)
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
                        if self.publicIDArray.count != 1 {
                            self.secondImageDownloadForButton2()
                        }
                    }
                }
                catch _ as NSError{
                    
                    self.hideLoadingIndicator()
                    self.showAlert(title: "Error", message: "There is error when downloading")
                }
            }
        })
        }
        
    }
    
    func secondImageDownloadForButton2() {

        let transformation = CLDTransformation().setWidth(340).setHeight(456).setCrop(.crop)
        // Get the image from cache or download it
        firstImage.cldSetImage(publicId: "true", cloudinary: cld, transformation: transformation)
        self.showLoadingIndicator()
        let count = publicIDArray.count
        if count == 1 {
            return
        } else {
         
            let arraySlice = publicIDArray.suffix(2)
            let newArray = Array(arraySlice)
            print("newArray is -", newArray)
          
            // Must Change To Your CloudName
            let yourCloudName = "Your-Cloud-Name"
            let url = "https://res.cloudinary.com/" + yourCloudName + "/image/upload/v1573812890/" + newArray[1] + ".jpg"

            let url1 = URL(string: url)
            self.cld.createDownloader().fetchImage(url, { (progress) in
        
            self.showMessage("Downloading from Cloudinary: \(Int(progress.fractionCompleted * 100))%")
            self.messageLabel.text = "Downloading from Cloudinary: \(Int(progress.fractionCompleted * 100))%"
            print("Downloading from Cloudinary: \(Int(progress.fractionCompleted * 100))%")
        }, completionHandler: { (result,error) in
            
            if let error = error {
                self.hideLoadingIndicator()
                print("Error downloading image %@", error)
            }
            else {
                print("Image downloaded from Cloudinary successfully")
                DispatchQueue.main.async {
                    
                    self.showMessage("Image downloaded from Cloudinary successfully")
                    self.messageLabel.text = "Image downloaded from Cloudinary successfully"
                }
                do{
                    let data = try Data(contentsOf: url1!)
                    DispatchQueue.main.async {
                        self.secondImage.image = UIImage(data: data)
                        self.hideMessage()
                        self.hideLoadingIndicator()
                        
                        self.secondImage.cldSetImage(self.cld.createUrl().setType( "fetch").setTransformation(CLDTransformation().setWidth(1800).setHeight(1800).setGravity("face").setRadius("max").setCrop("fill").setFetchFormat("auto")).generate(url)!, cloudinary: self.cld)
                    }
                }
                catch _ as NSError{
                    
                    self.hideLoadingIndicator()
                    self.showAlert(title: "Error", message: "There is error when downloading")
                }
            }
        })
        }
        
    }
}

extension NextViewController {

    
    func firstImageDownloadForButton3() {

        let transformation = CLDTransformation().setWidth(340).setHeight(456).setCrop(.crop)
        // Get the image from cache or download it
        firstImage.cldSetImage(publicId: "true", cloudinary: cld, transformation: transformation)
        self.showLoadingIndicator()
        let count = publicIDArray.count
        if count == 1 {
            return
        } else {
         
            let arraySlice = publicIDArray.suffix(2)
            let newArray = Array(arraySlice)
            print("newArray is -", newArray)
          
            // Must Change To Your CloudName
            let yourCloudName = "Your-Cloud-Name"
            let url = "https://res.cloudinary.com/" + yourCloudName + "/image/upload/v1573812890/" + newArray[1] + ".jpg"

            let url1 = URL(string: url)
            self.cld.createDownloader().fetchImage(url, { (progress) in
        
            self.showMessage("Downloading from Cloudinary: \(Int(progress.fractionCompleted * 100))%")
            self.messageLabel.text = "Downloading from Cloudinary: \(Int(progress.fractionCompleted * 100))%"
            print("Downloading from Cloudinary: \(Int(progress.fractionCompleted * 100))%")
        }, completionHandler: { (result,error) in
            
            if let error = error {
                self.hideLoadingIndicator()
                print("Error downloading image %@", error)
            }
            else {
                print("Image downloaded from Cloudinary successfully")
                DispatchQueue.main.async {
                    
                    self.showMessage("Image downloaded from Cloudinary successfully")
                    self.messageLabel.text = "Image downloaded from Cloudinary successfully"
                }
                do{
                    let data = try Data(contentsOf: url1!)
                    DispatchQueue.main.async {
                        self.firstImage.image = UIImage(data: data)
                        self.hideMessage()
                        self.hideLoadingIndicator()
                        
                        self.firstImage.cldSetImage(self.cld.createUrl().setType( "fetch").setTransformation(CLDTransformation().setWidth(2700).setHeight(2700).setGravity("face").setRadius("max").setCrop("fill").setFetchFormat("auto")).generate(url)!, cloudinary: self.cld)
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
                        if self.publicIDArray.count != 1 {
                            self.secondImageDownloadForButton3()
                        }
                    }
                }
                catch _ as NSError{
                    
                    self.hideLoadingIndicator()
                    self.showAlert(title: "Error", message: "There is error when downloading")
                }
            }
        })
        }
        
    }
    
    func secondImageDownloadForButton3() {

        let transformation = CLDTransformation().setWidth(340).setHeight(456).setCrop(.crop)
        // Get the image from cache or download it
        firstImage.cldSetImage(publicId: "true", cloudinary: cld, transformation: transformation)
        self.showLoadingIndicator()
        let count = publicIDArray.count
        if count == 1 {
            return
        } else {
         
            let arraySlice = publicIDArray.suffix(2)
            let newArray = Array(arraySlice)
            print("newArray is -", newArray)
          
            let yourCompanyName = "Your-Company-Name"
            let url = "https://res.cloudinary.com/" + yourCompanyName + "/image/upload/v1573812890/" + newArray[1] + ".jpg"

            let url1 = URL(string: url)
            self.cld.createDownloader().fetchImage(url, { (progress) in
        
            self.showMessage("Downloading from Cloudinary: \(Int(progress.fractionCompleted * 100))%")
            self.messageLabel.text = "Downloading from Cloudinary: \(Int(progress.fractionCompleted * 100))%"
            print("Downloading from Cloudinary: \(Int(progress.fractionCompleted * 100))%")
        }, completionHandler: { (result,error) in
            
            if let error = error {
                self.hideLoadingIndicator()
                print("Error downloading image %@", error)
            }
            else {
                print("Image downloaded from Cloudinary successfully")
                DispatchQueue.main.async {
                    
                    self.showMessage("Image downloaded from Cloudinary successfully")
                    self.messageLabel.text = "Image downloaded from Cloudinary successfully"
                }
                do{
                    let data = try Data(contentsOf: url1!)
                    DispatchQueue.main.async {
                        self.secondImage.image = UIImage(data: data)
                        self.hideMessage()
                        self.hideLoadingIndicator()
                        
                        self.secondImage.cldSetImage(self.cld.createUrl().setType( "fetch").setTransformation(CLDTransformation().setWidth(2000).setHeight(2000).setGravity("face").setRadius("max").setCrop("fill").setFetchFormat("auto")).generate(url)!, cloudinary: self.cld)
                    }
                }
                catch _ as NSError{
                    
                    self.hideLoadingIndicator()
                    self.showAlert(title: "Error", message: "There is error when downloading")
                }
            }
        })
        }
        
    }
}
extension NextViewController {
    
    public func showAlert(title: String, message: String?,_ handler: ((UIAlertAction) -> Swift.Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: handler))
        self.present(alert, animated: true, completion: nil)
    }
}
