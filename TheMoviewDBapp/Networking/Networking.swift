//
//  Networking.swift
//  TheMoviewDBapp
//
//  Created by pablo luis velazquez zamudio on 08/09/22.
//

import Foundation

struct NetworkManager {
    func getRequesToken(url: String, completion: @escaping(RequesTokenResponse?) -> ()) {
        guard let sessionURL = URL(string: url) else {return}
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: sessionURL) { (data, response, error) in
            if error == nil {
                if (response as? HTTPURLResponse)?.statusCode == 200 {
                    if let safeData = data {
                        let decoder = JSONDecoder()
                        do {
                            let decodedData = try decoder.decode(RequesTokenResponse.self, from: safeData)
                            completion(decodedData)
                        } catch {
                            print("error while parsing data \(error)")
                            completion(nil)
                        }

                    }
                }else{
                    completion(nil)
                    print("error code" )
                }
                
            }
            else {
                print("error in data task is \(String(describing: error))")
            }
        }
        dataTask.resume()
        
    }
    
    func postLogin(url: String, loginObject: objecLogin, completion: @escaping(RequesTokenResponse?) -> ()) {
        guard let sessionURL = URL(string: url) else {return}
        var request = URLRequest(url: sessionURL)
        
        do {
            let body = try JSONEncoder().encode(loginObject)
            request.httpBody = body
        }catch{
            print("Coadble error")
        }
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if error == nil {
                if (response as? HTTPURLResponse)?.statusCode == 200 {
                    if let safeData = data {
                        let decoder = JSONDecoder()
                        do {
                            let decodedData = try decoder.decode(RequesTokenResponse.self, from: safeData)
                            completion(decodedData)
                        } catch {
                            print("error while parsing data \(error)")
                            completion(nil)
                        }

                    }
                }else{
                    completion(nil)
                    print("error code", (response as! HTTPURLResponse).statusCode )
                }
                
            }
            else {
                print("error in data task is \(String(describing: error))")
            }
        }
        dataTask.resume()
        
    }
    
    
    func postCreateSession(url: String, token: String, completion: @escaping(SessionResponse?) -> ()) {
        guard let sessionURL = URL(string: url) else {return}
        var request = URLRequest(url: sessionURL)
        let params: [String:String] = ["request_token" : token]
        
        do {
            let body = try JSONEncoder().encode(params)
            request.httpBody = body
        }catch{
            print("Coadble error")
        }
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if error == nil {
                if (response as? HTTPURLResponse)?.statusCode == 200 {
                    if let safeData = data {
                        let decoder = JSONDecoder()
                        do {
                            let decodedData = try decoder.decode(SessionResponse.self, from: safeData)
                            completion(decodedData)
                        } catch {
                            print("error while parsing data \(error)")
                            completion(nil)
                        }

                    }
                }else{
                    completion(nil)
                    print("error code", (response as! HTTPURLResponse).statusCode )
                    print(response, error)
                }
                
            }
            else {
                print("error in data task is \(String(describing: error))")
            }
        }
        dataTask.resume()
        
    }
    
    func getMovies(url: String, completion: @escaping(MoviesResponse?) -> ()) {
        guard let sessionURL = URL(string: url) else {return}
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: sessionURL) { (data, response, error) in
            if error == nil {
                if (response as? HTTPURLResponse)?.statusCode == 200 {
                    if let safeData = data {
                        let decoder = JSONDecoder()
                        do {
                            let decodedData = try decoder.decode(MoviesResponse.self, from: safeData)
                            completion(decodedData)
                        } catch {
                            print("error while parsing data \(error)")
                            completion(nil)
                        }

                    }
                }else{
                    completion(nil)
                    print("error code", response )
                }
                
            }
            else {
                print("error in data task is \(String(describing: error))")
            }
        }
        dataTask.resume()
    }
    
    func getMovieDetail(url: String, completion: @escaping(MovieDetailResponse?) -> ()) {
        guard let sessionURL = URL(string: url) else {return}
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: sessionURL) { (data, response, error) in
            if error == nil {
                if (response as? HTTPURLResponse)?.statusCode == 200 {
                    if let safeData = data {
                        let decoder = JSONDecoder()
                        do {
                            let decodedData = try decoder.decode(MovieDetailResponse.self, from: safeData)
                            completion(decodedData)
                        } catch {
                            print("error while parsing data \(error)")
                            completion(nil)
                        }

                    }
                }else{
                    completion(nil)
                    print("error code", response )
                }
                
            }
            else {
                print("error in data task is \(String(describing: error))")
            }
        }
        dataTask.resume()
    }
    
    func getAccountDetail(url: String, completion: @escaping(AccountResponse?) -> ()) {
        guard let sessionURL = URL(string: url) else {return}
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: sessionURL) { (data, response, error) in
            if error == nil {
                if (response as? HTTPURLResponse)?.statusCode == 200 {
                    if let safeData = data {
                        let decoder = JSONDecoder()
                        do {
                            let decodedData = try decoder.decode(AccountResponse.self, from: safeData)
                            completion(decodedData)
                        } catch {
                            print("error while parsing data \(error)")
                            completion(nil)
                        }

                    }
                }else{
                    completion(nil)
                    print("error code", response )
                }
                
            }
            else {
                print("error in data task is \(String(describing: error))")
            }
        }
        dataTask.resume()
    }
    
    func getFavoritesMovies(url: String, completion: @escaping(MoviesResponse?) -> ()) {
        guard let sessionURL = URL(string: url) else {return}
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: sessionURL) { (data, response, error) in
            if error == nil {
                if (response as? HTTPURLResponse)?.statusCode == 200 {
                    if let safeData = data {
                        let decoder = JSONDecoder()
                        do {
                            let decodedData = try decoder.decode(MoviesResponse.self, from: safeData)
                            completion(decodedData)
                        } catch {
                            print("error while parsing data \(error)")
                            completion(nil)
                        }

                    }
                }else{
                    completion(nil)
                    print("error code", response )
                }
                
            }
            else {
                print("error in data task is \(String(describing: error))")
            }
        }
        dataTask.resume()
    }

}
