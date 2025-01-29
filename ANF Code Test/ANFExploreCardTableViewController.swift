//
//  ANFExploreCardTableViewController.swift
//  ANF Code Test
//

import UIKit

extension UIViewController {
    static var exploreData: [PromoCardDecodable]? {
        if let filePath = Bundle.main.path(forResource: "exploreData", ofType: "json"),
           let fileContent = try? Data(contentsOf: URL(fileURLWithPath: filePath),options: .mappedIfSafe),
           let jsonDictionary = try? JSONDecoder().decode([PromoCardDecodable].self, from: fileContent) {
            return jsonDictionary
        }
        return nil
    }
}

class ANFExploreCardTableViewController: UITableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Self.exploreData?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "ExploreContentCell", for: indexPath)
        if let titleLabel = cell.viewWithTag(1) as? UILabel{
            titleLabel.text = Self.exploreData?[indexPath.row].title
        }
        
        if let imageView = cell.viewWithTag(2) as? UIImageView,
           let decoded: PromoCardDecodable = UIViewController.exploreData?[indexPath.row],
           let image = UIImage(named: decoded.backgroundImage) {
            imageView.image = image
        }
        
        return cell
    }
}
