//
//  StitchView.swift
//  EmbroideryProto
//
//  Created by Mark Siffer on 1/14/17.
//  Copyright © 2017 Mark Siffer. All rights reserved.
//

import UIKit

class StitchView: UIView {
    
    public var stitchBlocks : [StitchBlock] = [StitchBlock]()
    
    public func setStitchBlocks(_ instructions: [StitchBlock]) {
        self.stitchBlocks = instructions
    }
    
    var scale = CGFloat(0.9)

    func changeScale(_ recognizer : UIPinchGestureRecognizer) {
        switch recognizer.state {
        case .changed, .ended :
            scale *= recognizer.scale
            self.transform = CGAffineTransform(scaleX: scale, y: scale)
            recognizer.scale = 1
        default :
            break
        }
    }

    
    func drawStitches() {
        
        let context = UIGraphicsGetCurrentContext()
        
        
        // scale and translate to the standard cartesian coordinate system where the (0,0) is the center of the screen.
        context!.scaleBy(x: 1, y: -1);
        context!.translateBy(x: self.bounds.size.width*0.5, y: -self.bounds.size.height*0.5);
        
        for stitch in self.stitchBlocks {
            let path = UIBezierPath()
            var isFirst = true
            stitch.Color.setStroke()
            for item in stitch.Points {
                if isFirst {
                    path.move(to: CGPoint(x: item.x, y: item.y))
                    isFirst = false
                }
                else {
                    path.addLine(to: CGPoint(x: item.x, y:item.y))
                }
            }
            path.stroke()
        }
        
        
    }

    override func draw(_ rect: CGRect) {
        self.drawStitches()
    }

}
