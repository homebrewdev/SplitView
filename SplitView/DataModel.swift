//
//  DataModel.swift
//  SplitView
//
//  Created by Egor Devyatov on 06.08.2019.
//  Copyright © 2019 Egor Devyatov. All rights reserved.
//

class DataModel {
    //let fotoBank: Array<Photo> = []
    
    init() {
        var i: Int = 1
        for _ in 1...10 {
            let photo = Photo(title: "Foto " + String(i),
                              subtitle: "Описание данной фото " + String(i))
            data.append(photo)
            i += 1
        }
        print(data)
    }
    
}
