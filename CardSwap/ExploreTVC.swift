//
//  ExploreTVC.swift
//  CardSwap
//
//  Created by Alex Eichner on 12/17/23.
//

import UIKit

class ExploreTVC: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = "https://api.scryfall.com/cards/56ebc372-aabd-4174-a943-c7bf59e5028d"
        print("before get data")
        getData(from: url)

    }
    
    func getData(from url: String) {
        let getCardTask = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in
            guard let data = data, error == nil else {
                print("something went wrong you fucking idiot")
                return
            }
            
            var result: MagicCard?
            do {
                result = try JSONDecoder().decode(MagicCard.self, from: data)
            } catch {
                print("failed to convert: \(error.localizedDescription)")
            }

            guard let json = result else {
                return
            }
            
            print(json.name)
        })
            
        getCardTask.resume()
    }
    
    struct MagicCard: Codable {
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

    struct ImageURIs: Codable {
        let small: String
        let normal: String
        let large: String
        let png: String
        let art_crop: String
        let border_crop: String
    }

    struct Legalities: Codable {
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

    struct Prices: Codable {
        let usd: String
        let usd_foil: String
        let usd_etched: String?
        let eur: String
        let eur_foil: String
        let tix: String
    }

    struct RelatedURIs: Codable {
        let gatherer: String
        let tcgplayer_infinite_articles: String
        let tcgplayer_infinite_decks: String
        let edhrec: String
    }

    struct PurchaseURIs: Codable {
        let tcgplayer: String
        let cardmarket: String
        let cardhoarder: String
    }
}
