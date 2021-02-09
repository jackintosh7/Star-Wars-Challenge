//
//  APIService.swift
//   Challenge
//
//  Created by Jack Higgins on 1/27/21.
//

import Alamofire

protocol APIService {

   associatedtype Request: Encodable
   associatedtype Response: Decodable

   var host: String { get }
   var path: String { get }
   var method: Alamofire.HTTPMethod { get }

   var headers: HTTPHeaders? { get }
   var request: Request? { get }

   var encoder: ParameterEncoder { get }
   var decoder: DataDecoder { get }
}

extension APIService where Request == Empty {

   var request: Request? { nil }
}

extension APIService {

   var host: String {
    APIConfig.api
   }

   var fullURL: String {
      var urlString = ""
      urlString += host

      if urlString.last != "/" && path.first != "/" {
         urlString += "/"
      } else if urlString.last == "/" && path.first == "/" {
         urlString.removeLast()
      }

      urlString += path

      return urlString
   }

   var headers: HTTPHeaders? {
      ["Content-Type": "application/json"]
   }
   
   var encoder: ParameterEncoder {
      if method == .get {
         return URLEncodedFormParameterEncoder.default
      }
      
      return JSONParameterEncoder.default
   }

   var decoder: DataDecoder {
      let formatter = DateFormatter()
      formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"

      let decoder = JSONDecoder()
      decoder.dateDecodingStrategy = .formatted(formatter)

      return decoder
   }

   func invoke(completion: @escaping (Result<Response, Error>) -> ()) {
      let req = AF.request(
         fullURL,
         method: method,
         parameters: request,
         encoder: encoder,
         headers: headers,
         requestModifier: nil
      )
      
      if Response.self is HTTPStatusCode.Type {
         req.response { response in
            guard let status = response.response?.status else {
               completion(
                  .failure(
                     AFError.responseValidationFailed(reason: .unacceptableStatusCode(code: -1))
                  )
               )
               return
            }
            
            // Force unwrapping in this case is safe because the response is a status code.
            completion(.success(status as! Response))
         }
      } else {
         req.responseDecodable(of: Response.self, queue: .main, decoder: decoder) { response in
            switch response.result {
            case .success(let response):
               completion(.success(response))
            case .failure(let error):
               completion(.failure(error))
            }
         }
      }
   }
}
