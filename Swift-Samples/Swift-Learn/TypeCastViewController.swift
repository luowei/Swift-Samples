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

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController!.navigationBar.hidden = true
        self.tabBarController!.tabBar.hidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController!.navigationBar.hidden = false
        self.tabBarController!.tabBar.hidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()

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
        let btn = UIButton(frame: CGRectMake(selfCenter.x - 50, selfCenter.y - 200, 100, 40))
        btn.backgroundColor = UIColor.grayColor()
        btn.layer.cornerRadius = 10
        btn.setTitle("检查类型", forState: .Normal)
        btn.addTarget(self, action: "checkingType:", forControlEvents: .TouchUpInside)
        self.view.addSubview(btn)
        
        //向下转型
        let btn2 = UIButton(frame: CGRectMake(selfCenter.x - 50, selfCenter.y - 50, 100, 40))
        btn2.backgroundColor = UIColor.grayColor()
        btn2.layer.cornerRadius = 10
        btn2.setTitle("向下转型", forState: .Normal)
        btn2.addTarget(self, action: "downcasting:", forControlEvents: .TouchUpInside)
        self.view.addSubview(btn2)
        
        //AnyObject类型
        let btn3 = UIButton(frame: CGRectMake(selfCenter.x - 80, selfCenter.y + 50, 160, 40))
        btn3.backgroundColor = UIColor.grayColor()
        btn3.layer.cornerRadius = 10
        btn3.setTitle("AnyObject类型", forState: .Normal)
        btn3.addTarget(self, action: "anyObject:", forControlEvents: .TouchUpInside)
        self.view.addSubview(btn3)
        
        //Any类型
        let btn4 = UIButton(frame: CGRectMake(selfCenter.x - 50, selfCenter.y + 200, 100, 40))
        btn4.backgroundColor = UIColor.grayColor()
        btn4.layer.cornerRadius = 10
        btn4.setTitle("Any类型", forState: .Normal)
        btn4.addTarget(self, action: "any:", forControlEvents: .TouchUpInside)
        self.view.addSubview(btn4)
        
    }
    
    
    //检查类型（Checking Type）
    func checkingType(btn: UIButton) {
        
        //检查类型（Checking Type）
        var movieCount = 0
        var songCount = 0
        for item in library! {
            if item is Movie {
                ++movieCount
            } else if item is Song {
                ++songCount
            }
        }
        print("Media library contains \(movieCount) movies and \(songCount) songs")
        // prints "Media library contains 2 movies and 3 songs"

    }
    
    
    //向下转型（Downcasting）
    func downcasting(btn: UIButton) {
        
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
    func anyObject(btn: UIButton) {
        
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
    func any(btn: UIButton) {
        
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
            case let stringConverter as String -> String:
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

