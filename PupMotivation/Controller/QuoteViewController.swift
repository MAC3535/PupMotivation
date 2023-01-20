
import UIKit

var dogPicture: Data?

class QuoteViewController: UIViewController {
    @IBOutlet private var picture: UIView!
    @IBOutlet private var quoteField: UITextView!
    @IBOutlet private var realPicture: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let answer = dogPicture else {return}
        realPicture.image = UIImage(data: answer)
        quoteField.text = """
        "\(quote)"
        - \(author)
        """
        
        navigationController?.hidesBarsOnTap = true 
    }
}
