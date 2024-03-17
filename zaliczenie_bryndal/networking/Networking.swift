import Foundation
import Amplify
import AWSPluginsCore
import Foundation

class Networking {
    

    static func PostImage(url: String, imageData: Data) async {
        let idToken = await getIdToken()
        let boundary = UUID().uuidString
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        
        // Set the Content-Type header to multipart/form-data
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        // Add Authorization header
        request.setValue("Bearer \(idToken)", forHTTPHeaderField: "Authorization")
        
        // Set the image data as the request body
        var body = Data()
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"file\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        body.append(imageData)
        body.append("\r\n".data(using: .utf8)!)
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        request.httpBody = body
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            // Handle the response here
            if let httpResponse = response as? HTTPURLResponse {
                print("Response status code: \(httpResponse.statusCode)")
                // Handle success or failure based on status code
            }
            
            if let data = data {
                // Parse response data if needed
            }
        }.resume()
    }




    static func Post(url: String) async {
        let idToken = await getIdToken()
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer \(idToken)", forHTTPHeaderField: "Authorization")
        
        // TODO: Add your post request body and handle the response
    }
    
    static func Get(url: String) async -> [String: Any]? {
        let idToken = await getIdToken()
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer \(idToken)", forHTTPHeaderField: "Authorization")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            // Check for response error
            if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                print("HTTP Error: \(httpResponse.statusCode)")
                return nil
            }
            
            // Parse JSON data
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                return json
            }
        } catch {
            print("Error: \(error)")
        }
        
        return nil
    }



    private static func getIdToken() async -> String {
        do {
            Amplify.Logging.logLevel = .verbose

            let session = try await Amplify.Auth.fetchAuthSession()
            if let cognitoTokenProvider = session as? AuthCognitoTokensProvider {
                let tokens = try cognitoTokenProvider.getCognitoTokens().get()
                print("Id token fetched successfully")
                return tokens.idToken
            }
        } catch let error as AuthError {
            print("Fetch auth session failed with error - \(error)")
        } catch {
            print("getIdToken - error - \(error)")
        }
        return ""
    }
}
