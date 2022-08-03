//
//  LibraryCell.swift
//  MinFit
//
//  Created by 노민희 on 2022/05/30.
//

import UIKit

import FlexLayout
import ReactorKit
import RxSwift
import PinLayout

class LibraryCell: UITableViewCell, View {
    typealias Reactor = LibraryCellReactor
    
    // MARK: Properties
   
    var disposeBag = DisposeBag()
    
    // MARK: UI
    
    let rootFlexContainer: UIView = UIView()
    let exerciseImageView = UIImageView().then {
        $0.backgroundColor = .orange
    }
    let nameLabel = UILabel().then {
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 20, weight: .regular)
    }
    
    // MARK: Initializing
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Initializing
    
    func initialize() {
        self.contentView.addSubview(rootFlexContainer)
        self.rootFlexContainer.addSubview(self.exerciseImageView)
        self.rootFlexContainer.addSubview(self.nameLabel)
    }
    
    // MARK: Binding
    
    func bind(reactor: Reactor) {
        self.nameLabel.text = reactor.currentState.name
    }
    
    // MARK: Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.rootFlexContainer.pin.all()
        self.rootFlexContainer.flex.layout()
        
        self.rootFlexContainer.flex
            .direction(.row)
            .justifyContent(.start)
            .alignItems(.start)
            .define { flex in
                flex.addItem(self.exerciseImageView)
                    .height(60)
                    .aspectRatio(of: self.exerciseImageView)
                    .marginTop(10)
                    .marginLeft(20)
                    .marginBottom(10)
                flex.addItem(self.nameLabel)
                    .marginLeft(10)
            }
    }
}
