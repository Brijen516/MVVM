import Foundation
import UIKit
struct UserModel : Codable {
	let uid : Int?
	let id : Int?
	let title : String?
	let completed : Bool?

	enum CodingKeys: String, CodingKey {

		case uid = "userId"
		case id = "id"
		case title = "title"
		case completed = "completed"
	}

//	init(from decoder: Decoder) throws {
//		let values = try decoder.container(keyedBy: CodingKeys.self)
//		uid = try values.decodeIfPresent(Int.self, forKey: .uid)
//		id = try values.decodeIfPresent(Int.self, forKey: .id)
//		title = try values.decodeIfPresent(String.self, forKey: .title)
//		completed = try values.decodeIfPresent(Bool.self, forKey: .completed)
//        
//	}
    
    func getSatuts() -> (String, UIColor) {
        if completed ?? true {
            return ("completed", UIColor.green)
        }
        else {
            return ("non completed", UIColor.red)
        }
        
    }
    
   
}
