//
//  CardsViewController.swift
//  Tinder
//
//  Created by Victoria Zhou on 4/5/17.
//  Copyright © 2017 Victoria Zhou. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {

    var cardInitialCenter: CGPoint!
    @IBOutlet weak var cardView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func rotateClockwise(angle: CGFloat) {
        cardView.transform = CGAffineTransform.identity
        let radians = angle / 180.0 * CGFloat(M_PI)
        //cardView.transform = cardView.transform.rotated(by: radians);
        cardView.transform = CGAffineTransform(rotationAngle: radians)
    }
    
    @IBAction func onPanCard(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        let velocity = sender.velocity(in: view)
        let location = sender.location(in: view)
        
        if sender.state == .began {
            print("Pan card began")
            cardView = sender.view as! UIImageView
            cardInitialCenter = cardView.center
        } else if sender.state == .changed {
            print("Pan card changing")
            let clockwiseAngle = (CGFloat.pi / 8) * (translation.x * 0.01)
            let counterclockwiseAngle = clockwiseAngle * -1
            
            if(velocity.x > 0) {
                // Rotate image clockwise
                //if(location.x > cardInitialCenter.y) {
                    cardView.transform = CGAffineTransform(rotationAngle: clockwiseAngle)
                //} else {
                    //cardView.transform = CGAffineTransform(rotationAngle: counterclockwiseAngle)
                //}
                
            }
            if (velocity.x < 0) {
                // Rotate image counterclockwise
                //if(location.x > cardInitialCenter.y) {
                    cardView.transform = CGAffineTransform(rotationAngle: counterclockwiseAngle)
                //} else {
                   // cardView.transform = CGAffineTransform(rotationAngle: clockwiseAngle)
                //}
               
            }
            
            cardView.center = CGPoint(x: cardInitialCenter.x + translation.x, y: cardInitialCenter.y)
            
        } else if sender.state == .ended {
            print("Pan card ended")
            
            if (translation.x > 50) {
                UIView.animate(withDuration: 0.4, animations: { 
                    self.cardView.center.x = 1000
                })
            } else if (translation.x < -50) {
                UIView.animate(withDuration: 0.4, animations: {
                    self.cardView.center.x = -1000
                })
            } else {
                cardView.center = cardInitialCenter
                cardView.transform = CGAffineTransform.identity
            }
        }
    }

    @IBAction func onTapCard(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "p_segue", sender: self)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let destination = segue.destination as! ProfileViewController
        destination.profileImage = cardView.image
    }
    

}
