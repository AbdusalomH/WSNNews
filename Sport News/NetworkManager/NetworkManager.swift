import Foundation


class NetworkManager {
    
    static let shared = NetworkManager()
    
    let endPoint = "https://api.sport-news24.com/api"
    
    func signUp(username: String, email: String, password: String, country: String, completion: @escaping (Result<AuthModel, Error>) -> Void) {
        
        let signupEndPoint = endPoint + "/v1/sign-up/email/"
        
        guard let url = URL(string: signupEndPoint) else {return}
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let registraionRequest = RegistrationRequest(username: username, email: email, country: country, password: password, sex: 0, year_of_birth: 0, gclid: "", city: "")
        
        
        do {
            request.httpBody = try JSONEncoder().encode(registraionRequest)
        } catch {
            completion(.failure(error))
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, resp, error in
            if let error = error {
                print(error)
            }
            
            guard let response = resp as? HTTPURLResponse else {
                print("response error")
                return
            }

            
            guard let data = data else {return}
            
            do {
                let profile = try JSONDecoder().decode(AuthModel.self, from: data)
                completion(.success(profile))
                print(profile)
            } catch {
                completion(.failure(error))
                print("decode problems")
            }
        }
        task.resume()
    }
    
    func signIn(email: String, password: String, completion: @escaping (Result<AuthModel, Error>) -> Void) {
        
        let loginEndpoing = endPoint+"/v1/sign-in/email/"
        
        guard let url = URL(string: loginEndpoing) else { return }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
        let signInRequest = RegistrationRequest(username: "", email: email, country: "", password: password, sex: 0, year_of_birth: 0, gclid: "", city: "")
        
        
        do {
            request.httpBody = try JSONEncoder().encode(signInRequest)
        } catch {
            print(error)
            print("encoding problems")
        }
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error)
                print("error problems")
            }
            
            guard let response = response as? HTTPURLResponse else  {
                print("problems with respoinse")
                return
            }
            
            guard let data = data else {
                print("problems with data")
                return
            }
            
            do {
                let profile = try JSONDecoder().decode(AuthModel.self, from: data)
                completion(.success(profile))
                print(profile)
            } catch {
                completion(.failure(error))
                print("response problem")
            }
        }
        task.resume()
    }
    
    func changePassword(oldPassword: String, newPassword: String, completion: @escaping (Result<PasswordChange, Error>) -> Void) {
        
    }
    
    func getNews(page: Int, comletion: @escaping (Result<[NewsModel], Error>) -> Void) {
        //let newsEndPoint = "/v1/news/"
        
        let newsEndPoint = "/v1/news/?page_index=\(page)&page_size=100"
        
        
        guard let url = URL(string: endPoint+newsEndPoint) else { return }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        guard let token = KeychainManager.shared.getToken() else {return}

        print(token)
        request.allHTTPHeaderFields = [
            "Authorisazion" : token,
        ]
        
        let taks = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error)
                print("problems s errorom")
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("problems s response")
                return
            }
            
            guard let data = data else {
                print("problems s datoy")
                return
            }
            
            do {
                let respons = try JSONDecoder().decode([NewsModel].self, from: data)
                comletion(.success(respons))
            } catch {
                print(error)
                print("problems s kodirovkoy")
            }
        }
        taks.resume()
    }
    
    func getCategories(completion: @escaping (Result<[CategoriesModel], Error>) -> Void) {
        
        let categoriesEndPoint = "/v1/categories/"
        
        guard let url = URL(string: endPoint+categoriesEndPoint) else { return }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        guard let token = KeychainManager.shared.getToken() else {return}
        
        request.allHTTPHeaderFields = ["Autorization" : token]
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let erro = error {
                print("problems with error")
                return
            }
            
            guard let data = data else { return }

            do {
                let categories = try JSONDecoder().decode([CategoriesModel].self, from: data)
                completion(.success(categories))
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    func addFavoriteCategory(id: Int, completion: @escaping (Result<SuccessFavourite, Error>) -> Void) {
        
        let addFavodite = "/v1/categories/\(id)/follow/"
        
        guard let url = URL(string: endPoint+addFavodite) else {return}
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        
        guard let token = KeychainManager.shared.getToken() else {return}
        
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("error when request")
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("response problems")
                return
            }
            
            guard let data = data else {
                print("problems with data")
                return
            }
            
            do {
                let setFavorite = try JSONDecoder().decode(SuccessFavourite.self, from: data)
                completion(.success(setFavorite))
            } catch {
                print(error.localizedDescription)
                
            }
        }
        task.resume()
    }
    
    func followingUsersCategories(completion: @escaping (Result<[CategoriesModel], Error>) -> Void) {
        
        let usersFollowingCategories = "/v1/categories/followed/"
        
        guard let url = URL(string: endPoint+usersFollowingCategories) else {return}
                
        guard let token = KeychainManager.shared.getToken() else {return}
                
        var request = URLRequest(url: url)
                
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Autorization")

        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                print("problems s error")
            }
            
            guard let data = data else { return }
            
            do {
                let userFaforite = try JSONDecoder().decode([CategoriesModel].self, from: data)
                //let usersData = try JSONSerialization.jsonObject(with: data, options: [])
                //print(usersData)
                completion(.success(userFaforite))
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    func getNewsDetails(id: Int, completion: @escaping (Result<NewsModelDetails, WSNErrors>) -> Void) {
        
        let detailsUrl = "/v1/news/\(id)/"
        
        guard let url = URL(string: endPoint+detailsUrl) else { return }
                
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        guard let token = KeychainManager.shared.getToken() else { return }
        
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Autorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                print(error)
                completion(.failure(WSNErrors.invalidResponse))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                print(response)
                completion(.failure(WSNErrors.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let details = try JSONDecoder().decode(NewsModelDetails.self, from: data)
                //let details2 = try JSONSerialization.jsonObject(with: data, options: [])
                //print(details2)
                completion(.success(details))
            } catch {
                print("error when decoding")
                
            }
        }
        task.resume()
    }
}




