import Foundation
import RxSwift

let primeNumbers = Observable.from([2, 3, 5, 7, 11])
let naturalNumbers = Observable.from([1, 2, 3, 4, 5])  //--1-----2-----3-----4
let strings = Observable.from(["Foo", "Bar", "Baz"])   //----Foo---Bar---Baz
var disposeBag = DisposeBag()

// MARK: Concat
Observable.concat(primeNumbers, naturalNumbers)
    .subscribe(onNext: { value in
        print("value =", value)
    }).disposed(by: disposeBag)

// MARK: Merge
Observable.merge(primeNumbers, naturalNumbers)
    .subscribe(onNext: { value in
        print("value =", value)
    }).disposed(by: disposeBag)

// MARK: zip
Observable.zip(naturalNumbers, strings)
    .subscribe(onNext: { integer, string in
        print("Int =", integer, "String =", string)
    }).disposed(by: disposeBag)


// MARK: combineLatest
Observable.combineLatest(naturalNumbers, strings)
    .subscribe(onNext: { integer, string in
        print("Int =", integer, "String =", string)
    }).disposed(by: disposeBag)

// MARK: map
naturalNumbers
    .map { $0 + 10 }
    .map { "value \($0)" }
    .subscribe(onNext: { print($0) })
    .disposed(by: disposeBag)

// MARK: flatMap
let combinedObservable = primeNumbers.take(2)
    .flatMap { prime in
        return naturalNumbers.take(3).map { natural in
            print("Prime value = \(prime) - Natural value = \(natural)")
        }
    }

combinedObservable
    .subscribe()
    .disposed(by: disposeBag)
