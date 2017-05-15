
import Foundation


class Fetch {
    
    static let sharedInstance = Fetch()
    
    init() {}
    
    func getTweets(_ handle: String, completion: @escaping ([String]) -> Void) {
        
        var tweets = [String]()
    
        let scriptUrl = "https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=\(handle)&count=100"

        let myUrl = URL(string: scriptUrl);
    
        var request = URLRequest(url:myUrl! as URL);

        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in

            if error != nil
            {
                print("error=\(error)")
                return
            }
            

            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("responseString = \(responseString)")
            
 
            do {
                if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [[String: Any]] {
                    
                    print(json)
                    
                    for tweetsInJson in json {
                        
                        if let text = tweetsInJson["text"] as? String {
                            
                            tweets += [text]
                        }
                    }
                    
                    completion(tweets)
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
        }
        
        task.resume()
        
    }
}
