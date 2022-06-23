//
//  EmployeesViewController.swift
//  Services
//
//  Created by leila on 22.06.2022.
//

import UIKit

class EmployeesViewController: UICollectionViewController {
    
    var employees: [Employee] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchEmployeeData()
    }

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        employees.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "employeesCell", for: indexPath) as! EmployeeViewCell
    
        cell.configure(with: (employees[indexPath.item]))
        
    
        return cell
    }
    
    
    
    private func fetchEmployeeData() {
        let pageIndex = 1
        makeRequest(pageIndex: pageIndex)
    }
    
    func makeRequest(pageIndex: Int) {
        let url = getDataUrl(page: pageIndex)
        NetworkManager.shared.fetch(dataType: EmployeeData.self, from: url, convertFromSnakeCase: false) { employeeData in
            switch employeeData {
            case .success(let employeeData):
                self.employees += employeeData.data
                self.collectionView.reloadData()
                if pageIndex < employeeData.meta.pages   {
                    self.makeRequest(pageIndex: pageIndex + 1)
                }
            case .failure(let error):
                print(error.localizedDescription)

            }
        }
    }
    
    func getDataUrl(page: Int) -> String {
        let dataUrl = "https://business-beauty.staging.eservia.com/api/v1.0/widget/staffs"
        let code = "35CDFF1D10A64E9E91D4EA9C8B983DBC"
        return "\(dataUrl)" + "?code=" + "\(code)" + "&page=" + String(page)
    }
}

extension EmployeesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 48, height: 100)
    }
}
