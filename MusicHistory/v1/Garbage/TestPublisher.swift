//
//  TestPublisher.swift
//  1001 Albums
//
//  Created by Vitaly Gromov on 8/2/22.
//

import SwiftUI
import Combine
// MARK: ViewModel
class TestPublisherViewModel: ObservableObject {
    init() {
        numberPublisher
            .receive(on: RunLoop.main)
//            .assign(to: \.customColor, on: self)
            .sink(receiveValue: { [weak self] myColor in
                guard let self = self else { return }
                self.customColor = myColor
            })
            .store(in: &cancel)
        printNumber()
//        numberPublisherFunc()
        textPrinterFunc()
        textPrinter.sink { value in
            print("#new printer computed property", value)
        }
        .store(in: &cancel)
        
    }
    
    @Published var number = ""
    @Published var customColor = Color.blue
    
    var cancel = Set<AnyCancellable>()
    var flag = true.description
    
    func printNumber() {
        $number
            .receive(on: RunLoop.main)
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink { i in
                print(i)
                if let number = Int(self.number), number > 100 {
                    // turn off subscriber
                    for ii in self.cancel {
                        self.cancel.first?.cancel()
                        print("subscriber is dead", ii.hashValue)
                    }
                    
                }
            }
            .store(in: &cancel)
    }
    
    func numberPublisherFunc() {
        $number
            .receive(on: RunLoop.main)
            .debounce(for: 1.5, scheduler: RunLoop.main)
            .dropFirst()
            .map {
                guard let number = Int($0) else {
                    return Color.yellow
                }
                if number > 5 {
                    return Color.green
                } else {
                    return Color.red
                }
                 }
            .sink(receiveValue: {myColor in
                self.customColor = myColor
            })
            .store(in: &cancel)
    }
    
    var numberPublisher: AnyPublisher<Color, Never> {
        $number
            .receive(on: RunLoop.main)
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .dropFirst()
            .map {
                guard let number = Int($0) else {
                    return Color.yellow
                }
                if number > 5 {
                    return Color.green
                } else {
                    return Color.red
                }
                 }
            .eraseToAnyPublisher()
    }
    // only publisher
    var textPrinter: AnyPublisher<String, Never> {
        $number
            .map{$0}
            .eraseToAnyPublisher()
    }
    func textPrinterFunc() {
        $number
            .map {
                guard let value = Int($0) else {
                    print("guard fail")
                    return "guard fail"
                }
                return value
            }
        //without use value
//            .sink{_ in print("#newprinter2")}
        // with use value
            .sink{print("#newprinter2", $0)}
            .store(in: &cancel)
    }
    
   
    
}
// MARK: View
struct TestPublisher: View {
    @StateObject private var vm = TestPublisherViewModel()
    var body: some View {
            Form {
                TextField("enter number", text: $vm.number)
                    .keyboardType(.numberPad)
                Button {
                } label: {
                    Text("color")
                }
                .foregroundColor(vm.customColor)
            }
    }
}

struct TestPublisher_Previews: PreviewProvider {
    static var previews: some View {
        TestPublisher()
    }
}
