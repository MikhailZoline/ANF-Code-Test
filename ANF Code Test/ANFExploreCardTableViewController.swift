//
//  ANFExploreCardTableViewController.swift
//  ANF Code Test
//

import UIKit
import Models
import Cache

class ANFExploreCardTableViewController: UITableViewController {
    
    private var exploreData: [PromoCardDecodable]? {
        if let promoCardsArray = PromoCardsCache.shared.value(forKey: "exploreData") {
            return promoCardsArray
        }
        else if let url = Bundle.main.url(forResource: "exploreData", withExtension: "json"),
                let data = try? Data(contentsOf: url, options: .mappedIfSafe),
                let promoCardsArray = try? JSONDecoder().decode([PromoCardDecodable].self, from: data) {
            return promoCardsArray
        }
        return nil
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        exploreData?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "ExploreContentCell", for: indexPath)
        if let titleLabel = cell.viewWithTag(1) as? UILabel{
            titleLabel.text = exploreData?[indexPath.row].title
        }
        
        if let imageView = cell.viewWithTag(2) as? UIImageView,
           let decoded: PromoCardDecodable = exploreData?[indexPath.row],
           let image = UIImage(named: decoded.backgroundImage) {
            imageView.image = image
        }
        
        return cell
    }
}
