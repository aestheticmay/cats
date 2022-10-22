//
//  RegistrationCheckList.swift
//  cats
//
//  Created by Майя Калицева on 17.10.2022.
//

import UIKit

final class RegistrationCheckList: UITableViewCell {
    
    // Mark: Public Properties
    
    var title: UILabel = {
        let lbl = UILabel()
        lbl.text = "What type of project will you use the API for?"
        lbl.numberOfLines = 0
        lbl.textAlignment = .left
        return lbl
    }()
    
    var button1: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.red
        return btn
    }()
    
    var button2: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.yellow
        return btn
    }()
    
    var button3: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.green
        return btn
    }()
    
    // Mark: Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        setupCellStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Mark: Private Methods
    
    private func setupCellStyle() {
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    private func setupLayout() {
        addSubview(title)
        addSubview(button1)
        addSubview(button2)
        addSubview(button3)
        
        title.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.leading.trailing.equalToSuperview().inset(10)
            make.bottom.equalTo(button1.snp.top).inset(-20)
        }
        
        button1.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).inset(-20)
            make.leading.trailing.equalToSuperview().inset(10)
            make.bottom.equalTo(button2.snp.top).inset(-15)
        }
        
        button2.snp.makeConstraints { make in
            make.top.equalTo(button1.snp.bottom).inset(15)
            make.leading.trailing.equalToSuperview().inset(10)
            make.bottom.equalTo(button3.snp.top).inset(-15)
        }
        
        button3.snp.makeConstraints { make in
            make.top.equalTo(button2.snp.bottom).inset(15)
            make.leading.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview()
        }
    }
}
