//
//  DetailViewController.swift
//  TestTrabjo
//
//  Created by Sebastian Abarzua on 3/8/19.
//  Copyright © 2019 SebastianAbarzua. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController{
    
    @IBOutlet weak var TitleMain: UILabel!
    @IBOutlet weak var ImgMain: UIImageView!
    @IBOutlet weak var Popularity: UILabel!
    @IBOutlet weak var LegOrigin: UILabel!
    @IBOutlet weak var TitOrigin: UILabel!
    @IBOutlet weak var Date: UILabel!
    @IBOutlet weak var Overview: UITextView!
    
    var titileMovie: String!
    var popularity: String!
    var imgMovie: UIImage!
    var legOrigin: String!
    var titOrigin: String!
    var date: String!
    var overview: String!
    
    override func viewDidLoad() {
        TitleMain.text = titileMovie
        Popularity.text = popularity
        ImgMain.image = imgMovie
        LegOrigin.text = legOrigin
        TitOrigin.text = titOrigin
        Date.text = date
        Overview.text = overview
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
