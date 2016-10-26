//: Playground - noun: a place where people can play

import UIKit


let string = "http://cdn-goeuro.com/static_content/web/logos/{size}/postbus.png"




let replaced = (string as NSString).replacingOccurrences(of: "{size}", with: "63")
