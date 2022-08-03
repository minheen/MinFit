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
    let exerciseImageView = UIImageView()
    let titleLabel = UILabel().then {
            $0.textColor = .black
            $0.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        }
    
    // MARK: Initializing
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Binding
    
    func bind(reactor: Reactor) {
        self.nameLabel.text = reactor.currentState.name
    }
    
    // MARK: Layout
    
    func setupConstraints() {
        self.rootFlexContainer.flex
            .direction(.row)
            .justifyContent(.start)
            .alignItems(.start)
            .define { flex in
                flex.addItem(self.exerciseImageView)
                    .marginTop(10)
                    .marginLeft(20)
                    .marginBottom(10)
                    .aspectRatio(of: self.exerciseImageView)
                flex.addItem(self.titleLabel)
                    .marginLeft(10)
            }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.rootFlexContainer.pin.all()
        self.rootFlexContainer.flex.layout()
    }
}
