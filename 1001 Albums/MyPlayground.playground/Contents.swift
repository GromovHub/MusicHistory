import Foundation
func decodingProf() {
let json = """
{
        "date": 1981,
        "id": 491,
        "album": "The Poet",
        "url": "some url",
        "listened": true,
        "artist": "Bobbie Womack"
}
""".data(using: .utf8)!

    struct MyArtist: Codable {
        var id: String
        var url: [String]
        var listened: Int
    
        
        enum CodingKeys: String, CodingKey {
            case id = "id"
            case url = "album"
            case listened
        }
        enum EncodingKeys: String, CodingKey {
            case id = "айди"
            case url = "юэрэлы"
            case testKey = "daaaamn"
        }
        
        init(from decoder: Decoder) throws {
            // if?
            let container = try decoder.container(keyedBy: CodingKeys.self)
            id = String(Int(try container.decode(Int.self, forKey: .id)))
            url = [try container.decode(String.self, forKey: .url)]
            listened = (try container.decode(Bool.self, forKey: .listened)) == true ? 1 : 0
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: EncodingKeys.self)
            try container.encode(id, forKey: .id)
            try container.encode(url, forKey: .testKey)
            try container.encode(Date().description(with: .current), forKey: .url)
        }
    }
    
    do {
        let x = try JSONDecoder().decode(MyArtist.self, from: json)
        print("decoded", x.self)
        let y = try JSONEncoder().encode(x)
        print(String(decoding: y, as: UTF8.self))
    } catch {
        print(error)
    }

}

decodingProf()
