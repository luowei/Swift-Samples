//
//  TypeCastViewController.swift
//  Swift-Samples
//
//  Created by luowei on 15/12/1.
//  Copyright © 2015年 wodedata. All rights reserved.
//

import UIKit

class TypeCastViewController: UIViewController {
    var library:[MediaItem]?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController!.navigationBar.isHidden = true
        self.tabBarController!.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController!.navigationBar.isHidden = false
        self.tabBarController!.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white

        library = [
            Movie(name: "Casablanca", director: "Michael Curtiz"),
            Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
            Movie(name: "Citizen Kane", director: "Orson Welles"),
            Song(name: "The One And Only", artist: "Chesney Hawkes"),
            Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
        ]
        // the type of "library" is inferred to be MediaItem[]
        
        let selfCenter = self.view.center;
        
        //检查类型
        let btn = UIButton(frame: CGRect(x: selfCenter.x - 50, y: selfCenter.y - 200, width: 100, height: 40))
        btn.backgroundColor = UIColor.gray
        btn.layer.cornerRadius = 10
        btn.setTitle("检查类型", for: UIControlState())
        btn.addTarget(self, action: #selector(TypeCastViewController.checkingType(_:)), for: .touchUpInside)
        self.view.addSubview(btn)
        
        //向下转型
        let btn2 = UIButton(frame: CGRect(x: selfCenter.x - 50, y: selfCenter.y - 50, width: 100, height: 40))
        btn2.backgroundColor = UIColor.gray
        btn2.layer.cornerRadius = 10
        btn2.setTitle("向下转型", for: UIControlState())
        btn2.addTarget(self, action: #selector(TypeCastViewController.downcasting(_:)), for: .touchUpInside)
        self.view.addSubview(btn2)
        
        //AnyObject类型
        let btn3 = UIButton(frame: CGRect(x: selfCenter.x - 80, y: selfCenter.y + 50, width: 160, height: 40))
        btn3.backgroundColor = UIColor.gray
        btn3.layer.cornerRadius = 10
        btn3.setTitle("AnyObject类型", for: UIControlState())
        btn3.addTarget(self, action: #selector(TypeCastViewController.anyObject(_:)), for: .touchUpInside)
        self.view.addSubview(btn3)
        
        //Any类型
        let btn4 = UIButton(frame: CGRect(x: selfCenter.x - 50, y: selfCenter.y + 200, width: 100, height: 40))
        btn4.backgroundColor = UIColor.gray
        btn4.layer.cornerRadius = 10
        btn4.setTitle("Any类型", for: UIControlState())
        btn4.addTarget(self, action: #selector(TypeCastViewController.any(_:)), for: .touchUpInside)
        self.view.addSubview(btn4)
        
    }
    
    
    //检查类型（Checking Type）
    func checkingType(_ btn: UIButton) {
        
        //检查类型（Checking Type）
        var movieCount = 0
        var songCount = 0
        for item in library! {
            if item is Movie {
                movieCount += 1
            } else if item is Song {
                songCount += 1
            }
        }
        print("Media library contains \(movieCount) movies and \(songCount) songs")
        // prints "Media library contains 2 movies and 3 songs"

    }
    
    
    //向下转型（Downcasting）
    func downcasting(_ btn: UIButton) {
        
        //向下转型（Downcasting）
        for item in library! {
            if let movie = item as? Movie {
                print("Movie: '\(movie.name)', dir. \(movie.director)")
            } else if let song = item as? Song {
                print("Song: '\(song.name)', by \(song.artist)")
            }
        }
        // Movie: 'Casablanca', dir. Michael Curtiz
        // Song: 'Blue Suede Shoes', by Elvis Presley
        // Movie: 'Citizen Kane', dir. Orson Welles
        // Song: 'The One And Only', by Chesney Hawkes
        // Song: 'Never Gonna Give You Up', by Rick Astley

    }
    
    
    //Any和AnyObject的类型转换
    //AnyObject类型
    func anyObject(_ btn: UIButton) {
        
        //AnyObject类型
        let someObjects: [AnyObject] = [
            Movie(name: "2001: A Space Odyssey", director: "Stanley Kubrick"),
            Movie(name: "Moon", director: "Duncan Jones"),
            Movie(name: "Alien", director: "Ridley Scott")
        ]
        
        for object in someObjects {
            let movie = object as! Movie
            print("Movie: '\(movie.name)', dir. \(movie.director)")
        }
        // Movie: '2001: A Space Odyssey', dir. Stanley Kubrick
        // Movie: 'Moon', dir. Duncan Jones
        // Movie: 'Alien', dir. Ridley Scott
        
        
        for movie in someObjects as! [Movie] {
            print("Movie: '\(movie.name)', dir. \(movie.director)")
        }
        // Movie: '2001: A Space Odyssey', dir. Stanley Kubrick
        // Movie: 'Moon', dir. Duncan Jones
        // Movie: 'Alien', dir. Ridley Scott

    }
    
    //Any类型
    func any(_ btn: UIButton) {
        
        //Any类型
        var things = [Any]()
        things.append(0)
        things.append(0.0)
        things.append(42)
        things.append(3.14159)
        things.append("hello")
        things.append((3.0, 5.0))
        things.append(Movie(name: "Ghostbusters", director: "Ivan Reitman"))
        things.append({ (name: String) -> String in "Hello, \(name)" })
        
        for thing in things {
            switch thing {
            case 0 as Int:
                print("zero as an Int")
            case 0 as Double:
                print("zero as a Double")
            case let someInt as Int:
                print("an integer value of \(someInt)")
            case let someDouble as Double where someDouble > 0:
                print("a positive double value of \(someDouble)")
            case is Double:
                print("some other double value that I don't want to print")
            case let someString as String:
                print("a string value of \"\(someString)\"")
            case let (x, y) as (Double, Double):
                print("an (x, y) point at \(x), \(y)")
            case let movie as Movie:
                print("a movie called '\(movie.name)', dir. \(movie.director)")
            case let stringConverter as (String) -> String:
                print(stringConverter("Michael"))
            default:
                print("something else")
            }
        }
        // zero as an Int
        // zero as a Double
        // an integer value of 42
        // a positive double value of 3.14159
        // a string value of "hello"
        // an (x, y) point at 3.0, 5.0
        // a movie called 'Ghostbusters', dir. Ivan Reitman
        // Hello, Michael
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}


class MediaItem {
    var name: String
    init(name: String) {
        self.name = name
    }
}

class Movie: MediaItem {
    var director: String
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
}

class Song: MediaItem {
    var artist: String
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}

