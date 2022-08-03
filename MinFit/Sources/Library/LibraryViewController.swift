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
import RxDataSources
import RxSwift
import Then
import PinLayout

class LibraryViewController: UIViewController, View {
    // MARK: Properties
    
    var disposeBag = DisposeBag()
    let dataSource = RxTableViewSectionedReloadDataSource<LibrarySection>(
        configureCell: { dataSource, tableView, indexPath, reactor in
            let cell = tableView.dequeueReusableCell(withIdentifier: "LibraryCell") as! LibraryCell
            cell.reactor = reactor
            return cell
    })
    
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
            flex.addItem(self.tableView).height(100%)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.rootFlexContainer.pin.all(self.view.pin.safeArea)
        self.rootFlexContainer.flex.layout()
    }
    
    // MARK: Binding
    
    func bind(reactor: LibraryViewReactor) {
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        reactor.action.onNext(Reactor.Action.refresh)
        
        // State
        reactor.state.asObservable()
            .map { $0.exercises }
            .bind(to: self.tableView.rx.items(dataSource: self.dataSource))
            .disposed(by: disposeBag)
    }
}

extension LibraryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
