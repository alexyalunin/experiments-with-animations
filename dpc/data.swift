//
//  data.swift
//  dpc
//
//  Created by Alexander on 08/03/2017.
//  Copyright © 2017 Alexander. All rights reserved.
//

import Foundation

func getData() -> Array<Dictionary<String,String>> {
    
    var data = [
        [
            "title" : "Bug",
            "author": "Mike | Creative Mints",
            "image" : "image",
            "avatar": "avatar",
            "text"  : "You guys, the new How To Draw: drawing and sketching objects and environments from your imagination book by S. Robertson is just amazing! I spent the whole weekend gobbling it up and of course I couldn't help but take the watercolors myself! :)\nFill up the gas tank and go check out the attachment!\nBehance"
        ],
        [
            "title": "Secret Trips",
            "author": "Alexander Zaytsev",
            "image": "image2",
            "avatar": "avatar2",
            "text"  : "Hey,\nI'm working on app for tracking your trips.\nSee the attachments as always."
        ],
        [
            "title": "Ford Model T - Comic",
            "author": "Konstantin Datz",
            "image": "image3",
            "avatar": "avatar3",
            "text"  : "hey guys,\nhope you are doing well :)\ni was working on a comic version of the old Ford Model T in my spare time. im still not 100% happy with the background but wanted to come to an end.\nalso atteched the large version and if you are interested a comparison of the rendering and the postwork.\nplease let me know if you like it ♥\ncheers!"
        ],
        [
            "title": "Music",
            "author": "Rovane Durso",
            "image": "image4",
            "avatar": "avatar4",
            "text"  : "hope you all had a good weekend!\nbig pixel version attached."
        ],
        ]
    
    return data
}
