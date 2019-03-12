//
//  ViewController.swift
//  TestTrabjo
//
//  Created by Sebastian Abarzua on 3/7/19.
//  Copyright © 2019 SebastianAbarzua. All rights reserved.
//

import UIKit
import Alamofire
import AVFoundation

struct post {
    let id : Int;
    let nameMovie : String!
    let popularity : Double!
    let posterPath : String!
    let mainImage : UIImage!
    let original_language : String!
    let original_title : String!
    let overview : String!
    let release_date : String!
    
}

class TableViewController: UITableViewController {

    var posts = [post]()
    
    let URLthemoviedbPopular =  "https://api.themoviedb.org/3/movie/popular?api_key=34738023d27013e6d1b995443764da44"
    
    typealias JSONStandard = [String : AnyObject]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(URLthemoviedbPopular)
        tableView.estimatedRowHeight = 85.0
        tableView.rowHeight = UITableView.automaticDimension
        callAlamoFire(url: URLthemoviedbPopular)
        
    }
    
    func callAlamoFire(url : String){
        Alamofire.request(url).responseJSON(completionHandler: {
            response in
            self.parseData(JSONData: response.data!)
            
        })
    }
    
    func parseData(JSONData: Data) {
        do{
            var readableJSON = try JSONSerialization.jsonObject(with: JSONData, options: .mutableContainers) as! JSONStandard
            if let results = readableJSON["results"] as? [JSONStandard]{
                for i in 0..<results.count{
                    let item = results[i]
                    print(item)
                    let id = item["id"] as! Int
                    let title = item["title"] as! String
                    let popularity = item["popularity"] as! Double
                    let baseImagen = "http://image.tmdb.org/t/p/w500"
                    let posterPath = item["poster_path"] as! String
                    let imagen = baseImagen + posterPath
                    let mainImgURL = URL(string: imagen)
                    let mainImgData = NSData(contentsOf: mainImgURL!)
                    let mainImage = UIImage(data: mainImgData as! Data)
                    let original_language = item["original_language"] as! String
                    let original_title = item["original_title"] as! String
                    let overview = item["overview"] as! String
                    let release_date = item["release_date"] as! String
                    
                    posts.append(post.init(id: id, nameMovie: title, popularity: popularity, posterPath: posterPath, mainImage: mainImage, original_language: original_language, original_title: original_title, overview: overview, release_date: release_date))
                    self.tableView.reloadData()
                }
            }
        }
        catch{
            print(error)
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("hola seba")
        
        let indexPath = self.tableView.indexPathForSelectedRow?.row
        
        let vc = DetailViewController()
        
        vc.titileMovie = posts[indexPath!].nameMovie
        vc.imgMovie = posts[indexPath!].mainImage
        vc.popularity = String(posts[indexPath!].popularity)
        vc.legOrigin = posts[indexPath!].original_language
        vc.titOrigin = posts[indexPath!].original_title
        vc.date = posts[indexPath!].release_date
        vc.overview = posts[indexPath!].overview
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        let mainImageView = cell?.viewWithTag(1) as? UIImageView
        
        mainImageView?.image = posts[indexPath.row].mainImage
        
        let mainLabel = cell?.viewWithTag(2) as? UILabel
        
        mainLabel?.text = posts[indexPath.row].nameMovie
        
        let mainPopularity = cell?.viewWithTag(3) as? UILabel
        
        mainPopularity?.text = String(posts[indexPath.row].popularity)
        
        return cell!
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = self.tableView.indexPathForSelectedRow?.row
        
        let vc = segue.destination as! DetailViewController
        
        vc.titileMovie = posts[indexPath!].nameMovie
        vc.imgMovie = posts[indexPath!].mainImage
        vc.popularity = String(posts[indexPath!].popularity)
        vc.legOrigin = posts[indexPath!].original_language
        vc.titOrigin = posts[indexPath!].original_title
        vc.date = posts[indexPath!].release_date
        vc.overview = posts[indexPath!].overview
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

