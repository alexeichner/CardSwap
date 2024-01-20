//
//  ExploreTVC.swift
//  CardSwap
//
//  Created by Alex Eichner on 12/17/23.
//

import UIKit

class ExploreTVC: UITableViewController {
    
    var data = [MagicCard]()
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        let url = "https://api.scryfall.com/cards/search?q=c%3Awhite+mv%3D1"
//        getData(from: url) { result in
//            self.data = result.data
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        }
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = "https://api.scryfall.com/cards/search?q=c%3Awhite+mv%3D1"
        getData(from: url) { result in
            guard let cardList = result else {
                print("Data is missing or couldn't be read.")
                return
            }

            self.data = cardList.data
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of cells you want in your table view
        return data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue or create a new instance of your custom cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "SampleCardCell", for: indexPath) as! CustomCardCell

        // Configure the cell with your data
        cell.cardNameLabel.text = data[indexPath.row].name
        return cell
    }
    
    //func getData(from url: String, completion: @escaping (CardList) -> Void) {
        
//        let url = URL(string: url)
//        let session = URLSession.shared
//        let dataTask = session.dataTask(with: url!) { data, response, error in
//            do {
//                let parsingData = try JSONDecoder().decode(CardList.self, from: data!)
//                completion(parsingData)
//            } catch {
//                print("\(error.localizedDescription)")
//            }
//        }
//        dataTask.resume()
        
    func getData(from url: String, completion: @escaping (CardList?) -> Void) {
        guard let url = URL(string: url) else {
            print("Invalid URL")
            completion(nil)
            return
        }
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { data, response, error in
            guard error == nil else {
                print("Error: \(error!.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("Data is nil")
                completion(nil)
                return
            }
            
            do {
                let parsingData = try JSONDecoder().decode(CardList.self, from: data)
                completion(parsingData)
            } catch {
                print("Parsing error: \(error.localizedDescription)")
                completion(nil)
            }
        }
        
        dataTask.resume()
    }
    
    
    struct CardList: Decodable {
        let object: String
        let total_cards: Int
        let has_more: Bool
        let next_page: String
        let data: [MagicCard]
    }
    
    struct MagicCard: Decodable {
        let object: String
        let id: String
        let oracle_id: String
        let multiverse_ids: [Int]
        let mtgo_id: Int
        let mtgo_foil_id: Int
        let tcgplayer_id: Int
        let cardmarket_id: Int
        let name: String
        let lang: String
        let released_at: String
        let uri: String
        let scryfall_uri: String
        let layout: String
        let highres_image: Bool
        let image_status: String
        let image_uris: ImageURIs
        let mana_cost: String
        let cmc: Int
        let type_line: String
        let oracle_text: String
        let power: String
        let toughness: String
        let colors: [String]
        let color_identity: [String]
        let keywords: [String]
        let legalities: Legalities
        let games: [String]
        let reserved: Bool
        let foil: Bool
        let nonfoil: Bool
        let finishes: [String]
        let oversized: Bool
        let promo: Bool
        let reprint: Bool
        let variation: Bool
        let set_id: String
        let set: String
        let set_name: String
        let set_type: String
        let set_uri: String
        let set_search_uri: String
        let scryfall_set_uri: String
        let rulings_uri: String
        let prints_search_uri: String
        let collector_number: String
        let digital: Bool
        let rarity: String
        let card_back_id: String
        let artist: String
        let artist_ids: [String]
        let illustration_id: String
        let border_color: String
        let frame: String
        let full_art: Bool
        let textless: Bool
        let booster: Bool
        let story_spotlight: Bool
        let edhrec_rank: Int
        let penny_rank: Int
        let prices: Prices
        let related_uris: RelatedURIs
        let purchase_uris: PurchaseURIs
    }

    struct ImageURIs: Decodable {
        let small: String
        let normal: String
        let large: String
        let png: String
        let art_crop: String
        let border_crop: String
    }

    struct Legalities: Decodable {
        let standard: String
        let future: String
        let historic: String
        let timeless: String
        let gladiator: String
        let pioneer: String
        let explorer: String
        let modern: String
        let legacy: String
        let pauper: String
        let vintage: String
        let penny: String
        let commander: String
        let oathbreaker: String
        let brawl: String
        let historicbrawl: String
        let alchemy: String
        let paupercommander: String
        let duel: String
        let oldschool: String
        let premodern: String
        let predh: String
    }

    struct Prices: Decodable {
        let usd: String
        let usd_foil: String
        let usd_etched: String?
        let eur: String
        let eur_foil: String
        let tix: String
    }

    struct RelatedURIs: Decodable {
        let gatherer: String
        let tcgplayer_infinite_articles: String
        let tcgplayer_infinite_decks: String
        let edhrec: String
    }

    struct PurchaseURIs: Decodable {
        let tcgplayer: String
        let cardmarket: String
        let cardhoarder: String
    }
}
