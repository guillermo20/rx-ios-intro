import Foundation
import RxSwift
import RxCocoa

let disposeBag = DisposeBag()

// MARK: PublishSubject
let stringPublishSubject: PublishSubject<String> = PublishSubject<String>()
stringPublishSubject.onNext("Foo")

stringPublishSubject.asObservable()
    .subscribe(onNext: { value in
        print(value) //is associated to events
    }).disposed(by: disposeBag)

stringPublishSubject.onNext("Bar")

// MARK: BehaviorSubject
let stringBehaviorSubject: BehaviorSubject<String> = BehaviorSubject<String>(value: "Foo")

stringBehaviorSubject.asObservable()
    .subscribe(onNext: { value in
        print(value) //is associated with states
    }).disposed(by: disposeBag)

stringBehaviorSubject.onNext("Bbar")

// MARK: PublishRelay
let stringPublishRelay: PublishRelay<String> = PublishRelay<String>()
stringPublishRelay.accept("PublishRelay Foo")

stringPublishRelay.asObservable()
    .subscribe(onNext: { value in
        print(value)
    }).disposed(by: disposeBag)

stringPublishRelay.accept("PublishRelay Bar")

// MARK: BehaviorRelay
let stringBehaviorRelay: BehaviorRelay<String> = BehaviorRelay<String>(value: "Behavior Realy Foo")

stringBehaviorRelay.asObservable()
    .subscribe(onNext: { value in
        print(value)
    }).disposed(by: disposeBag)

stringPublishRelay.accept("Behavior Realy bar")

// MARK: Drivers
