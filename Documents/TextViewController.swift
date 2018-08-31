//
//  TextViewController.swift
//  Documents
//
//  Created by Liam Flaherty on 8/29/18.
//  Copyright © 2018 Liam Flaherty. All rights reserved.
//

import UIKit

class TextViewController: UIViewController {

   
    
    @IBOutlet weak var TextBox: UITextView!
    @IBOutlet weak var TitleBox: UITextField!

    var URLcontents : URL?
    
    @IBAction func SaveDocument(_ sender: Any) {
        //need to have alert box if this stuff isnt entered in
        if(TextBox.text == nil){
            //need to have alert box if this stuff isnt entered in
            return
        }
        if(TitleBox.text == nil){
            //need to have alert box if this stuff isnt entered in
            return
        }

        let nameofTitle = TitleBox.text
        let text = TextBox.text
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        let name = getRidofExtension(path: (nameofTitle)!)
        let fileURL = documentsURL.appendingPathComponent(name).appendingPathExtension("txt")
        
        do{
            try text?.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
        }catch let error as NSError{
            print(error)
            }
      NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if URLcontents != nil{
            let temp = ((URLcontents?.absoluteString)! as NSString).lastPathComponent
            if temp.isEmpty{
                TitleBox.text = "Enter Title Here"
                TextBox.text = "Enter Text Here"
            }
            else{
                            do {
                                let text2 = try String(contentsOf: URLcontents!, encoding: .utf8)
                                TitleBox.text = temp
                                TextBox.text = text2
                            }catch{
                                TextBox.text = "Could not read file"
                            }
            }
        }
    }

    public func getRidofExtension(path : String)->String{
        
        if(path.contains(".")){
            var pathPart = path.split(separator: ".")
            return String(pathPart[0])
        }
        else{
            return path
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
