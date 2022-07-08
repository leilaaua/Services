//
//  GroupServicesViewController.swift
//  Services
//
//  Created by leila on 20.06.2022.
//

import UIKit

class GroupServicesViewController: UICollectionViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var groupData: GroupData?
    var services: [Service] = []
    var filteredServices : [Service] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        fetchGroupData()
        fetchServiceData()
    }
    
    @IBAction func unwind(segue: UIStoryboardSegue) {
        dismiss(animated: true)
    }
    
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        groupData?.data.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "groupCell", for: indexPath) as! GroupViewCell
        
        let groupData = groupData?.data[indexPath.row]
        cell.groupNameLabel.text = groupData?.name
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let selectGroupId = groupData?.data[indexPath.item].id else { return }
        
        filteredServices = services.filter { $0.serviceGroupId == selectGroupId }
        performSegue(withIdentifier: "showServices", sender: filteredServices)
    
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showServices" {
            guard let servicesVC = segue.destination as? ServicesViewController else { return }
            servicesVC.services = sender as? [Service]
            
        }
    }
    
    private func fetchGroupData() {
        NetworkManager.shared.fetch(dataType: GroupData.self, from: Link.groupURL.rawValue, convertFromSnakeCase: false) { groupData in
            switch groupData {
            case .success(let groupData):
                self.groupData = groupData
                self.activityIndicator.stopAnimating()
                self.collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func fetchServiceData() {
        let pageIndex = 1
        makeRequest(pageIndex: pageIndex)
    }
    
    func makeRequest(pageIndex: Int) {
        let url = getDataUrl(page: pageIndex)
        NetworkManager.shared.fetch(dataType: ServiceData.self, from: url, convertFromSnakeCase: false) { serviceData in
            switch serviceData {
            case .success(let serviceData):
                self.services += serviceData.data
                self.collectionView.reloadData()
                if pageIndex < serviceData.meta.pages   {
                    self.makeRequest(pageIndex: pageIndex + 1)
                }
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        }
    }
    
    
    func getDataUrl(page: Int) -> String {
        let dataUrl = "https://business-beauty.staging.eservia.com/api/v1.0/widget/services"
        let code = "35CDFF1D10A64E9E91D4EA9C8B983DBC"
        return "\(dataUrl)" + "?code=" + "\(code)" + "&page=" + String(page)
    }
    
}

extension GroupServicesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 48, height: 100)
    }
}
