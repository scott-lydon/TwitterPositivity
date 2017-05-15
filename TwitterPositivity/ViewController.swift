
import UIKit
import TwitterKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var tutorialTextLabel: UILabel!
    @IBOutlet weak var handleTextField: UITextField!
    @IBOutlet weak var submitBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTwitterButton()
        
    }
    
    fileprivate func setupTwitterButton() {
        let twitterButton = TWTRLogInButton { (session, error) in
            if let err = error {
                print("Failed to login via Twitter: ", err)
                return
            }
            guard let token = session?.authToken else { return }
            guard let secret = session?.authTokenSecret else { return }
            let credentials = FIRTwitterAuthProvider.credential(withToken: token, secret: secret)
            
            FIRAuth.auth()?.signIn(with: credentials, completion: { (user, error) in
                
                if let err = error {
                    print("failed to login to firebase with Twitter", err)
                    return
                }
                
                print("Successfully created a Firebase-Twitter user", user?.uid ?? "")
                self.tutorialTextLabel.isHidden = true
                self.handleTextField.isHidden = false
                self.submitBtn.isHidden = false
                
                //unhide text field and submit button
            })
            print("Successfully logged in under Twitter...")
        }
        
        view.addSubview(twitterButton)
        
        twitterButton.frame = CGRect(x: 10, y: view.frame.height - 100, width: view.frame.width - 20, height: 50)
    }

    @IBAction func submitBtnPress(_ sender: Any) {
        if let input = handleTextField.text {
            Fetch.sharedInstance.getTweets(input) {tweets in
                print(tweets)
            }
        }
        
    }
  

}


//there would result "a marked effect on lowering the heart rate, pulse and respiration as compared to other colors."

//#FF91AF
