import Foundation
import RxSwift

let disposeBag = DisposeBag()
let backgroundScheduler = ConcurrentDispatchQueueScheduler(qos: .background)
let mainScheduler = MainScheduler.instance

let intObservable = Observable.from([1, 2])

intObservable
    .do(onNext: { value in
        print("value = \(value) - isMainThread: \(Thread.current.isMainThread)")
    })
    .subscribeOn(backgroundScheduler)
    .observeOn(mainScheduler)
    .subscribe(onNext: { value in
        print("value = \(value) - isMainThread: \(Thread.current.isMainThread)")
    }).disposed(by: disposeBag)
