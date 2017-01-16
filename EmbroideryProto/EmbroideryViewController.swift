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
        self.stitchView.setStitchBlocks(StitchBlock.Load())
        self.stitchView.setNeedsDisplay()
    }

}

