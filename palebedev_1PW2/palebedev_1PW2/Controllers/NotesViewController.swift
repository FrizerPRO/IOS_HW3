//
//  NotesViewController.swift
//  palebedev_1PW2
//
//  Created by Lebedev Petr on 13.11.2022.
//

import UIKit

final class NotesViewController: UIViewController {
    
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    private var dataSource: Array<ShortNote> {
        get{
            if let url = Bundle.main.url(forResource: "default", withExtension: "json") {
                do {
                    let data = try Data(contentsOf: url)
                    let decoder = JSONDecoder()
                    let jsonData = try decoder.decode(Array<ShortNote>.self, from: data)
                    return jsonData
                } catch {
                }
            }
            return []
        }
        set{
            if let url = Bundle.main.url(forResource: "default", withExtension: "json") {
                do {
                    let encoder = JSONEncoder()
                    let jsonData = try encoder.encode(newValue)
                    try jsonData.write(to: url)
                } catch {
                }
            }
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
    }
    private func setupView(){
        setupTableView()
        setupNavBar()
    }

    private func setupTableView(){
        tableView.register(NoteCell.self, forCellReuseIdentifier: NoteCell.reuseIdentifier)
        tableView.register(AddNoteCell.self, forCellReuseIdentifier: AddNoteCell.reuseIdentifier)
        
        view.addSubview(tableView)
        
        tableView.backgroundColor = .clear
        tableView.keyboardDismissMode = .onDrag
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        tableView.pin(to: self.view)
    }
    
    private func setupNavBar(){
        self.title = "Notes"
        
        let closeButton = UIButton(type: .close)
        closeButton.addTarget(self, action: #selector(dismissViewController(_:)),
        for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: closeButton)
        
    }
    @objc
    private func dismissViewController(_ target: UIButton){
        dismiss(animated: true, completion: nil)
    }
    private func handleDelete(indexPath: IndexPath){
        dataSource.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
}
extension NotesViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)->Int{
        switch section{
        case 0:
            return 1
        default:
            return dataSource.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if let addNewCell = tableView.dequeueReusableCell(withIdentifier: AddNoteCell.reuseIdentifier, for: indexPath) as? AddNoteCell {
                addNewCell.delegate = self
                return addNewCell
            }
        default:
            let note = dataSource[indexPath.row]
            if let noteCell = tableView.dequeueReusableCell(withIdentifier:
                                                                NoteCell.reuseIdentifier, for: indexPath) as? NoteCell {
                noteCell.configure(note)
                return noteCell
            }
        }
        return UITableViewCell()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2;
    }
}

extension NotesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt
                   indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(
            style: .destructive,
            title: .none
        ) { [weak self] (action, view, completion) in
            self?.handleDelete(indexPath: indexPath)
            completion(true)
        }
        deleteAction.image = UIImage(
            systemName: "trash.fill",
            withConfiguration: UIImage.SymbolConfiguration(weight: .bold)
        )?.withTintColor(.white)
        deleteAction.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

extension NotesViewController: AddNoteDelegate{
    func newNoteAdded(note: ShortNote) {
        dataSource.insert(note, at: 0)
        tableView.reloadData()
    }
}
