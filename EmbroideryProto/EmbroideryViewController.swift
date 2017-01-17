//
//  ViewController.swift
//  EmbroideryProto
//
//  Created by Mark Siffer on 1/14/17.
//  Copyright © 2017 Mark Siffer. All rights reserved.
//

import UIKit

class EmbroideryViewController: UIViewController {
    
    
    @IBOutlet weak var stitchView: StitchView! {
        didSet {
            stitchView.addGestureRecognizer(UIPinchGestureRecognizer(
                target: stitchView,
                action: #selector(StitchView.changeScale(_:))
            ))
        }
    }

    @IBAction func btnDraw(_ sender: UIButton) {
        let file = "somefile.exp"
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let path = dir.appendingPathComponent(file)
            BinaryHelper.load(url: URL(
                string: "https://github.com/Embroidermodder/Embroidermodder/blob/master/test-designs/Star.PCS?raw=true")!,
                to: URL(string: String(describing: path))!,
                completion: {filename in
                    let file: FileHandle? = try! FileHandle(forReadingFrom: URL(string: String(describing: path))!)
                        if file == nil {
                            print("File open failed")
                        } else {
                            var pattern : EmbPattern
                            let fileextension = String(filename.characters.suffix(3)).lowercased()
                            if fileextension == "exp"  {
                                pattern = FormatExp.read(file: file!)
                            } else if fileextension == "pcs" {
                                pattern = FormatPcs.read(file: file!)
                            } else {
                                pattern = EmbPattern()
                            }
                            self.stitchView.setPattern(pattern)
                            file?.closeFile()
                            DispatchQueue.main.async {
                                self.stitchView.setNeedsDisplay()
                            }
                        }
                })
        }
    }

}

