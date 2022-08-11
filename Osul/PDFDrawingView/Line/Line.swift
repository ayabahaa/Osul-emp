//
//  Line.swift
//  AL-HHALIL
//
//  Created by Sayed Abdo on 7/14/20.
//  Copyright © 2020 Sayed Abdo. All rights reserved.
//


import Foundation
import UIKit

class Line: Equatable{
    static func == (lhs: Line, right: Line) -> Bool{
        return lhs.points == right.points
    }
    var points: [CGPoint]
    var layer = CAShapeLayer()
    var _path = UIBezierPath()
    var predicted = [CGPoint]()
    
    var first: CGPoint?{
        return points.first
    }
    var last: CGPoint? {
        return points.last
    }
    
    var path: UIBezierPath{
        let newPath = UIBezierPath()
        var previousPoint = points.last!
        newPath.append(_path)
        for point in predicted{
            newPath.addQuadCurve(to: point, controlPoint: previousPoint.midPoint(with: point))
            previousPoint = point
        }
        return newPath
    }
    init(startingPoint: CGPoint){
        points = [startingPoint]
        layer.strokeColor = UIColor.blue.cgColor
        layer.lineWidth = ConstantsPdfData.lineWidth + ConstantsPdfData.halfPointShift
    }
    func drawLine(path: UIBezierPath? = nil){}
    
    // Performs a zoom operation on this line
    @discardableResult
    func zoom(scale: CGFloat, moveBy: CGVector?) -> CGVector{
        let bounds = _path.bounds
        _path.apply(CGAffineTransform(scaleX: scale, y: scale))
        let move: CGVector
        let newBounds = _path.bounds
        move = moveBy ?? CGVector(dx: bounds.midX - newBounds.midX, dy: bounds.midY - newBounds.midY)
        points = points.map({$0.applying(CGAffineTransform(scaleX: scale, y: scale))})
        translate(by: move)
        return move
    }
    // Performs a translate operation on this line
    func translate(by vector: CGVector){
        points = points.map({$0.moveBy(x: vector.dx, y: vector.dy)})
        _path.apply(CGAffineTransform(translationX: vector.dx, y: vector.dy))
        self.drawLine()
    }
}
