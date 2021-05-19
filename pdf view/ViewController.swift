//
//  ViewController.swift
//  pdf view
//
//  Created by Adsum MAC 2 on 19/05/21.
//

import UIKit

import QuickLook


class ViewController: UIViewController,QLPreviewControllerDataSource {
    
    var itemURL = URL(string: "" )
    var fileURL = URL(string: "" )
    
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 1
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
       
           return fileURL! as QLPreviewItem
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
      
      
      test()
    }

    func test() {
        
        guard let item = URL(string: "") else { // drop here pdf url
                     print("URL Not Found")
                    return
                }
                itemURL = item
                let doctext = "\(itemURL!.lastPathComponent)"
                let quickLookController = QLPreviewController()
                quickLookController.dataSource = self
                
                do {
              
                    let data = try Data(contentsOf: itemURL!)
                    
                    // Give the file a name and append it to the file path
                    if #available(iOS 10.0, *) {
                        fileURL = FileManager().temporaryDirectory.appendingPathComponent(doctext)
                    } else {
                        // Fallback on earlier versions
                    }
                    // Write the pdf to disk
                    try data.write(to: fileURL!, options: .atomic)
                    
                    // Make sure the file can be opened and then present the pdf
                    quickLookController.currentPreviewItemIndex = 0
                    present(quickLookController, animated: true, completion: nil)

                } catch {
                    // cant find the url resource
                    print("could not download")
                }
    }

}

