//
//  LibraryViewController.swift
//  MinFit
//
//  Created by 노민희 on 2022/05/24.
//

import UIKit

import FlexLayout
import ReactorKit
import RxCocoa
import RxSwift
import Then
import PinLayout

class LibraryViewController: UIViewController, View {
    // MARK: Properties
    
    var disposeBag = DisposeBag()
    
    // MARK: UI
    
    let rootFlexContainer: UIView = UIView()
    let tableView = UITableView(
        frame: .zero,
        style: .plain
    ).then {
        $0.backgroundColor = .white
        $0.register(LibraryCell.self, forCellReuseIdentifier: "LibraryCell")
    }
    
    // MARK: Initializing
    
    init(reactor: LibraryViewReactor)  {
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
    }
    
    // MARK: Layout
    
    func setupConstraints() {
        self.view.addSubview(self.rootFlexContainer)
        
        self.rootFlexContainer.flex.define { flex in
            flex.addItem(self.tableView)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.rootFlexContainer.pin.all(self.view.pin.safeArea)
        self.rootFlexContainer.flex.layout()
    }
    
    // MARK: bind
    
    func bind(reactor: LibraryViewReactor) {
        reactor.action.onNext(Reactor.Action.refresh)
        
        reactor.state.asObservable().map { $0.exercises }
        .subscribe(onNext: { exercise in
            
        })
        .disposed(by: disposeBag)
    }
}
