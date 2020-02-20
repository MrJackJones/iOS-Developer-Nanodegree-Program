//
//  ViewController.swift
//  MemeMeND 1.0
//
//  Created by Ivan on 16.02.2020.
//  Copyright © 2020 Ivan Baranov. All rights reserved.
//


import UIKit

class ViewController : UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate, UITextFieldDelegate{

    var tCounter = 0
    var bCounter = 0
    
    @IBOutlet weak var innerView: UIView!
    
    @IBOutlet weak var topToolbar: UIToolbar!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    
    @IBOutlet weak var topFeild: UITextField!
    @IBOutlet weak var bottomFeild: UITextField!
   
    @IBOutlet weak var cancelButton:  UIBarButtonItem!
    @IBOutlet weak var albumButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    @IBOutlet weak var imagePickerView: UIImageView!

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        DisableSbAndCb()
        configureTextField(topFeild, text: "TOP TEXT")
        configureTextField(bottomFeild, text: "BOTTOM TEXT")
        
        topFeild.textAlignment = .center
        bottomFeild.textAlignment = .center

  
    }
    
    @IBAction func pickAnImage(_ sender: Any) {
        
        let buttonPressed = sender as! UIBarButtonItem

        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        

        if buttonPressed == cameraButton {
             pickerController.sourceType = .camera
        }
        else if buttonPressed == albumButton {
            pickerController.sourceType = .photoLibrary
        }
       
        present(pickerController, animated: true, completion: nil)
        EnableSbAndCb()
        
    }
    
    
    @IBAction func CancelReset(_ sender: Any) {
        
        imagePickerView.image = nil
        
        topFeild.text = "Top Text"
        bottomFeild.text = "Bottom Text"
        
        DisableSbAndCb()
        
        tCounter=0
        bCounter=0
        
    }
    
    @IBAction func ShareButtonPressed(_ sender: Any) {
        
        let memedImage = generateMemedImage()
        let activity = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        
        activity.completionWithItemsHandler = { (activityType, completed, returnedItems, activityError) -> Void in
        if completed {
                self.save(memedImage)
            }
        }
        present(activity, animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: true, completion: nil)
        
        DisableSbAndCb()
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
        if let image = info[.originalImage] as? UIImage {
            imagePickerView.image = image
            
            dismiss(animated: true, completion: nil)
        }
    }
    
    
    func save( _ memedImage : UIImage) {
        _ = Meme(topText: topFeild.text!, bottomText: bottomFeild.text!, originalImage: imagePickerView.image!, memedImage: memedImage)
    }
    
    
    func generateMemedImage() -> UIImage {
        
        HideNavTool()
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        ShowNavTool()
        
        return memedImage
    }
    
    func ShowNavTool () {
        
        self.innerView.isHidden = false
        self.topToolbar.isHidden = false
        self.bottomToolbar.isHidden = false
    }
    
    func HideNavTool (){
        
        self.innerView.isHidden = true
        self.topToolbar.isHidden = true
        self.bottomToolbar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
        
    }
    
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        
        if (bottomFeild.isEditing){
        view.frame.origin.y -= getKeyboardHeight(notification)
        }
        
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        
        view.frame.origin.y = 0
        
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
        
    }
    
    func textFieldShouldReturn(_ textFeild: UITextField) -> Bool {
        
        self.view.endEditing(true)
        return false
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        cancelButton.isEnabled = true
        if textField == topFeild &&  tCounter == 0{
            textField.text = ""
            tCounter+=1
        }
        else if textField == bottomFeild &&  bCounter == 0 {
            textField.text = ""
            bCounter+=1
        }
        
    }
    
    func EnableSbAndCb (){
        
        shareButton.isEnabled = true
        cancelButton.isEnabled = true
        
    }
    
    func DisableSbAndCb (){
        
        shareButton.isEnabled = false
        cancelButton.isEnabled = false
        
    }
    
    func configureTextField(_ textField: UITextField, text: String) {
        
        textField.text = text
        textField.delegate = self
        textField.defaultTextAttributes = [
            .font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            .foregroundColor: UIColor.white,
            .strokeColor: UIColor.black,
            .strokeWidth: -2.5
        ]
    }

    struct Meme {
        let topText: String!
        let bottomText: String!
        let originalImage: UIImage!
        let memedImage: UIImage!
    }
}

