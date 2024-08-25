//
//  ContentView.swift
//  TesteSPM
//
//  Created by Ricardo Bailoni on 06/06/24.
//

import SwiftUI
import ViewCodeProtocols
import NetworkProtocols

struct ContentView: View {
    @State var users: [User] = []
    var body: some View {
        VStack {
            ForEach(users) { user in
                Text(user.name)
            }
        }
        .padding()
        .task {
            do {
                users = try await APIManager.shared.getData(from: APIEndPoint.users)
                let carambola = JSONBody()
            } catch {
                
            }
        }
    }
}

#Preview {
    ContentView()
}

enum APIEndPoint: EndPointProtocol {
    
    case users
    
    var baseURL: String {
        guard let base = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String else { return "" }
        return base
    }
    
    var path: String {
        switch self {
        case .users: "/users"
        }
    }
    
    var method: NetworkProtocols.Method {
        switch self {
        default: .GET
        }
    }
    
    var queries: [URLQueryItem]? {
        switch self {
        default: nil
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .users:
            nil
        }
    }
}

struct User: Codable, Identifiable {
    let id: Int?
    let name: String
    let username, email: String?
    let address: Address?
    let phone, website: String?
    let company: Company?
}

// MARK: - Address
struct Address: Codable {
    let street, suite, city, zipcode: String?
    let geo: Geo?
}

// MARK: - Geo
struct Geo: Codable {
    let lat, lng: String?
}

// MARK: - Company
struct Company: Codable {
    let name, catchPhrase, bs: String?
}
