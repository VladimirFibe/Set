import UIKit

class ViewController: UIViewController {

    let cardView = CardView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
}
// MARK: - Setup Views
extension ViewController {
    private func setupViews() {
        view.backgroundColor = .black
        setupCardView()
    }

    private func setupCardView() {
        view.addSubview(cardView)
        cardView.frame = CGRect(x: 50, y: 100, width: 200, height: 300)
        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 20
        cardView.layer.masksToBounds = true
    }
}

