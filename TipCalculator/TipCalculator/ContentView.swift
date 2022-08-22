//
//  ContentView.swift
//  TipCalculator
//
//  Created by Seban Sunny on 22/08/22.
//

import SwiftUI

struct ContentView: View {
    @State private var amount = 0.0
    @State private var noOfPersonToSplit = 0
    @State private var tipPercentage = 0
    
    @FocusState private var amountFieldIsFocused: Bool
    
    var totalAmountPerPerson: Double {
        let personCount = Double(noOfPersonToSplit + 1)
        let selectedTipPercentage = Double(tipPercentage)
        
        let tipValue = amount / 100 * selectedTipPercentage
        let finalAmount = amount + tipValue
        let amountPerPerson = finalAmount / personCount
        
        return amountPerPerson
    }
    let tipPercentages = [10, 15, 20, 25, 30, 0]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Enter the amount", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountFieldIsFocused)
                } header: {
                    Text("Amount")
                }
                
                Section {
                    Picker("Number of person: ", selection: $noOfPersonToSplit) {
                        ForEach(1..<50) {
                            Text("\($0) person")
                        }
                    }
                }
                
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("How much tip do you want to leave?")
                }
                
                Section {
                    Text(totalAmountPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                } header: {
                    Text("Final Amount Per Person")
                }
            }
            .navigationTitle("Tip Calculator")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountFieldIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

