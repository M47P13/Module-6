//
//  Sketch_TesterApp.swift
//  Sketch Tester
//
//  Created by Maya Thompson on 12/7/23.
//

import UIKit

// MARK: - Models

struct DrawingPoint {
    var x: CGFloat
    var y: CGFloat
}

enum DrawingColor {
    case red
    case blue
    // Add more colors as needed
}

struct DrawingShape {
    var coordinates: [DrawingPoint]
    var color: DrawingColor
    var shapeLayer: CAShapeLayer = CAShapeLayer()
    
    mutating func draw(on layer: CALayer) {
        let path = UIBezierPath()
        guard let startPoint = coordinates.first else { return }
        path.move(to: CGPoint(x: startPoint.x, y: startPoint.y))
        
        for point in coordinates.dropFirst() {
            path.addLine(to: CGPoint(x: point.x, y: point.y))
        }
        
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = UIColor.getColor(from: color).cgColor
        shapeLayer.fillColor = nil
        layer.addSublayer(shapeLayer)
    }
}

extension UIColor {
    static func getColor(from color: DrawingColor) -> UIColor {
        switch color {
        case .red:
            return UIColor.red
        case .blue:
            return UIColor.blue
        }
    }
}

// MARK: - DrawingApp

class DrawingApp {
    var canvas = DrawingCanvas()
    var currentLayerIndex = 0
    
    func addShape(_ shape: DrawingShape) {
        canvas.layers[currentLayerIndex].addShape(shape)
    }
    
    func undo() {
        canvas.layers[currentLayerIndex].removeLastShape()
    }
}

// MARK: - Canvas

class DrawingCanvas: UIView {
    var layers: [DrawingLayer] = []
    
    func addLayer() {
        let newLayer = DrawingLayer()
        layers.append(newLayer)
        layer.addSublayer(newLayer)
    }
}

// MARK: - Layer

class DrawingLayer: CALayer {
    var shapes: [DrawingShape] = []
    
    func addShape(_ shape: DrawingShape) {
        var mutableShape = shape
        mutableShape.draw(on: self)
        shapes.append(mutableShape)
    }
    
    func removeLastShape() {
        if let lastShape = shapes.last {
            lastShape.shapeLayer.removeFromSuperlayer()
            shapes.removeLast()
        }
    }
}

// MARK: - ViewController (UI Code)

class ViewController: UIViewController {
    var drawingApp = DrawingApp()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        drawingApp.canvas.addLayer()
    }
    
    func setupUI() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        let point = gesture.location(in: view)
        
        let newShape = DrawingShape(coordinates: [DrawingPoint(x: point.x, y: point.y)], color: .red)
        drawingApp.addShape(newShape)
    }
}
