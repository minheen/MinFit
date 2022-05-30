//
//  LibraryViewReactor.swift
//  MinFit
//
//  Created by 노민희 on 2022/05/24.
//

import Foundation

import Firebase
import ReactorKit
import RxSwift

final class LibraryViewReactor: Reactor {
    
    enum Action {
        case refresh
//        case detail
    }
    
    enum Mutation {
        case setExercises([Exercise])
    }
    
    struct State {
        var exercises: [Exercise]
    }
    
    let initialState: State
    
    init() {
        self.initialState = State(exercises: [])
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .refresh:
            return self.fetchExerciseList()
                .map { exercises in
                    return .setExercises(exercises)
                }
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case let .setExercises(exercises):
            state.exercises = exercises
            return state
        }
    }
    
    func fetchExerciseList() -> Observable<[Exercise]> {
        return Observable.create { observer in
            let db = Database.database().reference().child("Library")
            db.observeSingleEvent(of: .value) { snapshop in
                guard let snapshop = snapshop.children.allObjects as? [DataSnapshot] else { return }
                let value = snapshop.compactMap { $0.value as? [String: Any] }
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: value, options: [])
                    let exercises = try JSONDecoder().decode([Exercise].self, from: jsonData)
                    observer.onNext(exercises)
                } catch let error {
                    print(error.localizedDescription)
                }
            }
            return Disposables.create()
        }
    }
}
