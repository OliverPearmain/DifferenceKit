import UIKit
import DifferenceKit

final class HomeViewController: UITableViewController {
    
    struct Component: Differentiable {
        
        var title: String
        var subtitle: String
        
        var differenceIdentifier: String {
            return title
        }
        func isContentEqual(to source: HomeViewController.Component) -> Bool {
            return self.subtitle == source.subtitle
        }
    }

    private var components = [
        Component(title: "Shuffle Emojis", subtitle: "Shuffle sectioned Emojis in UICollectionView"),
        Component(title: "Header Footer Section", subtitle: "Update header/footer by reload section in UITableView"),
        Component(title: "Random", subtitle: "Random diff in UICollectionView")
    ]
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            
            let components = [
                
                Component(title: "Header Footer Section", subtitle: "XXX Update header/footer by reload section in UITableView"),
                
                Component(title: "Random", subtitle: "Random diff in UICollectionView"),
                
                Component(title: "Shuffle Emojis", subtitle: "Shuffle sectioned Emojis in UICollectionView"),
            ]

            let changeset = StagedChangeset(source: self.components, target: components)
            
            self.tableView.reload(using: changeset, with: .fade) { data in
                self.components = components
            }
            
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Home"
        tableView.tableFooterView = UIView()
        tableView.register(cellType: HomeCell.self)
    }
}

extension HomeViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return components.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HomeCell = tableView.dequeueReusableCell(for: indexPath)
        let component = components[indexPath.row]
        cell.titleLabel.text = component.title
        cell.subtitleLabel.text = component.subtitle
        return cell
    }

}
