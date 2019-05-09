import RxSwift

func print<T: CustomStringConvertible>(label: String, event: Event<T>) {
    print(label, event.element ?? 0) 
}

let bag = DisposeBag()

//: behavior subject

// t = 0
let besubject: BehaviorSubject<String> = BehaviorSubject(value: "🌹")

// t = 1
besubject.subscribe { (event) in
    print("1> BehaviorSubject first Subscribe", event)
}
    .disposed(by: bag)

// t = 2
besubject.onNext("A")

// t = 3
besubject.subscribe { (event) in
    print("2> BehaviorSubject second Subscribe", event)
}
    .disposed(by: bag)

// t = 4
besubject.onNext("B")

// t = 5
besubject.onCompleted()
print("---------------------------------------")


//: combineLatest

let firstSubject: PublishSubject<String> = PublishSubject<String>()
let secondSubject: PublishSubject<String> = PublishSubject<String>()

Observable.combineLatest(firstSubject, secondSubject) { $0 + $1 }
    .subscribe(onNext: { print($0) })
    .disposed(by: bag)

// t = 1
firstSubject.onNext("1")

// t = 1.5
secondSubject.onNext("A")

// t = 2
firstSubject.onNext("2")

// t = 2.5
secondSubject.onNext("B")

// t = 3.5
secondSubject.onNext("C")

// t = 4
firstSubject.onNext("3")

// t = 5
firstSubject.onCompleted()
secondSubject.onCompleted()

print("---------------------------------------")

//: withLatestFrom

let first: PublishSubject<String> = PublishSubject<String>()
let second: PublishSubject<String> = PublishSubject<String>()

first.withLatestFrom(second) { $0 + $1 }
    .subscribe(onNext: { print($0) })
    .disposed(by: bag)
// t = 1
first.onNext("1")

// t = 1.5
second.onNext("A")

// t = 2
first.onNext("2")

// t = 2.5
second.onNext("B")

// t = 3.5
second.onNext("C")

// t = 4
first.onNext("3")

// t = 5
first.onCompleted()
second.onCompleted()

print("---------------------------------------")

//: zip

let s1: PublishSubject<String> = PublishSubject<String>()
let s2: PublishSubject<String> = PublishSubject<String>()

Observable.zip(s1, s2) { $0 + $1 }
    .subscribe(onNext: { print($0) })
    .disposed(by: bag)

// t = 1
s1.onNext("1")

// t = 1.5
s2.onNext("A")

// t = 2
s1.onNext("2")

// t = 2.5
s2.onNext("B")

// t = 3.5
s2.onNext("C")

// t = 4
s1.onNext("3")

// t = 5
s1.onCompleted()
s2.onCompleted()

print("---------------------------------------")

//: CO

let intervalSequence = Observable<Int>
    .interval(1, scheduler: MainScheduler.instance)
    .take(3)

intervalSequence
    .subscribe { value in
    print("s1 Next \(value)")
}
    .disposed(by: bag)

intervalSequence
    .subscribe { value in
        print("s2 Next \(value)")
    }
    .disposed(by: bag)


print("---------------------------------------")


let blueScheduler = ConcurrentDispatchQueueScheduler(qos: .background)

let greenScheduler = SerialDispatchQueueScheduler(internalSerialQueueName: "com.blue.serialQueue")

let redScheduler = MainScheduler.instance

Observable
    .just(42, scheduler: blueScheduler)
    .observeOn(greenScheduler)
    .filter { $0 > 0 }
    .observeOn(greenScheduler)
    .subscribeOn(redScheduler)
    .map { "\($0)" }
    .observeOn(greenScheduler)
    .subscribe { print($0) }
    .disposed(by: bag)

