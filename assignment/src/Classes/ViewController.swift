//
//  ViewController.swift
//  assignment
//
//  Created by I0006 on 14/11/19.
//  Copyright © 2019 I0006. All rights reserved.
//

import UIKit
import Photos
import os.log
import Cloudinary
import GradientCircularProgress

class ViewController: UIViewController {

    // Must Change To Your CloudName
    var cld = CLDCloudinary(configuration: CLDConfiguration(cloudName: "Your-Cloud-Name", secure: false))

    var picker = UIImagePickerController()
    let imagePicker = UIImagePickerController()
    @IBOutlet var uploadImageView: UIImageView!
    
    @IBOutlet weak var uploadButton: UIButton!
    @IBOutlet weak var messageLabel: UILabel!

    var publicIDArray = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func uploadButtonTapped(_ sender: Any) {

        checkPermission()
    }
    
    @IBAction func nextvcButtonTapped(_ sender: Any) {
        
        if publicIDArray.count == 0 {
            self.showAlert(title: "OOPS!", message: "Till You didnot Upload Any Images Into Cloudinary")
        }else if publicIDArray.count == 1 {
            self.showAlert(title: "OOPS!", message: "You have upload atleast two images into Cloudnary")
        }else {
            performSegue(withIdentifier: "NextViewController", sender: self)
        }
    }
}

extension ViewController : UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func checkPermission() {

        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorizationStatus {
        case .authorized:
            print("Access is granted by user")
            accessDocsAndImages()
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({ newStatus in
                print("status is \(newStatus)")
                if newStatus == PHAuthorizationStatus.authorized {
                    /* do stuff here */
                    print("success")
                }
            })
        case .restricted:
            print("User do not have access to photo album.")
        case .denied:
            print("User has denied the permission.")
        @unknown default:
            print("Defults")
        }
        
    }

    func accessDocsAndImages() {
        
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .alert)
        
        let openCameraAction = UIAlertAction(title: "Camera", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            return
        })
        
        let openGalleryAction = UIAlertAction(title: "Open Gallery", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
            print("Opened gallery")
        })
        let openDocAction = UIAlertAction(title: "Open Documents", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in

            print("Opened gallery")
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler:
        {
            (alert: UIAlertAction!) -> Void in
            //            self.fileUploadImage.isHidden = false
            print("cancelled")
        })
        optionMenu.addAction(openGalleryAction)
        optionMenu.addAction(openCameraAction)
        optionMenu.addAction(openDocAction)
        optionMenu.addAction(cancelAction)
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            
            self.uploadImageView.image = pickedImage
            self.uploadImage()
        }
        dismiss(animated: true, completion: nil)
    }
    
    private func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        
        dismiss(animated: true, completion: nil)
    }
}

extension ViewController {

    fileprivate func getRect(_ view: UIView) -> CGRect {
        
        return view.bounds
    }
    
    func uploadImage() {

        let transformation = CLDTransformation().setWidth(340).setHeight(456).setCrop(.crop)
        // Get the image from cache or download it
        uploadImageView.cldSetImage(publicId: "true", cloudinary: cld, transformation: transformation)

        let progressIndicator = GradientCircularProgress()
        let baseView = uploadImageView
        var progressStyle = ProgressStyle()
        let frame = getRect(baseView!)
        progressStyle.progressSize = min(frame.width, frame.height) / 2
        let progressView = progressIndicator.showAtRatio(frame: frame, display: true, style: progressStyle)
            // Image was not uploaded to Cloudinary yet.
        if let data = uploadImageView.image!.jpegData(compressionQuality: 0.7) {
            showMessage("Uploading to Cloudinary")
            baseView!.addSubview(progressView!)
            let progressHandler = { (progress: Progress) in
                let ratio: CGFloat = CGFloat(progress.completedUnitCount) / CGFloat(progress.totalUnitCount)
                progressIndicator.updateRatio(ratio)
            }
            
            // Must Change To Your Preset
            let yourPreset = "Your-Preset"
            cld.createUploader().upload(data: data, uploadPreset: yourPreset, progress: progressHandler) { (result, error) in
                progressIndicator.dismiss(progress: progressView!)
                
                if let error = error {
                    os_log("Error uploading image %@", error)
                } else {
                    if let result = result, let publicId = result.publicId {
                        self.showMessage("Image uploaded to Cloudinary successfully")
                        self.hideMessage()
                        
                        print("result is-", result)
                        print("publicId is-", publicId)
                        
                        self.publicIDArray.append(publicId)
                    }
                }
            }
            }

    }
}

extension ViewController {
    
    //MARK:- Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "NextViewController") {
            
            let vc = segue.destination as! NextViewController
            vc.publicIDArray = self.publicIDArray
            print("publicIDArray count is :-", publicIDArray.count)
        }
    }
}

extension ViewController {
    
    public func showAlert(title: String, message: String?,_ handler: ((UIAlertAction) -> Swift.Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: handler))
        self.present(alert, animated: true, completion: nil)
    }
}
