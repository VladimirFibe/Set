import UIKit

struct Card {
    let color: Color
    let shading: Shading
    let shape: Shape

    enum Shape {
        case diamond
        case capsule
        case squiggle
    }

    enum Shading {
        case striped
        case solid
        case open
    }

    enum Color {
        case green
        case red
        case purple

        var uiColor: UIColor {
            switch self {
            case .green: return .systemGreen
            case .red: return .systemRed
            case .purple: return .systemPurple
            }
        }
    }
}

class CardView: UIView {

    let padding = 16.0
    let spacing = 16.0
    var count = 3
    var card = Card(color: .red, shading: .striped, shape: .squiggle)

    override func draw(_ rect: CGRect) {
        var shapeRect = rect
        shapeRect.size.height = (rect.height - (2 * padding + 2 * spacing)) / 3
        shapeRect.size.width -= 2 * padding
        shapeRect.origin.x = padding
        shapeRect.origin.y = rect.midY - (shapeRect.height * CGFloat(count) + spacing * CGFloat(count - 1)) / 2
        for _ in 0..<count {
            drawShape(shapeRect, card: card)
            shapeRect.origin.y += shapeRect.height + spacing
        }
    }

    private func drawShape(_ rect: CGRect, card: Card) {
        let path: UIBezierPath
        switch card.shape {
        case .diamond:
            path = pathForDiamond(rect)
        case .capsule:
            path = pathForCapsule(rect)
        case .squiggle:
            path = pathForSquiggle(rect)
        }
        card.color.uiColor.setFill()
        card.color.uiColor.setStroke()
        path.lineWidth = 3
        switch card.shading {
        case .striped:
            path.stroke()
            let context = UIGraphicsGetCurrentContext()
            context?.saveGState()
            path.addClip()
            let line = pathForLines(rect)
            line.lineWidth = path.lineWidth
            line.stroke()
            context?.restoreGState()
        case .solid:
            path.fill()
        case .open:
            path.stroke()
        }
    }

    private func pathForLines(_ rect: CGRect) -> UIBezierPath {
        let path = UIBezierPath()
        let step = rect.width / 8
        var x = rect.minX
        for _ in 0..<7 {
            x += step
            path.move(to: CGPoint(x: x, y: rect.minY))
            path.addLine(to: CGPoint(x: x, y: rect.maxY))
        }
        return path
    }

    private func pathForDiamond(_ rect: CGRect) -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        path.close()
        return path
    }

    private func pathForCapsule(_ rect: CGRect) -> UIBezierPath {
        let radius = min(rect.height, rect.width) / 2
        let path = UIBezierPath(roundedRect: rect, cornerRadius: radius)
        return path
    }

    private func pathForSquiggle(_ rect: CGRect) -> UIBezierPath {
        let path = UIBezierPath()
        let width = rect.size.width
        let height = rect.size.height
        let x = rect.origin.x
        let y = rect.origin.y
        path.move(to: CGPoint(x: x + 0.5229 * width, y: y + 0.86546*height))
        path.addCurve(
            to: CGPoint(x: x + 0.22762 * width, y: y + 0.83182 * height),
            controlPoint1: CGPoint(x: x + 0.42715 * width, y: y + 0.77765 * height),
            controlPoint2: CGPoint(x: x + 0.34393 * width, y: y + 0.72413 * height)
        )
        path.addCurve(
            to: CGPoint(x: x + 0.0458 * width, y: y + 0.97788 * height),
            controlPoint1: CGPoint(x: x + 0.14356 * width, y: y + 0.90976 * height),
            controlPoint2: CGPoint(x: x + 0.09311 * width, y: y + 1.05556 * height)
        )
        path.addCurve(
            to: CGPoint(x: x + 0.09224 * width, y: y + 0.24579 * height),
            controlPoint1: CGPoint(x: x - 0.01638 * width, y: y + 0.87651 * height),
            controlPoint2: CGPoint(x: x - 0.02795 * width, y: y + 0.51988 * height)
        )
        path.addCurve(
            to: CGPoint(x: x + 0.52553 * width, y: y + 0.15726 * height),
            controlPoint1: CGPoint(x: x + 0.20707 * width, y: y - 0.01533 * height),
            controlPoint2: CGPoint(x: x + 0.42635 * width, y: y + 0.04733 * height)
        )
        path.addCurve(
            to: CGPoint(x: x + 0.85133 * width, y: y + 0.03687 * height),
            controlPoint1: CGPoint(x: x + 0.61715 * width, y: y + 0.25883 * height),
            controlPoint2: CGPoint(x: x + 0.725 * width, y: y + 0.22058 * height)
        )
        path.addCurve(
            to: CGPoint(x: x + 0.95727 * width, y: y + 0.70998 * height),
            controlPoint1: CGPoint(x: x + 0.97088 * width, y: y - 0.1373 * height),
            controlPoint2: CGPoint(x: x + 1.05478 * width, y: y + 0.34222 * height)
        )
        path.addCurve(
            to: CGPoint(x: x + 0.5229 * width, y: y + 0.86546 * height),
            controlPoint1: CGPoint(x: x + 0.87238 * width, y: y + 1.02995 * height),
            controlPoint2: CGPoint(x: x + 0.71312 * width, y: y + 1.04002 * height)
        )
        return path
    }
}
