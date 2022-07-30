//
//  HttpRequestHelper.swift
//  MVVM-Pokemon
//
//  Created by C330593 on 11/07/22.
//

import Foundation

class HttpRequestHelper {
    
    public func GET(
        url: String,
        params: [String: String],
        httpHeader: HTTPHeaderFields,
        complete: @escaping (Bool, Data?) -> ()
    ) -> Void  {
        guard var components = URLComponents(string: url) else {
            print("Error: cannot create URLCompontents")
            return
        }
        components.queryItems = params.map { key, value in
            URLQueryItem(name: key, value: value)
        }
        
        guard let url = components.url else {
            print("Error: cannot create URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        switch httpHeader {
            case .application_json:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                break
            case .application_x_www_form_urlencoded:
                request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
                break
            case .none: break
        }
        
        // .ephemeral evita que el JSON se almacene en caché (Se almacenará en Ram y nada en Disco)
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        session.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("Error: problem calling GET")
                print(error!)
                complete(false, nil)
                return
            }
            guard let data = data else {
                print("Error: did not receive data")
                complete(false, nil)
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                print("Error: HTTP request failed")
                complete(false, nil)
                return
            }
            
            complete(true, data)
        }.resume()
    }
}
