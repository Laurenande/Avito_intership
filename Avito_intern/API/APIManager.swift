//
//  APIManager.swift
//  Avito_intern
//
//  Created by Егор Куракин on 18.10.2022.
//

import Foundation

enum  nameCompanyResults{
    case success(nameCompany: NameCompany)
    case failure(error: Error)
    
}

class APIManager {
    let urlString = URL(string: "https://run.mocky.io/v3/1d1cb4ec-73db-4762-8c4b-0b8aa3cecd4c")
    let session = URLSession.shared
    let decoder = JSONDecoder()
    
    
    let urlRequest = URLRequest(url: URL(string: "https://run.mocky.io/v3/1d1cb4ec-73db-4762-8c4b-0b8aa3cecd4c")!,
                                cachePolicy: .returnCacheDataElseLoad,
                                timeoutInterval: 10)
    
    
    
    func loadEmployees(complition: @escaping (nameCompanyResults) -> Void){
        //check valid url
        guard let url = urlRequest.url else { return }
        //check for outdated cache
        cleanCache()
        
        session.dataTask(with: urlRequest) { [weak self] data, response, error in
            var result: nameCompanyResults
            
            defer{
                DispatchQueue.main.async {
                    complition(result)
                }
            }
            guard let strongSelf = self else {
                result = .failure(error: error!)
                return
            }
            
            if error == nil, let parsData = data{
                do {
                    let employees = try strongSelf.decoder.decode(NameCompany.self, from: parsData)
                    
                    result = .success(nameCompany: employees)
                    
                } catch {
                    result = .failure(error: error)
                    return
                }
            } else {
                result = .failure(error: error!)
            }
            
        }.resume()
        
        
    }
    
    func cleanCache() {
        if (UserDefaults.standard.object(forKey: "dateCahe") == nil){
            UserDefaults.standard.set(Date(), forKey: "dateCahe")
        }
        let dateCreateCache = UserDefaults.standard.object(forKey: "dateCahe") as! Date
        
        let dateNow = Date()
        if dateNow.timeIntervalSince(dateCreateCache) > 3600{
            if let cache = self.session.configuration.urlCache{
                cache.removeAllCachedResponses()
                UserDefaults.standard.set(Date(), forKey: "dateCahe")
            }
        }
        
    }
}
