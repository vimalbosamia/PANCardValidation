//
//  PanViewModel.swift
//  Pan
//
//  Created by Vimal Bosamiya on 07/03/24.
//

import Foundation
import RxSwift
import RxCocoa

class PanViewModel {
    let panNumber = BehaviorRelay<String?>(value: nil)
    let day = BehaviorRelay<String?>(value: nil)
    let month = BehaviorRelay<String?>(value: nil)
    let year = BehaviorRelay<String?>(value: nil)
    
    let isPANValid = BehaviorRelay<Bool>(value: false)
    let isDateValid = BehaviorRelay<Bool>(value: false)
    
    private let disposeBag = DisposeBag()
    
    init() {
        panNumber.map { pan in
            guard let pan = pan else { return false }
            return Validation.validatePAN(pan)
        }
        .bind(to: isPANValid)
        .disposed(by: disposeBag)
        Observable.combineLatest(day.asObservable(), month.asObservable(), year.asObservable())
            .map { day, month, year in
                guard let day = day, let month = month, let year = year else { return false }
                return Validation.validateDate(day: day, month: month, year: year)
            }
            .bind(to: isDateValid)
            .disposed(by: disposeBag)
    }
}
