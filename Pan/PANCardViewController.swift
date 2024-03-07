//
//  PANCardViewController.swift
//  Pan
//
//  Created by Vimal Bosamiya on 07/03/24.
//

import UIKit
import RxSwift
import RxCocoa

class PANCardViewController: UIViewController {
    @IBOutlet weak var panTextField: UITextField!
    @IBOutlet weak var dayTextField: UITextField!
    @IBOutlet weak var monthTextField: UITextField!
    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    var viewModel = PanViewModel()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindTextFields()
        configureTextFields()
        setupInputRestrictions()
    }
    
    private func bindTextFields() {
        panTextField.rx.text.orEmpty
            .map { $0.uppercased() }
            .subscribe(onNext: { [weak self] uppercasedText in
                self?.panTextField.text = uppercasedText
                self?.viewModel.panNumber.accept(uppercasedText)
            })
            .disposed(by: disposeBag)

        dayTextField.rx.text.orEmpty.bind(to: viewModel.day).disposed(by: disposeBag)
        monthTextField.rx.text.orEmpty.bind(to: viewModel.month).disposed(by: disposeBag)
        yearTextField.rx.text.orEmpty.bind(to: viewModel.year).disposed(by: disposeBag)
        
        viewModel.isPANValid.subscribe(onNext: { isValid in
            UIHelper.updateTextFieldBorder(textField: self.panTextField, isValid: isValid)
        }).disposed(by: disposeBag)
        
        Observable.combineLatest(viewModel.isPANValid, viewModel.isDateValid)
                .map { $0 && $1 }
                .subscribe(onNext: { [weak self] isValid in
                    self?.nextButton.isEnabled = isValid
                    self?.nextButton.backgroundColor = isValid ? .systemPurple : .systemGray
               })
                .disposed(by: disposeBag)
        
        viewModel.isDateValid.subscribe(onNext: { isValid in
            UIHelper.updateTextFieldBorder(textField: self.dayTextField, isValid: isValid)
        }).disposed(by: disposeBag)
        viewModel.isDateValid.subscribe(onNext: { isValid in
            UIHelper.updateTextFieldBorder(textField: self.monthTextField, isValid: isValid)
        }).disposed(by: disposeBag)
        viewModel.isDateValid.subscribe(onNext: { isValid in
            UIHelper.updateTextFieldBorder(textField: self.yearTextField, isValid: isValid)
        }).disposed(by: disposeBag)
    }
    
    private func configureTextFields() {
        dayTextField.keyboardType = .numberPad
        monthTextField.keyboardType = .numberPad
        yearTextField.keyboardType = .numberPad
        panTextField.keyboardType = .namePhonePad
        
    }
    
    private func setupInputRestrictions() {
        let numericOnly = { (input: String) -> String in
            return input.filter { "0123456789".contains($0) }
        }
        
        let dayAndMonthLimit = 2
        let yearLimit = 4
        
        panTextField.rx.text.orEmpty
            .map { $0.uppercased().prefix(10) } // Assuming you also want uppercase for PAN
            .subscribe(onNext: { [weak self] in self?.panTextField.text = String($0) })
            .disposed(by: disposeBag)
        
        dayTextField.rx.text.orEmpty
            .map(numericOnly)
            .map { $0.prefix(dayAndMonthLimit) }
            .subscribe(onNext: { [weak self] newText in
                self?.dayTextField.text = String(newText)
                if newText.count == dayAndMonthLimit {
                    self?.monthTextField.becomeFirstResponder()
                }
            })
            .disposed(by: disposeBag)
        
        monthTextField.rx.text.orEmpty
            .map(numericOnly)
            .map { $0.prefix(dayAndMonthLimit) }
            .subscribe(onNext: { [weak self] newText in
                self?.monthTextField.text = String(newText)
                if newText.count == dayAndMonthLimit {
                    self?.yearTextField.becomeFirstResponder()
                }
            })
            .disposed(by: disposeBag)
        
        yearTextField.rx.text.orEmpty
            .map(numericOnly)
            .map { $0.prefix(yearLimit) }
            .subscribe(onNext: { [weak self] newText in
                self?.yearTextField.text = String(newText)
            })
            .disposed(by: disposeBag)
    }

    
    @IBAction func btnActionNext(_ sender: Any) {
        
        viewModel.isPANValid.subscribe(onNext: { isValid in
            if isValid{
                AlertManager.showAlert(on: self, withTitle: "Details submitted successfully", message: "")
            }
        }).disposed(by: disposeBag)
    }
    
    @IBAction func btnActionDismiss(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
