// ViewController.swift
// TechnologyAssisment
// Created by Mashhood Qadeer on 25/04/2025.

import UIKit
import Combine

class LandingScreen: UIViewController{

    @IBOutlet weak var listView: UITableView!
    let refreshControl = UIRefreshControl()
    
    var viewModel: LandingScreenViewModel = LandingScreenViewModel()
    var disposebag: Set<AnyCancellable> = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.styleNavigationBar()
        self.setupTableView()
        self.viewModel.fetchData()
    }
    
}
