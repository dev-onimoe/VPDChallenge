//
//  ViewController.swift
//  VPDChallenge
//
//  Created by Masud Onikeku on 21/06/2024.
//

import UIKit
import SDWebImage

class HomeVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = ViewModel()
    var repos : [APIRepo] = []
    let rctrl = UIRefreshControl()
    //var currentPage = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Repositories"
        self.tableView.delegate = self
        self.tableView.refreshControl = rctrl
        rctrl.attributedTitle = NSAttributedString(string: "Pull down to refresh")
        self.rctrl.addTarget(self, action: #selector(refreshList), for: .valueChanged)
        self.tableView.refreshControl?.addTarget(self, action: #selector(refreshList), for: .valueChanged)
        self.tableView.dataSource = self
        self.tableView.showsVerticalScrollIndicator = false
        bind()
    }

    func bind() {
        
        viewModel.responseObserver.bind(completion: {[weak self] response in
            DispatchQueue.main.async {
                if self!.rctrl.isRefreshing {
                    self!.rctrl.endRefreshing()
                }
            }
            if let res = response {
                
                if res.successful {
                    
                    let reps = res.object as? [APIRepo]
                    if let reps = reps {
                        if self!.viewModel.page != 1 {
                            self?.repos.append(contentsOf: reps)
                        }else {
                            self!.repos = reps
                        }
                        DispatchQueue.main.async {
                            self?.tableView.reloadData()
                        }
                        self?.viewModel.updateCoreData(repos: self!.repos, page: String(self!.viewModel.page))
                    }
                }
            }
        })
        
        if let repos = CoreDataManager.shared.retrieveData() {
            
            let reps = repos.repos
            if !reps.isEmpty {
                self.repos.append(contentsOf: reps)
                print("count", reps.count)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            let pgg = UserDefaults.standard.object(forKey: "page") as? Int
            if let pggg = pgg  {
                viewModel.page = pggg
            }
            
        }else {
            viewModel.getData(page: viewModel.page)
        }
    }
    
    @objc func refreshList() {
        //rctrl.beginRefreshing()
        viewModel.page = 1
        viewModel.getData(page: viewModel.page)
    }

}

extension HomeVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        repos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        let repo = repos[indexPath.row]
        cell.name.text = repo.name
        cell.cellImage.layer.cornerRadius = cell.cellImage.frame.height / 2
        cell.cellImage.tintColor = UIColor.black.withAlphaComponent(0.3)
        cell.cellImage.sd_setImage(with: URL(string: repo.owner.avatar), placeholderImage: UIImage(systemName: "photo"))
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DetailsVC") as! DetailsVC
        vc.repo = repos[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == repos.count {
            
            let pages = UserDefaults.standard.object(forKey: "total_pages")as! Int
            if pages > (viewModel.page - 1) {
                viewModel.page = viewModel.page + 1
                
                viewModel.getData(page: viewModel.page)
                //homeUI!.showBottomIndicator()
            }
            
        }
    }
}

