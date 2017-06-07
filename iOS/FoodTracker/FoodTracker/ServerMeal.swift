
import Foundation
import ObjectMapper


public class ServerMeal: Mappable {


    public var id: String?
    public var name: String?
    public var photo: String?
    public var rating: Double?

    public init() {}


    // MARK: ObjectMapper

    required public init?(map: Map) { }

    public func mapping(map: Map) {

        self.id <- map["id"]
        self.name <- map["name"]
        self.photo <- map["photo"]
        self.rating <- map["rating"]
    }

}
