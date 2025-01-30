import SwiftUI
import Combine
import Models

public final class Networking: NSObject, Sendable {
    
    @MainActor public static let shared = Networking()
    
    private override init() {}
    
    public enum RequestType: String {
        case exploreData = "exploreData"
    }

    public func url(for requestType: RequestType, inBundle bundle: Bundle) -> URL {
        return bundle.url(forResource: requestType.rawValue, withExtension: "json")!
    }
    
    public func jsonData(inBundle bundle: Bundle) ->  Data? {
        do {
            if let jsonData = try? Data(contentsOf: url(for: .exploreData, inBundle: bundle) , options: .mappedIfSafe) {
                return jsonData
            }
        }
        return nil
    }
    
    public func getDecodableData<Model: Decodable>(
        ofType modelType: Model.Type = Model.self,
        inBundle bundle: Bundle,
        completion: @escaping (Result<Model, NSError>) -> Void
    ) async where Model : Decodable {
        if let localData = jsonData(inBundle: bundle) {
            await parse(ofType: modelType, from: localData) {
                completion($0)
            }
        }
    }
    
    func parse<Model: Decodable>(
        ofType modelType: Model.Type = Model.self,
        from jsonData: Data,
        completion: @escaping (Swift.Result<Model, NSError>) -> Void
    ) async {
        do {
            if let decodedData = try? JSONDecoder().decode(Model.self, from: jsonData) {
                completion(.success(decodedData))
            }
        }
    }
}
