//
//  ViewController.swift
//  AltinBorsaDovizApp
//
//  Created by Metehan Karadeniz on 8.06.2023.
//

import UIKit
import SwiftyJSON
import Alamofire
final class HomeViewController: UIViewController,UITextFieldDelegate {
    private var viewModel = CurrencyViewModel()
    private let currencies = ["USD", "EUR", "GBP", "JPY"]
    private var firstCurrency = ""
    private var secondCurrency = ""
    private var currencyValue = ""

    private var firstCurrencyField = setCustomTextField()
    private var secondCurrencyField = setCustomTextField()
    private var currencyValueTextField = setCustomTextField()
    private let calculateButton = setCalculateButton()
    private let resultLabel = setCustomLabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "21262F")
        
        setUI()
        editObjects()
       
        firstCurrencyField.delegate = self
        secondCurrencyField.delegate = self
        currencyValueTextField.delegate = self
        
    }
    private func editObjects(){
        firstCurrencyField.placeholder = "Select first currency"
        secondCurrencyField.placeholder = "Select second currency"
        firstCurrencyField.backgroundColor = UIColor(hex: "361635")
        secondCurrencyField.backgroundColor = UIColor(hex: "361635")
        currencyValueTextField.backgroundColor = UIColor(hex: "361635")
        resultLabel.text = "result"
        resultLabel.textAlignment = .center
        
        // Text alanları için giriş yöntemi olarak picker view kullanma
              firstCurrencyField.inputView = createPickerView()
              secondCurrencyField.inputView = createPickerView()
              
              // Toolbara geri düğmesi ekleme
              firstCurrencyField.inputAccessoryView = createToolbar()
              secondCurrencyField.inputAccessoryView = createToolbar()
        
        calculateButton.addTarget(self, action: #selector(calculateBtnnTappd), for: .touchUpInside)
    }
    // Picker view oluşturma ve para birimleriyle doldurma
    func createPickerView() -> UIPickerView {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        return pickerView
    }
    
    // Toolbara geri düğmesi ekleme
    func createToolbar() -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        toolbar.setItems([doneButton], animated: true)
        return toolbar
    }
    @objc func doneButtonTapped() {
           view.endEditing(true)
       }
    @objc func calculateBtnnTappd() {
        if currencyValueTextField.text != "" {
            currencyValue = currencyValueTextField.text!
            if let value = Int(currencyValue) {
                if let firstCurrency = firstCurrencyField.text {
                    if let secondCurrency = secondCurrencyField.text {
                        
                        fetchCurrencies(currencyValue: value, to: secondCurrency, base: firstCurrency)
                        print("butona tıklandı")
                    }
                }
            }
        }
       }
    private func setUI(){
        view.addSubview(firstCurrencyField)
        view.addSubview(secondCurrencyField)
        view.addSubview(currencyValueTextField)
        view.addSubview(calculateButton)
        view.addSubview(resultLabel)
        
        NSLayoutConstraint.activate([
        
            firstCurrencyField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            firstCurrencyField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            firstCurrencyField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            firstCurrencyField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1.0/19.0),
            
            secondCurrencyField.topAnchor.constraint(equalTo: firstCurrencyField.bottomAnchor, constant: 30),
            secondCurrencyField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            secondCurrencyField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            secondCurrencyField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1.0/19.0),
            
            currencyValueTextField.topAnchor.constraint(equalTo: secondCurrencyField.bottomAnchor, constant: 30),
            currencyValueTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            currencyValueTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            currencyValueTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1.0/19.0),
            
            calculateButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1.0/17.0),
            calculateButton.topAnchor.constraint(equalTo: currencyValueTextField.bottomAnchor, constant: 30),
            calculateButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            calculateButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            
            resultLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1.0/18.0),
            resultLabel.topAnchor.constraint(equalTo: calculateButton.bottomAnchor, constant: 35),
            resultLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 80),
            resultLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -80)
            
            
        ])
    
    }
   private func fetchCurrencies(currencyValue: Int,to: String,base: String) {
       viewModel.fetchCurrencies(currencyValue: currencyValue,to: to,base: base) { [weak self] in
            guard let self = self else { return }
            for currency in self.viewModel.currencies {
                // bir isim dizisi olmayacak burada. tek bir sonuç dönecek ancak eğer olsaydı böyle yapabilirdin.
               // self.namesArray.append(currency.name)
                print("name: \(currency.name)")
              
                print("code: \(currency.code)")
                
                print("rate: \(currency.rate)")
               
                print("calculated: \(currency.calculated)")
                DispatchQueue.main.async {
                    self.resultLabel.text = String(currency.calculated)
                }
               
            }
        }
    }
}

extension HomeViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    // Picker view'da gösterilecek para birimi sayısı
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
           return 1
       }
       
       func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
           return currencies.count
       }
       
       func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
           return currencies[row]
       }
       
    // Kullanıcının seçtiği para birimini text alanına yazma
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if firstCurrencyField.isFirstResponder {
            firstCurrencyField.text = currencies[row]
            firstCurrency = currencies[row]
        } else if secondCurrencyField.isFirstResponder {
            secondCurrencyField.text = currencies[row]
            secondCurrency = currencies[row]
        }
    }
}
