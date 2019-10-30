//
//  HomeViewController.swift
//  iCalculator
//
//  Created by Abel Lazaro on 30/10/19.
//  Copyright © 2019 Abel Lázaro. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController {
    
    //MARK: - outlets
    //resultado
    @IBOutlet weak var resultLabel: UILabel!
    //numeros
    @IBOutlet weak var number0: UIButton!
    @IBOutlet weak var number1: UIButton!
    @IBOutlet weak var number2: UIButton!
    @IBOutlet weak var number3: UIButton!
    @IBOutlet weak var number4: UIButton!
    @IBOutlet weak var number5: UIButton!
    @IBOutlet weak var number6: UIButton!
    @IBOutlet weak var number7: UIButton!
    @IBOutlet weak var number8: UIButton!
    @IBOutlet weak var number9: UIButton!
    @IBOutlet weak var numberDecimal: UIButton!
    //operadores
    @IBOutlet weak var operatorAC: UIButton!
    @IBOutlet weak var operatorMasMenos: UIButton!
    @IBOutlet weak var operatorPercent: UIButton!
    @IBOutlet weak var operatorIgual: UIButton!
    @IBOutlet weak var operatorMas: UIButton!
    @IBOutlet weak var operatorMenos: UIButton!
    @IBOutlet weak var operatorMultiplicacion: UIButton!
    @IBOutlet weak var operatorDivision: UIButton!
    
    //MARK: - inicializacion
    init() {
        super.init(nibName:nil , bundle:nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implement")
    }
    //MARK: - ciclo de vida
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UI
        number0.round()
        number1.round()
        number2.round()
        number3.round()
        number4.round()
        number5.round()
        number6.round()
        number7.round()
        number8.round()
        number9.round()
        numberDecimal.round()
        
        operatorAC.round()
        operatorMasMenos.round()
        operatorPercent.round()
        operatorIgual.round()
        operatorMas.round()
        operatorMenos.round()
        operatorMultiplicacion.round()
        operatorDivision.round()
        
    }
    
    //MARK: - Accion de botones
    @IBAction func operatorACAction(_ sender: UIButton) {
        sender.shine()
    }
    
    @IBAction func operatorMasMenosAction(_ sender: UIButton) {
        sender.shine()
    }
    
    @IBAction func operatorPercentAction(_ sender: UIButton) {
        sender.shine()
    }
    
    @IBAction func operatorIgualAction(_ sender: UIButton) {
        sender.shine()
    }
    
    @IBAction func operatorMasAction(_ sender: UIButton) {
        sender.shine()
    }
    
    @IBAction func operatorMenosAction(_ sender: UIButton) {
        sender.shine()
    }
    
    @IBAction func operatorMultiplicacionAction(_ sender: UIButton) {
        sender.shine()
    }
    
    @IBAction func operatorDivisionAction(_ sender: UIButton) {
        sender.shine()
    }
    
    @IBAction func numberDecimalAction(_ sender: UIButton) {
        sender.shine()
    }
    
    @IBAction func numberAction(_ sender: UIButton) {
        sender.shine()
        print(sender.tag)
    }
    
}
