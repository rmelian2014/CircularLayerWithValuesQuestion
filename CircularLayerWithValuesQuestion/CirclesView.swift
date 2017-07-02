//
//  CirclesView.swift
//  CircularLayerWithValuesQuestion
//
//  Created by Reinier Melian on 01/07/2017.
//  Copyright © 2017 Pruebas. All rights reserved.
//

import UIKit

class CirclesView: UIView {
    
    var labelValues : UILabel?
    var labelEmpty : UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.emptyCicle = CircularCAShapeLayer(50, startDegree: 270, amountDegree: 360)
        self.emptyCicle?.lineWidth = 20
        self.emptyCicle?.strokeColor = UIColor.white.cgColor
        self.emptyCicle?.fillColor = UIColor.clear.cgColor
        
        self.labelValues = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 25))
        self.labelValues?.text = "test"
        self.labelValues?.textColor = UIColor.black
        
        self.valueCircle = CircularCAShapeLayer(50, startDegree: 270, amountDegree: 0)
        self.valueCircle?.lineWidth = 20
        self.valueCircle?.strokeColor = UIColor.red.cgColor
        self.valueCircle?.fillColor = UIColor.clear.cgColor
        self.valueCircle?.addHead(self.labelValues)
    }
    
    func animateToAngle(angle:CGFloat)
    {
        self.valueCircle?.animateEndDegreeValue(to: Float(angle))
        self.labelValues?.text = "\(angle)"
    }

    //MARK: LAYER STUFFS
    var emptyCicle: CircularCAShapeLayer?{
        didSet{
            if(self.emptyCicle != nil)
            {
                self.layer.addSublayer(self.emptyCicle!)
                self.emptyCicle!.actions = ["position": NSNull(),"frame":NSNull(),"bounds":NSNull()]
            }
        }
    }
    
    var valueCircle: CircularCAShapeLayer?{
        didSet{
            if(self.valueCircle != nil)
            {
                self.layer.addSublayer(self.valueCircle!)
                self.valueCircle!.actions = ["position": NSNull(),"frame":NSNull(),"bounds":NSNull()]
            }
        }
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        emptyCicle?.frame = self.bounds
        valueCircle?.frame = self.bounds
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
