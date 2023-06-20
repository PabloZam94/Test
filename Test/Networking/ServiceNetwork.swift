//
//  ServiceNetwork.swift
//  Test
//
//  Created by pablo luis velazquez zamudio on 19/06/23.
//

import Foundation

/// Basic service with get, post and delete
open class ServiceNetwork: NSObject {

    public var decoder: JSONDecoder = JSONDecoder()
    public var encoder: JSONEncoder = JSONEncoder()
    public var scheme: String = "https"
    public var host: String?
    public var contentType: String? = "application/json"
    private var session: URLSessionProtocol?

    public typealias ServiceCompletion = (Data?, RequestError?, HTTPURLResponse?, FXDStatusCode) -> Void

    // MARK: Init
    public init(host: String, session: URLSessionProtocol? = nil) {
        self.host = host
        self.session = session
    }

    // MARK: Get Session URL Task
    private func getSession() -> URLSessionProtocol {
        if let sessionOk = self.session {
            return sessionOk
        } else {
            let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForRequest = 60.0
            configuration.timeoutIntervalForResource = 120.0
            return URLSession(configuration: configuration, delegate: self, delegateQueue: .main)
        }
    }

    public func request(method: HTTPMethod,
                        components: URLComponents,
                        headers: [HTTPHeader],
                        body: Data?,
                        endpoint: EndpointsProtocol,
                        onComplete: @escaping ServiceCompletion) {
        guard let url = components.url else {
            FXLog.shared.e("Could not create valid URL from components.")
            DispatchQueue.main.async {
                onComplete(nil, .customMessage(message: "Could not create valid URL from components."), nil, .unknown)
            }
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = body
        for header in headers {
            request.add(header: header)
        }
        self.log(request: request)
        let task = self.getSession().dataTaskCustom(with: request,
                                                    endpoint: endpoint) { (data, response, error) in
            self.proccessResponse(data: data, response: response, error: error, onComplete: onComplete)
        }
        task.resume()
    }

    private func proccessResponse(data: Data?,
                                  response: URLResponse?,
                                  error: Error?,
                                  onComplete: @escaping ServiceCompletion) {

        self.log(responseOpt: response, data: data, error: error)
        guard let response = response as? HTTPURLResponse else {
            DispatchQueue.main.async {
                onComplete(nil, .customMessage(message: "Did not get an http response"), nil, .unknown)
            }
            FXLog.shared.e("Did not get an http response")
            return
        }
        let statusCode = FXDStatusCode(code: response.statusCode)
        if let error = error as NSError? {
            DispatchQueue.main.async {
                onComplete(nil, .customMessage(message: "\(response.statusCode): \(error.localizedDescription)"), response, statusCode)
            }
            FXLog.shared.e(error)
            return
        }
        DispatchQueue.main.async {
            switch response.statusCode {
            case 200...299:
                onComplete(data, nil, response, statusCode)
            case 422:
                onComplete(data, nil, response, statusCode)
            case 401:
                onComplete(nil, .statusCode(statusCode: response.statusCode), response, statusCode)
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: .FXDUnauthorizedRequest, object: nil)
                }
            default:
                onComplete(nil, .statusCode(statusCode: response.statusCode), response, statusCode)
            }
        }
    }

    // MARK: GET
    public func get(path: EndpointsProtocol,
                    queryItems: [URLQueryItem]? = nil,
                    onComplete: @escaping ServiceCompletion) {
        var components = self.components(path: path.url)
        components.queryItems = queryItems
        request(method: .get,
                components: components,
                headers: defaultHeaders(),
                body: nil,
                endpoint: path,
                onComplete: onComplete)
    }

    // MARK: POST
    public func post(path: EndpointsProtocol,
                     dictionary: [String: Any],
                     onComplete: @escaping ServiceCompletion) {
        let jsonData = try? JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
        post(path: path,
             bodyData: jsonData,
             onComplete: onComplete)
    }

    public func post(path: EndpointsProtocol,
                     bodyData: Data? = nil,
                     onComplete: @escaping ServiceCompletion) {
        let components = self.components(path: path.url)
        request(method: .post,
                components: components,
                headers: defaultHeaders(),
                body: bodyData,
                endpoint: path,
                onComplete: onComplete)
    }
    
    open func defaultHeaders() -> [HTTPHeader] {
        var headers: [HTTPHeader] = []
        if let contentType = self.contentType {
            headers.append(HTTPHeader(field: .contentType, value: contentType))
            headers.append(HTTPHeader(field: .accept, value: contentType))
        }

//        if let authorizationKey = self.authorization,
//           let token = try? self.keychain?.get(authorizationKey) {
//            headers.append(FXDHTTPHeader(field: .authorization, value: "Bearer \(token)"))
//        }

        headers.append(HTTPHeader(field: .cacheControl, value: "no-cache"))

        return headers
    }

    private func components(path: String) -> URLComponents {
        var components = URLComponents()
        components.host = self.host
        components.path = path
        components.scheme = scheme
        return components
    }

    public func decode<M: Decodable>(jsonData: Data, using modelType: M.Type) -> M? {
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(modelType, from: jsonData)
            return result
        } catch let DecodingError.dataCorrupted(context) {
            FXLog.shared.e(context)
        } catch let DecodingError.keyNotFound(key, context) {
            FXLog.shared.e("Key '\(key)' not found: \(context.debugDescription)")
            FXLog.shared.e("codingPath: \(context.codingPath)")
        } catch let DecodingError.valueNotFound(value, context) {
            FXLog.shared.e("Value '\(value)' not found: \(context.debugDescription))")
            FXLog.shared.e("codingPath: \(context.codingPath))")
        } catch let DecodingError.typeMismatch(type, context) {
            FXLog.shared.e("Type '\(type)' mismatch: \(context.debugDescription))")
            FXLog.shared.e("codingPath: \(context.codingPath)")
        } catch {
            FXLog.shared.e("error:  \(error))")
        }
        return nil
    }

    private func log(request: URLRequest) {
        FXLog.shared.v("\n - - - - - - - - - - OUTGOING - - - - - - - - - - \n")
        defer { FXLog.shared.v("\n - - - - - - - - - -  END - - - - - - - - - - \n") }
        let urlAsString = request.url?.absoluteString ?? ""
        let urlComponents = URLComponents(string: urlAsString)
        let method = request.httpMethod != nil ? "\(request.httpMethod ?? "")" : ""
        let path = "\(urlComponents?.path ?? "")"
        let query = "\(urlComponents?.query ?? "")"
        let host = "\(urlComponents?.host ?? "")"
        var output = """
           \(urlAsString) \n\n
           \(method) \(path)?\(query) HTTP/1.1 \n
           HOST: \(host)\n
           """
        for (key, value) in request.allHTTPHeaderFields ?? [:] {
            output += "\(key): \(value) \n"
        }
        if let body = request.httpBody {
            output += "\n \(String(data: body, encoding: .utf8) ?? "")"
        }
        FXLog.shared.v(output)
    }

    private func log(responseOpt: URLResponse?, data: Data?, error: Error?) {
        let response = responseOpt as? HTTPURLResponse
        FXLog.shared.v("\n - - - - - - - - - - INCOMMING - - - - - - - - - - \n")
        defer { FXLog.shared.v("\n - - - - - - - - - -  END - - - - - - - - - - \n") }
        let urlString = response?.url?.absoluteString
        let components = NSURLComponents(string: urlString ?? "")
        let path = "\(components?.path ?? "")"
        let query = "\(components?.query ?? "")"
        var output = ""
        if let urlString = urlString {
            output += "\(urlString)"
            output += "\n\n"
        }
        if let statusCode = response?.statusCode {
            output += "HTTP \(statusCode) \(path)?\(query)\n"
        }
        if let host = components?.host {
            output += "Host: \(host)\n"
        }
        for (key, value) in response?.allHeaderFields ?? [:] {
            output += "\(key): \(value)\n"
        }
        if let body = data {
            output += "\n\(String(data: body, encoding: .utf8) ?? "")\n"
        }
        if error != nil {
            output += "\nError: \(error!.localizedDescription)\n"
        }
        FXLog.shared.v(output)
    }
}
// MARK: URLSessionDelegate
extension ServiceNetwork: URLSessionDelegate {

    public func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        if let serverTrust = challenge.protectionSpace.serverTrust {
            completionHandler(.useCredential, URLCredential.init(trust: serverTrust))
        } else {
            FXLog.shared.e("Error server trust nil")
            completionHandler(.useCredential, nil)
        }
    }
}

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case put = "PUT"
}

extension NSNotification.Name {
    public static let FXDUnauthorizedRequest: NSNotification.Name = NSNotification.Name(rawValue: "UnauthorizedRequest")
}

public enum FXDHTTPHeaderField: String {
    case contentType = "Content-Type"
    case authorization = "Authorization"
    case acceptLanguage = "Accept-Language"
    case cacheControl = "Cache-Control"
    case accept = "Accept"
}

public struct HTTPHeader {
    public var field: String
    public var value: String

    public init(field: FXDHTTPHeaderField, value: String) {
        self.field = field.rawValue
        self.value = value
    }

    public init(field: String, value: String) {
        self.field = field
        self.value = value
    }
}

public extension URLRequest {
    mutating func add(header: HTTPHeader) {
        self.addValue(header.value, forHTTPHeaderField: header.field)
    }
}


public enum FXDSessionTask {
    case mockupSession
    case defaultSession

    public var session: URLSessionProtocol? {
        switch self {
        case .mockupSession:
            return nil
        case .defaultSession:
            return nil
        }
    }
}

public typealias FXDDataTaskResult = (Data?, URLResponse?, Error?) -> Void

public protocol URLSessionProtocol {
    func dataTaskCustom(with request: URLRequest,
                        endpoint: EndpointsProtocol,
                        completionHandler: @escaping FXDDataTaskResult) -> FXDURLSessionDataTaskProtocol
}

extension URLSession: URLSessionProtocol {
    public func dataTaskCustom(with request: URLRequest,
                               endpoint: EndpointsProtocol,
                               completionHandler: @escaping FXDDataTaskResult) -> FXDURLSessionDataTaskProtocol {
        dataTask(with: request, completionHandler: completionHandler) as FXDURLSessionDataTaskProtocol
    }
}

public protocol FXDURLSessionDataTaskProtocol {
    func resume()
}
extension URLSessionDataTask: FXDURLSessionDataTaskProtocol { }


/// TODO: Pendiente para soporte iOS 15
@available(iOS 15.0, *)
public enum FXDSessionAsyncTask {
    case mockupSession
    case defaultSession

    public var session: FXDURLSessionAsyncProtocol? {
        switch self {
        case .mockupSession:
            return nil//FXDMockupSessionAsync()
        case .defaultSession:
            return nil
        }
    }
}

@available(iOS 15.0, *)
public typealias FXDDataTaskAsyncResult = (Data, URLResponse)

@available(iOS 15.0, *)
public protocol FXDURLSessionAsyncProtocol {
    func dataCustom(for request: URLRequest,
                    endpoint: EndpointsProtocol,
                    delegate: URLSessionTaskDelegate) async throws -> FXDDataTaskAsyncResult

    func dataCustom(for request: URLRequest,
                    endpoint: EndpointsProtocol) async throws -> FXDDataTaskAsyncResult
}

@available(iOS 15.0, *)
extension URLSession: FXDURLSessionAsyncProtocol {
    /// Convenience method to load data using an URLRequest, creates and resumes an URLSessionDataTask internally.
    ///
    /// - Parameter request: The URLRequest for which to load data.
    /// - Parameter delegate: Task-specific delegate.
    /// - Returns: Data and response.
    public func dataCustom(for request: URLRequest,
                           endpoint: EndpointsProtocol,
                           delegate: URLSessionTaskDelegate) async throws -> FXDDataTaskAsyncResult {
        try await data(for: request, delegate: delegate)
    }
    /// Convenience method to load data using an URLRequest, creates and resumes an URLSessionDataTask internally.
    ///
    /// - Parameter request: The URLRequest for which to load data.
    /// - Returns: Data and response.
    public func dataCustom(for request: URLRequest,
                           endpoint: EndpointsProtocol) async throws -> FXDDataTaskAsyncResult {
        try await data(for: request)
    }
}

@available(iOS 15.0, *)
public protocol FXDURLSessionAsyncDataTaskProtocol {
    func resume()
}
@available(iOS 15.0, *)
extension URLSessionDataTask: FXDURLSessionAsyncDataTaskProtocol { }

