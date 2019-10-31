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
    
    //MARK: - variables
    private var total: Double = 0           //Total
    private var temp: Double = 0            //Valor por pantalla
    private var operating = false            //Indicar si se ha seleccionado un operador
    private var decimal = false             //Indica si el valor es decimal
    private var operation: operacionTipo = .none
    
    //MARK: - constantes
    private let kDecimalSeparator = Locale.current.decimalSeparator!
    private let kMaxLength = 9
    private let ktotal = "total"
    
    private enum operacionTipo {
        case none, addition, substraction, multiplication, division, percent
    }
    
    //Formateo de valores auxiliar
    private let auxFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        let locale = Locale.current
        formatter.groupingSeparator = ""
        formatter.decimalSeparator = locale.decimalSeparator
        formatter.numberStyle = .decimal
        formatter.maximumIntegerDigits = 100
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 100
        return formatter
    }()
    
    // Formateo de valores auxiliares totales
    private let auxTotalFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = ""
        formatter.decimalSeparator = ""
        formatter.numberStyle = .decimal
        formatter.maximumIntegerDigits = 100
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 100
        return formatter
    }()
    
    // Formateo de valores por pantalla por defecto
    private let printFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        let locale = Locale.current
        formatter.groupingSeparator = locale.groupingSeparator
        formatter.decimalSeparator = locale.decimalSeparator
        formatter.numberStyle = .decimal
        formatter.maximumIntegerDigits = 9
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 8
        return formatter
    }()
    
    // Formateo de valores por pantalla en formato científico
    private let printScientificFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .scientific
        formatter.maximumFractionDigits = 3
        formatter.exponentSymbol = "e"
        return formatter
    }()
    
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
        
        numberDecimal.setTitle(kDecimalSeparator, for: .normal)
        
        total = UserDefaults.standard.double(forKey: ktotal)
        
        result()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
        clear()
        
        sender.shine()
    }
    
    @IBAction func operatorMasMenosAction(_ sender: UIButton) {
        temp = temp * (-1)
        resultLabel.text = printFormatter.string(from: NSNumber(value: temp))
        
        sender.shine()
    }
    
    @IBAction func operatorPercentAction(_ sender: UIButton) {
        
        if operation != .percent {
            result()
        }
        
        operating = true
        operation = .percent
        
        sender.shine()
    }
    
    @IBAction func operatorIgualAction(_ sender: UIButton) {
        result()
        
        sender.shine()
    }
    
    @IBAction func operatorMasAction(_ sender: UIButton) {
        if operation != .none {
            result()
        }
        
        operating = true
        operation = .addition
        sender.selectOperation(true)
        
        sender.shine()
    }
    
    @IBAction func operatorMenosAction(_ sender: UIButton) {
        if operation != .none {
            result()
        }
        
        operating = true
        operation = .substraction
        sender.selectOperation(true)
        
        sender.shine()
    }
    
    @IBAction func operatorMultiplicacionAction(_ sender: UIButton) {
        if operation != .none {
            result()
        }
        
        operating = true
        operation = .multiplication
        sender.selectOperation(true)
        
        sender.shine()
    }
    
    @IBAction func operatorDivisionAction(_ sender: UIButton) {
        if operation != .none {
            result()
        }
        
        operating = true
        operation = .division
        sender.selectOperation(true)
        
        sender.shine()
    }
    
    @IBAction func numberDecimalAction(_ sender: UIButton) {
        let currentTemp = auxTotalFormatter.string(from: NSNumber(value: temp))!
        
        if !operating && currentTemp.count >= kMaxLength {
            return
        }
        
        resultLabel.text = resultLabel.text! + kDecimalSeparator
        decimal = true
        
        selectVisualOperation()
        
        sender.shine()
    }
    
    @IBAction func numberAction(_ sender: UIButton) {
        operatorAC.setTitle("C", for: .normal)
        
        var currentTemp = auxTotalFormatter.string(from: NSNumber(value: temp))!
        
        if !operating && currentTemp.count >= kMaxLength {
            return
        }
        
        currentTemp = auxFormatter.string(from: NSNumber(value: temp))!
        
        //hemos seleccionado una operacion
        if operating {
            total = total == 0 ? temp : total
            resultLabel.text = ""
            currentTemp = ""
            operating = false
        }
        
        //hemos seleccionado decimales
        if decimal {
            currentTemp = "\(currentTemp)\(kDecimalSeparator)"
            decimal = false
        }
        
        let number = sender.tag
        temp = Double(currentTemp + String(number))!
        resultLabel.text = printFormatter.string(from: NSNumber(value: temp))
        
        selectVisualOperation()
        
        sender.shine()
    }
    
    //limpiar valores
    private func clear() {
        operation = .none
        operatorAC.setTitle("AC", for: .normal)
        if temp != 0 {
            temp = 0
            resultLabel.text = "0"
        } else {
            total = 0
            result()
        }
    }
    
    //obtiene el resultado final
    private func result() {
        
        switch operation {
            
        case .none:
            //no hacemos nada
            break
        case .addition:
            total = total + temp
            break
        case .substraction:
            total = total - temp
            break
        case .multiplication:
            total = total * temp
            break
        case .division:
            total = total / temp
            break
        case .percent:
            temp = temp / 100
            total = temp
            break
        }
        
        //formateo en la pantalla
        if let currentTotal = auxFormatter.string(from: NSNumber(value: total)), currentTotal.count > kMaxLength {
            resultLabel.text = printScientificFormatter.string(from: NSNumber(value: total))
        } else {
            resultLabel.text = printFormatter.string(from: NSNumber(value: total))
        }
        
        operation = .none
        
        selectVisualOperation()
        
        UserDefaults.standard.set(total, forKey: ktotal)
        
        print("TOTAL \(total)")
        
    }
    
    //muestra de forma visual la operacion seleccionada
    private func selectVisualOperation() {
        
        if !operating {
            //no estamos operando
            operatorMas.selectOperation(false)
            operatorMenos.selectOperation(false)
            operatorMultiplicacion.selectOperation(false)
            operatorDivision.selectOperation(false)
        } else {
            switch operation {
                
            case .none, .percent:
                operatorMas.selectOperation(false)
                operatorMenos.selectOperation(false)
                operatorMultiplicacion.selectOperation(false)
                operatorDivision.selectOperation(false)
                break
            case .addition:
                operatorMas.selectOperation(true)
                operatorMenos.selectOperation(false)
                operatorMultiplicacion.selectOperation(false)
                operatorDivision.selectOperation(false)
                break
            case .substraction:
                operatorMas.selectOperation(false)
                operatorMenos.selectOperation(true)
                operatorMultiplicacion.selectOperation(false)
                operatorDivision.selectOperation(false)
                break
            case .multiplication:
                operatorMas.selectOperation(false)
                operatorMenos.selectOperation(false)
                operatorMultiplicacion.selectOperation(true)
                operatorDivision.selectOperation(false)
                break
            case .division:
                operatorMas.selectOperation(false)
                operatorMenos.selectOperation(false)
                operatorMultiplicacion.selectOperation(false)
                operatorDivision.selectOperation(true)
                break
            }
        }
        
    }
    
}
