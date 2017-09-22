//
//  ViewController.swift
//  Gnomes
//
//  Created by Pablo Viciano Negre on 20/9/17.
//  Copyright © 2017 Pablo Viciano Negre. All rights reserved.
//

import UIKit

class CitizenTableViewController: UITableViewController, CitizensView {
    static let StoryboardId = "CitizenTableViewController"
    var viewModel: CitizensViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        guard let viewModel = viewModel else {
            return
        }
        self.title = viewModel.name()
        viewModel.load()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else {
            return 0
        }
        return viewModel.numberOfCitizens()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CitizenTableViewCell.CellIdentifier) as! CitizenTableViewCell
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let citizenCell = cell as! CitizenTableViewCell
        guard let viewModel = viewModel, let cellViewModel = viewModel.citizenAt(index: indexPath.row) else {
            return
        }
        cellViewModel.view = citizenCell
        citizenCell.configure(with: cellViewModel)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel else {
            return
        }
        viewModel.selectCitizen(at: indexPath.row)
    }
    
    func onLoadEvent() {
        self.tableView.reloadData()
    }
    
}

