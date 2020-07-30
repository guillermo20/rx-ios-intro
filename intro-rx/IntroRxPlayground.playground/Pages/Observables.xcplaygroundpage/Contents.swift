import Foundation
import RxSwift
import RxCocoa

// MARK: Observable
let intArray = Observable.from([1, 2, 3, 4, 5])
let secondArray = Observable.from([6, 7])
let disposeBag = DisposeBag()

let arrayObservable = intArray
//    .concat(Observable.error(RxError.unknown))
    .concat(secondArray)

arrayObservable
    .subscribe(onNext: { integer in
        print(integer)
    }, onError: {
        print($0.localizedDescription)
    }, onCompleted: {
        print("this array of events has completed")
    }).disposed(by: disposeBag)

// MARK: Single
struct Person {
    let name: String
    let age: Int
}

let onError = false
var singlePerson: Single<Person> {
    return !onError ?
        .just(Person(name: "guille", age: 33)) : // completes the stream with value
        .error(RxError.noElements) // on error and completes the stream
}

singlePerson
    .subscribe(onSuccess: { person in
        print(person)
    }, onError: { error in
        print(error.localizedDescription)
    }).disposed(by: disposeBag)

// MARK: Maybe
var maybeString: Maybe<String> {
    return Maybe<String>.create { maybe in
        maybe(.success("maybeString")) // completes the stream with value
        maybe(.completed) // completes the stream
        maybe(.error(RxError.unknown)) // on error and completes the stream
        return Disposables.create()
    }
}

maybeString
    .subscribe(onSuccess: { value in
        print(value)
    }, onError: { error in
        print(error.localizedDescription)
    }, onCompleted: {
        print("maybe trait has completed")
    }).disposed(by: disposeBag)

// MARK: Completable
var completableProcess: Completable {
    return Completable.create { completable in
        completable(.completed) // completes the stream
        completable(.error(RxError.unknown)) // on error and completes the stream
        return Disposables.create()
    }
}
completableProcess
    .subscribe(onCompleted: {
        print("process complete")
    }, onError: { error in
        print(error.localizedDescription)
    }).disposed(by: disposeBag)

// MARK: Drivers
let doubleSubject = BehaviorSubject<Double>(value: 5.0) //replays this data
//let doubleSubject = PublishSubject<Double>() // does not replays
var doubleDriver: Driver<Double> {
    return doubleSubject.asDriver(onErrorJustReturn: 0.0)
}

doubleDriver.
    .drive(onNext: { double in
        print("driver double: \(double)")
    }).disposed(by: disposeBag)
doubleSubject.onNext(20.0)
