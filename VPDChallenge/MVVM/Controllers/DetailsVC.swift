//
//  DetailsVC.swift
//  VPDChallenge
//
//  Created by Masud Onikeku on 21/06/2024.
//

import UIKit
import SDWebImage

class DetailsVC: UIViewController {
    
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var stack: UIStackView!
    @IBOutlet weak var repoName: UILabel!
    
    var repo : APIRepo? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let repo = repo {
            image.layer.cornerRadius = image.frame.height / 2
            image.tintColor = UIColor.black.withAlphaComponent(0.3)
            image.sd_setImage(with: URL(string: repo.owner.avatar), placeholderImage: UIImage(systemName: "photo"))
            repoName.text = repo.name
            populateFields(key: "id", value: String(repo.id))
            populateFields(key: "name", value: String(repo.name))
            
            if let desc = repo.descriptions {
                populateFields(key: "Description", value: desc)
            }
            populateFields(key: "url", value: repo.url)
        }
    }
    
    func populateFields(key: String, value: String) {
        
        let stack = UIStackView()
        stack.spacing = 8
        stack.axis = .vertical
        
        let title = UILabel()
        title.text = key.uppercased()
        title.font = UIFont.systemFont(ofSize: 12)
        title.textColor = .black
        
        let view = UIView()
        view.backgroundColor = yvTextbg
        view.layer.cornerRadius = 12
        
        let valueText = UILabel()
        valueText.text = value
        valueText.numberOfLines = 0
        title.font = UIFont.systemFont(ofSize: 12)
        valueText.textColor = valuebg
        view.addSubview(valueText)
        valueText.constraint(equalToTop: view.topAnchor, equalToBottom: view.bottomAnchor, equalToLeft: view.leadingAnchor, equalToRight: view.trailingAnchor, paddingTop: 10, paddingBottom: 10, paddingLeft: 12, paddingRight: 12)
        
        stack.addArrangedSubview(title)
        stack.addArrangedSubview(view)
        
        self.stack.addArrangedSubview(stack)
    }

}
