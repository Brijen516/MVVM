//  UserViewModel.swift
//  MVVM
//  Created by Brijen Patel on 06/09/21.

import UIKit
import Alamofire

class UserViewModel {
    weak var vc: ViewController?
    var arrUsers = [UserModel]()
   
    func getAllUserDataAF() {
        
        AF.request("https://jsonplaceholder.typicode.com/todos/").response {
            response in
            if let data = response.data{
                do{
                    print("Fetch data")
                    let userResponse = try JSONDecoder().decode([UserModel].self, from: data)
                    self.arrUsers.append(contentsOf: userResponse)
                    
                    DispatchQueue.main.async {
                        
                        self.vc?.tableView.reloadData()
//                        self.vc?.tableView.refreshControl?.endRefreshing()
                    }
                }catch let err{
                    print(err.localizedDescription)
                }
            }
        }
    }

    func getAllUserData() {
        URLSession.shared.dataTask(with: URL(string:"https://jsonplaceholder.typicode.com/todos/")!) { (data, response, error)
            in
            if error == nil{
                do{
                    let userResponse = try JSONDecoder().decode([UserModel].self, from: data!)
                    self.arrUsers.append(contentsOf: userResponse)
                    DispatchQueue.main.async {
                        self.vc?.tableView.reloadData()
                    }
                }catch let err{
                    print(err.localizedDescription)
                }
            }
            else
            {
                print(error?.localizedDescription as Any)
            }
        }.resume()
    }
}


