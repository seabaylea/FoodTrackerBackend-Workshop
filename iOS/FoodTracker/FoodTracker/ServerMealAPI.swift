
import Foundation
import ObjectMapper
import BMSCore


public class ServerMealAPI: FoodTrackerUtility {


    /**
        Create a new instance of the model and persist it

        - parameter data: Model instance data
        - parameter completionHandler: The callback that will be executed once the underlying HTTP call completes
        - parameter returnedData: The data that this method is retrieving from the server
        - parameter response: The HTTP response returned by the server
        - parameter error: An error that prevented a successful request
    */
    public static func serverMealCreate(data: ServerMeal? = nil, completionHandler: @escaping (_ returnedData: ServerMeal?, _ response: Response?, _ error: Error?) -> Void) {

        let path = "/ServerMeals"
        let components = URLComponents(string: self.basePath + path)

        var request = URLRequest(url: (components?.url!)!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = convertToData(data)

        let urlSession = BMSURLSession(configuration: .default, delegate: nil, delegateQueue: nil)
        urlSession.dataTask(with: request) { (data, response, error) in

            let httpResponse = response as? HTTPURLResponse
            let bmsResponse: Response = Response(responseData: data, httpResponse: httpResponse, isRedirect: false)

            guard httpResponse != nil else {
                completionHandler(nil, nil, error)
                return
            }

            guard error == nil else {
                completionHandler(nil, bmsResponse, error)
                return
            }

            if 200 ..< 300 ~= httpResponse!.statusCode,
               httpResponse!.statusCode == 200,
               let data = data {

                let returnValue = extractResponseFromData(data: data, type: ServerMeal.self)
                completionHandler(returnValue, bmsResponse, error)
            } else {
                completionHandler(nil, bmsResponse, error)
            }
        }.resume()
    }


    /**
        Delete a model instance by {{id}}

        - parameter id: Model id
        - parameter completionHandler: The callback that will be executed once the underlying HTTP call completes
        - parameter returnedData: The data that this method is retrieving from the server
        - parameter response: The HTTP response returned by the server
        - parameter error: An error that prevented a successful request
    */
    public static func serverMealDelete(id: String, completionHandler: @escaping (_ returnedData: Any?, _ response: Response?, _ error: Error?) -> Void) {

        var path = "/ServerMeals/{id}"
        path = path.replacingOccurrences(of: "{id}", with: "\(id)")

        let components = URLComponents(string: self.basePath + path)

        var request = URLRequest(url: (components?.url!)!)
        request.httpMethod = "DELETE"
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        let urlSession = BMSURLSession(configuration: .default, delegate: nil, delegateQueue: nil)
        urlSession.dataTask(with: request) { (data, response, error) in

            let httpResponse = response as? HTTPURLResponse
            let bmsResponse: Response = Response(responseData: data, httpResponse: httpResponse, isRedirect: false)

            guard httpResponse != nil else {
                completionHandler(nil, nil, error)
                return
            }

            guard error == nil else {
                completionHandler(nil, bmsResponse, error)
                return
            }

            if 200 ..< 300 ~= httpResponse!.statusCode,
               httpResponse!.statusCode == 200,
               let data = data {

                let returnValue = extractResponseFromData(data: data, type: Any.self)
                completionHandler(returnValue, bmsResponse, error)
            } else {
                completionHandler(nil, bmsResponse, error)
            }
        }.resume()
    }


    /**
        Delete all instances of the model

        - parameter completionHandler: The callback that will be executed once the underlying HTTP call completes
        - parameter response: The HTTP response returned by the server
        - parameter error: An error that prevented a successful request
    */
    public static func serverMealDeleteAll(completionHandler: @escaping (_ response: Response?, _ error: Error?) -> Void) {

        let path = "/ServerMeals"
        let components = URLComponents(string: self.basePath + path)

        var request = URLRequest(url: (components?.url!)!)
        request.httpMethod = "DELETE"
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        let urlSession = BMSURLSession(configuration: .default, delegate: nil, delegateQueue: nil)
        urlSession.dataTask(with: request) { (data, response, error) in

            let httpResponse = response as? HTTPURLResponse
            let bmsResponse: Response = Response(responseData: data, httpResponse: httpResponse, isRedirect: false)

            guard httpResponse != nil else {
                completionHandler(nil, error)
                return
            }

            completionHandler(bmsResponse, error)

        }.resume()
    }


    /**
        Find all instances of the model

        - parameter completionHandler: The callback that will be executed once the underlying HTTP call completes
        - parameter returnedData: The data that this method is retrieving from the server
        - parameter response: The HTTP response returned by the server
        - parameter error: An error that prevented a successful request
    */
    public static func serverMealFindAll(completionHandler: @escaping (_ returnedData: [ServerMeal]?, _ response: Response?, _ error: Error?) -> Void) {

        let path = "/ServerMeals"
        let components = URLComponents(string: self.basePath + path)

        var request = URLRequest(url: (components?.url!)!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        let urlSession = BMSURLSession(configuration: .default, delegate: nil, delegateQueue: nil)
        urlSession.dataTask(with: request) { (data, response, error) in

            let httpResponse = response as? HTTPURLResponse
            let bmsResponse: Response = Response(responseData: data, httpResponse: httpResponse, isRedirect: false)

            guard httpResponse != nil else {
                completionHandler(nil, nil, error)
                return
            }

            guard error == nil else {
                completionHandler(nil, bmsResponse, error)
                return
            }

            if 200 ..< 300 ~= httpResponse!.statusCode,
               httpResponse!.statusCode == 200,
               let data = data {

                let returnValue = extractResponseFromData(data: data, containerType: [ServerMeal].self, nestedType: ServerMeal.self)
                completionHandler(returnValue, bmsResponse, error)
            } else {
                completionHandler(nil, bmsResponse, error)
            }
        }.resume()
    }


    /**
        Find a model instance by {{id}}

        - parameter id: Model id
        - parameter completionHandler: The callback that will be executed once the underlying HTTP call completes
        - parameter returnedData: The data that this method is retrieving from the server
        - parameter response: The HTTP response returned by the server
        - parameter error: An error that prevented a successful request
    */
    public static func serverMealFindOne(id: String, completionHandler: @escaping (_ returnedData: ServerMeal?, _ response: Response?, _ error: Error?) -> Void) {

        var path = "/ServerMeals/{id}"
        path = path.replacingOccurrences(of: "{id}", with: "\(id)")

        let components = URLComponents(string: self.basePath + path)

        var request = URLRequest(url: (components?.url!)!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        let urlSession = BMSURLSession(configuration: .default, delegate: nil, delegateQueue: nil)
        urlSession.dataTask(with: request) { (data, response, error) in

            let httpResponse = response as? HTTPURLResponse
            let bmsResponse: Response = Response(responseData: data, httpResponse: httpResponse, isRedirect: false)

            guard httpResponse != nil else {
                completionHandler(nil, nil, error)
                return
            }

            guard error == nil else {
                completionHandler(nil, bmsResponse, error)
                return
            }

            if 200 ..< 300 ~= httpResponse!.statusCode,
               httpResponse!.statusCode == 200,
               let data = data {

                let returnValue = extractResponseFromData(data: data, type: ServerMeal.self)
                completionHandler(returnValue, bmsResponse, error)
            } else {
                completionHandler(nil, bmsResponse, error)
            }
        }.resume()
    }


    /**
        Put attributes for a model instance and persist it

        - parameter id: Model id
        - parameter data: An object of model property name/value pairs
        - parameter completionHandler: The callback that will be executed once the underlying HTTP call completes
        - parameter returnedData: The data that this method is retrieving from the server
        - parameter response: The HTTP response returned by the server
        - parameter error: An error that prevented a successful request
    */
    public static func serverMealReplace(id: String, data: ServerMeal? = nil, completionHandler: @escaping (_ returnedData: ServerMeal?, _ response: Response?, _ error: Error?) -> Void) {

        var path = "/ServerMeals/{id}"
        path = path.replacingOccurrences(of: "{id}", with: "\(id)")

        let components = URLComponents(string: self.basePath + path)

        var request = URLRequest(url: (components?.url!)!)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = convertToData(data)

        let urlSession = BMSURLSession(configuration: .default, delegate: nil, delegateQueue: nil)
        urlSession.dataTask(with: request) { (data, response, error) in

            let httpResponse = response as? HTTPURLResponse
            let bmsResponse: Response = Response(responseData: data, httpResponse: httpResponse, isRedirect: false)

            guard httpResponse != nil else {
                completionHandler(nil, nil, error)
                return
            }

            guard error == nil else {
                completionHandler(nil, bmsResponse, error)
                return
            }

            if 200 ..< 300 ~= httpResponse!.statusCode,
               httpResponse!.statusCode == 200,
               let data = data {

                let returnValue = extractResponseFromData(data: data, type: ServerMeal.self)
                completionHandler(returnValue, bmsResponse, error)
            } else {
                completionHandler(nil, bmsResponse, error)
            }
        }.resume()
    }


    /**
        Patch attributes for a model instance and persist it

        - parameter id: Model id
        - parameter data: An object of model property name/value pairs
        - parameter completionHandler: The callback that will be executed once the underlying HTTP call completes
        - parameter returnedData: The data that this method is retrieving from the server
        - parameter response: The HTTP response returned by the server
        - parameter error: An error that prevented a successful request
    */
    public static func serverMealUpdate(id: String, data: ServerMeal? = nil, completionHandler: @escaping (_ returnedData: ServerMeal?, _ response: Response?, _ error: Error?) -> Void) {

        var path = "/ServerMeals/{id}"
        path = path.replacingOccurrences(of: "{id}", with: "\(id)")

        let components = URLComponents(string: self.basePath + path)

        var request = URLRequest(url: (components?.url!)!)
        request.httpMethod = "PATCH"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = convertToData(data)

        let urlSession = BMSURLSession(configuration: .default, delegate: nil, delegateQueue: nil)
        urlSession.dataTask(with: request) { (data, response, error) in

            let httpResponse = response as? HTTPURLResponse
            let bmsResponse: Response = Response(responseData: data, httpResponse: httpResponse, isRedirect: false)

            guard httpResponse != nil else {
                completionHandler(nil, nil, error)
                return
            }

            guard error == nil else {
                completionHandler(nil, bmsResponse, error)
                return
            }

            if 200 ..< 300 ~= httpResponse!.statusCode,
               httpResponse!.statusCode == 200,
               let data = data {

                let returnValue = extractResponseFromData(data: data, type: ServerMeal.self)
                completionHandler(returnValue, bmsResponse, error)
            } else {
                completionHandler(nil, bmsResponse, error)
            }
        }.resume()
    }

}
