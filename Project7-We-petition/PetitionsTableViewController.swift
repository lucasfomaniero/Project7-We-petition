//
//  ViewController.swift
//  Project7-We-petition
//
//  Created by Lucas Maniero on 20/02/22.
//

import UIKit
import WebKit

class PetitionsTableViewController: UITableViewController {
    
    lazy var searchAlertController: UIAlertController = {
        let alertVC = UIAlertController(title: "Search", message: "Type the text in the field below", preferredStyle: .alert)
        alertVC.addTextField()
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak alertVC, weak self] action in
            guard let text = alertVC?.textFields?[0].text else {return}
            self?.filterPetitions(with: text)
            alertVC?.textFields?[0].text = ""
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { [weak self] _ in
            self?.dismiss(animated: true, completion: nil)
        }
        alertVC.addAction(okAction)
        alertVC.addAction(cancelAction)
        return alertVC
    }()
    
    var petitions = [Petition]()
    var filteredPetitions = [Petition]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Petitions"
        let searchButtonItem: UIBarButtonItem = .init(barButtonSystemItem: .search, target: self, action: #selector(showSearchAlert))
        let clearSearchButton: UIBarButtonItem = .init(title: "Clear", style: .done, target: self, action: #selector(clearSearchResult))
        navigationItem.rightBarButtonItems = [searchButtonItem, clearSearchButton]
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "number")
        fetchPetitions()
    }
    
    @objc func showSearchAlert() {
        self.present(searchAlertController, animated: true, completion: nil)
    }
    
    @objc private func clearSearchResult() {
        filteredPetitions.removeAll(keepingCapacity: true)
        filteredPetitions = petitions
        tableView.reloadData()
    }
    
    private func filterPetitions(with text: String) {
        filteredPetitions = petitions.filter { petition in
            petition.title.contains(text)
        }
        tableView.reloadData()
    }
    
    private func fetchPetitions() {
        let urlString: String
//         let urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
           if let url = URL(string: urlString),
              let data = try? Data(contentsOf: url) {
               parse(json: data)
               filteredPetitions = petitions
               tableView.reloadData()
           }
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        do {
            let jsonPetitions = try decoder.decode(Petitions.self, from: json)
            petitions = jsonPetitions.results
        } catch is DecodingError {
            print("Erro ao decodar")
        } catch {
            print("Outro erro")
        }
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPetitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "number")
        var content = cell?.defaultContentConfiguration()
        let petition = filteredPetitions[indexPath.row]
        content?.text = petition.title
        content?.secondaryText = "\(petition.signatureCount) signatures of \(petition.signatureThreshold) "
        cell?.contentConfiguration = content
        return cell ?? UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
    }

}

