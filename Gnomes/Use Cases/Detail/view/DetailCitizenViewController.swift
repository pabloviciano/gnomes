//
//  DetailCitizenViewController.swift
//  Gnomes
//
//  Created by Pablo Viciano Negre on 22/9/17.
//  Copyright © 2017 Pablo Viciano Negre. All rights reserved.
//

import UIKit

class DetailCitizenViewController: UIViewController, DetailCitizenView, UITableViewDataSource, UITableViewDelegate {
    
    static let StoryboardId = "DetailCitizenViewController"
    @IBOutlet weak var citizenImageView: UIImageView!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var hairColorLabel: UILabel!
    @IBOutlet weak var jobsAndFriendsTableView: UITableView!
    
    var viewModel: DetailCitizenViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        guard let viewModel = viewModel else {
            return
        }
        viewModel.load()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onLoad() {
        guard let viewModel = viewModel else {
            return
        }
        self.title = viewModel.name
        self.ageLabel.text = viewModel.age
        self.weightLabel.text = viewModel.weight
        self.heightLabel.text = viewModel.height
        self.hairColorLabel.text = viewModel.hairColor
        self.citizenImageView.image = viewModel.image
        self.jobsAndFriendsTableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let viewModel = self.viewModel else {
            return 0
        }
        return viewModel.numOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = self.viewModel else {
            return 0
        }
        return viewModel.numberOfItemsOn(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch DataSource(rawValue: indexPath.section)! {
        case .jobs:
            return tableView.dequeueReusableCell(withIdentifier: JobTableViewCell.CellIdentifier) as! JobTableViewCell
        case .friends:
            return tableView.dequeueReusableCell(withIdentifier: CitizenTableViewCell.CellIdentifier) as! CitizenTableViewCell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let viewModel = viewModel else {
            return nil
        }
        return viewModel.sectionTitleOn(section: section)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let viewModel = self.viewModel else {
            return
        }
        
        switch DataSource(rawValue: indexPath.section)! {
        case .jobs:
            guard let jobViewModel = viewModel.job(at: indexPath.row) else {
                return
            }
            let jobCell = cell as! JobTableViewCell
            jobCell.configure(with: jobViewModel)
        case .friends:
            guard let citizenViewModel = viewModel.friend(at: indexPath.row) else {
                return
            }
            let citizenCell = cell as! CitizenTableViewCell
            citizenViewModel.view = citizenCell
            citizenCell.configure(with: citizenViewModel )
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = self.viewModel else {
            return
        }
        
        switch DataSource(rawValue: indexPath.section)! {
        case .jobs:
            return
        case.friends:
            viewModel.selectFrient(at: indexPath.row)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
