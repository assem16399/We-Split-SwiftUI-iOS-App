//
//  ContentView.swift
//  WeSplit App SwiftUI
//
//  Created by Aasem Hany on 04/02/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 10
    @FocusState private var amountIsFocused: Bool
    
    let tips = [5, 10, 20, 0]
    
    var totalWithTip: Double {
        checkAmount + ((checkAmount * Double(tipPercentage)) / 100)
    }
    
    var paymentForEach: Double {
        let checkAfterTip = totalWithTip
        return checkAfterTip / Double(numberOfPeople)
    }
    
    
    var body: some View {
        NavigationStack {
            
            Form{
                
                Section {
                    TextField("Check Total Amount",value: $checkAmount,format: .currency(code: Locale.current.currency?.identifier ?? "USD" ))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of People",selection: $numberOfPeople){
                        ForEach(2..<100,id: \.self){
                            Text("\($0) people")
                        }
                    }.pickerStyle(.navigationLink)
                }
                
                Section("Choose Tip Percentage"){
                    Picker("Tip Percentage",selection: $tipPercentage){
                        ForEach(0..<101,id: \.self){
                            Text($0,format: .percent)
                        }
                    }
                }
                
                Section("Total With Tip"){
                    Text(totalWithTip, format: .currency(code: Locale.current.currency?.identifier ?? "USD" ))
                }
                
                Section("Each one pays"){
                    Text(paymentForEach, format: .currency(code: Locale.current.currency?.identifier ?? "USD" ))
                }
                
            }
            .toolbar{
                if amountIsFocused {
                    Button("Dismiss"){
                        amountIsFocused = false
                    }
                }
            }
            .navigationTitle("WeSplit")
            
        }
    }
}

#Preview {
    ContentView()
}
