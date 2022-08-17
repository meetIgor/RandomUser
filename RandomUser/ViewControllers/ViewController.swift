//
//  ViewController.swift
//  RandomUser
//
//  Created by igor s on 17.08.2022.
//

import UIKit

class ViewController: UIViewController {
    
    private var ramndomUser = User(results: [], info: Info(infoData: [:]))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchRandomUser()
    }
    
    @IBAction func btnPressed(_ sender: Any) {
        print(ramndomUser.description)
    }
    
    //MARK: - Private Methods
    private func fetchRandomUser() {
        NetworkManager.shared.fetchUser(from: randomUserLink) { [ unowned self ] result in
            switch result {
            case .success(let user):
                self.ramndomUser = user
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

