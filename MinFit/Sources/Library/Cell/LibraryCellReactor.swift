//
//  LibraryCellReactor.swift
//  MinFit
//
//  Created by 노민희 on 2022/08/01.
//

import ReactorKit

class LibraryCellReactor: Reactor {
    typealias Action = NoAction
    
    let initialState: Exercise
    
    init(exercise: Exercise) {
        self.initialState = exercise
    }
}
