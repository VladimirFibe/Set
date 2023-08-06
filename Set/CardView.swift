import UIKit

class CardView: UIView {

    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(roundedRect: CGRect(x: 10, y: 10, width: rect.width - 20, height: 60), cornerRadius: 30)
//        path.move(to: CGPoint(x: rect.midX, y: 10))
//        path.addLine(to: CGPoint(x: rect.width - 10, y: rect.midY))
//        path.addLine(to: CGPoint(x: 10, y: rect.midY))
//        path.close()

        UIColor.green.setFill()
        UIColor.red.setStroke()
        path.lineWidth = 3
        path.fill()
        path.stroke()
    }
}
