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
import Kingfisher

class LibraryCell: UITableViewCell, View {
    typealias Reactor = LibraryCellReactor
    
    // MARK: Properties
   
    var disposeBag = DisposeBag()
    
    // MARK: UI
    
    let rootFlexContainer: UIView = UIView()
    let exerciseImageView = UIImageView()
    let nameLabel = UILabel().then {
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 16, weight: .medium)
    }
    let descriptionLabel = UILabel().then {
        $0.textColor = .darkGray
        $0.font = .systemFont(ofSize: 12, weight: .regular)
    }
    
    // MARK: Initializing
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initialize() {
        self.selectionStyle = .none
        self.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        self.contentView.addSubview(rootFlexContainer)
        setupConstraints()
    }
    
    // MARK: Binding
    
    func bind(reactor: Reactor) {
        self.exerciseImageView.kf.setImage(with: URL(string: reactor.currentState.image))
        self.nameLabel.text = reactor.currentState.name
        self.descriptionLabel.text = reactor.currentState.description
    }
    
    // MARK: Layout
    
    func setupConstraints() {
        self.rootFlexContainer.flex
            .direction(.row)
            .alignItems(.center)
            .define { flex in
                flex.addItem(self.exerciseImageView)
                    .height(60)
                    .width(60)
                    .marginLeft(20)
                flex.addItem()
                    .justifyContent(.center)
                    .alignItems(.start)
                    .marginLeft(10)
                    .define { flex in
                        flex.addItem(self.nameLabel)
                        flex.addItem(self.descriptionLabel)
                            .paddingTop(5)
                    }
            }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.rootFlexContainer.pin.all()
        self.rootFlexContainer.flex.layout()
    }
}
