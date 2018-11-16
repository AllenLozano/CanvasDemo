//
//  CanvasViewController.swift
//  CanvasDemo
//
//  Created by Allen Lozano on 11/15/18.
//  Copyright © 2018 Allen Lozano. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController {

    @IBOutlet weak var trayView: UIView!
    var trayOriginalCenter: CGPoint!
    var trayDownOffset: CGFloat!
    var trayUp: CGPoint!
    var trayDown: CGPoint!
    var newlyCreatedFace: UIImageView!
    var newlyCreatedFaceOriginalCenter: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trayDownOffset = 265
        trayUp = trayView.center // The initial position of the tray
        trayDown = CGPoint(x: trayView.center.x ,y: trayView.center.y + trayDownOffset)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didPanTray(_ sender: UIPanGestureRecognizer) {
        
        let translation = sender.translation(in: view)
        
        
        if sender.state == .began {
            trayOriginalCenter = trayView.center
            print("Gesture began")
        } else if sender.state == .changed {
            trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
            print("Gesture is changing")  //trayOriginalCenter.x
        } else if sender.state == .ended {
            let velocity = sender.velocity(in: view)
            if (velocity.y > 0){
                UIView.animate(withDuration: 0.6, animations: { () -> Void in
                    self.trayView.center = self.trayDown!
                })
            }
            else{
                UIView.animate(withDuration: 0.6, animations: { () -> Void in
                    self.trayView.center = self.trayUp!
                })
            }
            print("Gesture ended")
        }
    }
    
    @IBAction func didPanFace(_ sender: UIPanGestureRecognizer) {
        
        let translation = sender.translation(in: view)
        
        if sender.state == .began {
            let imageView = sender.view as! UIImageView
            newlyCreatedFace = UIImageView(image: imageView.image)
            view.addSubview(newlyCreatedFace)
            newlyCreatedFace.center = imageView.center
            newlyCreatedFace.center.y += trayView.frame.origin.y
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
            
            print("Gesture began")
        } else if sender.state == .changed {
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
            print("Gesture is changing")
        } else if sender.state == .ended {
            
          
        }
    }
    
    
    
}
