//
//  LibraryViewController.swift
//  MinFit
//
//  Created by 노민희 on 2022/05/24.
//

import UIKit

import ReactorKit
import RxCocoa
import RxSwift

class LibraryViewController: UIViewController, View {
    var disposeBag = DisposeBag()
    
    init(reactor: LibraryViewReactor)  {
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(reactor: LibraryViewReactor) {
        reactor.action.onNext(Reactor.Action.refresh)
        
        reactor.state.asObservable().map { $0.exercises }
        .subscribe(onNext: { exercise in
            
        })
        .disposed(by: disposeBag)
    }
}
