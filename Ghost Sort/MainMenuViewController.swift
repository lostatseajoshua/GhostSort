//
//  MainMenuViewController.swift
//  Ghost Sort
//
//  Created by Joshua Alvarado on 2/8/15.
//  Copyright (c) 2015 Joshua Alvarado. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {
    
    @IBOutlet weak var instructionsButton: UIButton!
    @IBOutlet weak var beginGameButton: UIButton!

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.instructionsButton.layer.cornerRadius = self.instructionsButton.bounds.size.width / 2
        self.beginGameButton.layer.cornerRadius = self.beginGameButton.bounds.size.width / 2
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func presentInstructionsView(sender: UIButton)
    {
        let instructionsView = self.storyboard?.instantiateViewControllerWithIdentifier("InstructionsView") as UIViewController
        self.presentViewController(instructionsView, animated: true, completion: nil)
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
