//
//  ViewController.swift
//  Avito_intern
//
//  Created by Егор Куракин on 18.10.2022.


import UIKit

class ViewController: UIViewController{
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var employeesTable: UITableView!
    
    var dataSource = [NameCompany]()
    let apiManager = APIManager()
    override func viewDidLoad() {
        super.viewDidLoad()

        indicator.startAnimating()
        indicator.isHidden = false
        
        employeesTable.dataSource = self
        employeesTable.register(UINib(nibName: "EmployeesTableViewCell", bundle: nil), forCellReuseIdentifier: "employeesCell")
        employeesTable.rowHeight = CGFloat(120)
        
        apiManager.loadEmployees { [weak self] (result) in
            switch result{
            case .success(let company):
                self?.dataSource.append(company)
                DispatchQueue.main.async {
                    self?.employeesTable.reloadData()
                    self?.indicator.stopAnimating()
                    self?.indicator.isHidden = true
                    self?.dataSource[0].company.employees.sort(by: {$0.name < $1.name})
                    
                }
            case .failure(let error):
                    let alert = UIAlertController(title: "\(error.localizedDescription.description)",
                                                  message: nil,
                                                  preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
                    self?.present(alert, animated: true)
            default:
                break
            }
        }
        
        
    }
    

    

}
//MARK: extension UITableViewDataSource
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.first?.company.employees.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "employeesCell", for: indexPath) as! EmployeesTableViewCell
        let emploees = dataSource.first?.company.employees[indexPath.row]
        cell.nameTitle?.text = emploees!.name
        cell.phoneTitile?.text = "Phone: \(String(emploees!.phoneNumber))"
        
        var skills = ""
        for skill in emploees!.skills {
            skills += "\(skill) "
        }
        cell.skilsTitle.text = "Skils: \(skills)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dataSource.first?.company.name
    }
}
