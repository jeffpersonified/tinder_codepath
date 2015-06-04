//
//  ProfileViewController.swift
//  tinder_codepath
//
//  Created by Jeff Smith on 6/3/15.
//  Copyright (c) 2015 Jeff Smith. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var ryanImageView: UIImageView!
    var ryanImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ryanImageView.image = ryanImage
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func didDismissRyan(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
