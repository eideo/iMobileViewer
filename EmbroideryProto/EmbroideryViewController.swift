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
            BinaryHelper.load(url: URL(string: "https://embroideres.com/index.php/download_file/bsdF*slesh*oXOlHE=/29971/")!, to: URL(string: String(describing: path))!, completion: {
                let file: FileHandle? = try! FileHandle(forReadingFrom: URL(string: String(describing: path))!)
                if file == nil {
                    print("File open failed")
                } else {
                    let pattern = FormatExp.Read(file: file!)
                    self.stitchView.setPattern(pattern)
                    file?.closeFile()
                }
            })
        }
        self.stitchView.setNeedsDisplay()
    }

}

