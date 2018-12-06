//
//  CurrenciesTableInterfaceController.swift
//  Forex-watchOS Extension
//
//  Created by Ilgar Ilyasov on 12/5/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import WatchKit
import Foundation


class CurrenciesTableInterfaceController: WKInterfaceController {
    
    // MARK: - Properties
    
    @IBOutlet weak var currencyTable: WKInterfaceTable!
    private let symbols = ["AZE", "CAD","BRL", "HUF", "DKK", "JPY", "ILS", "TRY",
                           "RON", "GBP", "PHP", "HRK", "NOK", "USD", "MXN", "AUD",
                           "IDR", "KRW", "HKD", "ZAR", "ISK", "CZK", "THB", "MYR",
                           "NZD", "PLN", "SEK", "RUB", "CNY", "SGD", "CHF", "INR"].sorted()

    // MARK: - Lifecycle
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        currencyTable.setNumberOfRows(symbols.count, withRowType: "CurrencyRowController")
        for (index, symbol) in symbols.enumerated() {
            let rowController = currencyTable.rowController(at: index) as! CurrencyRowController
            rowController.symbol = symbol
        }
    }
    
    // prepareForSegue equivalent
    // Just return the object you want to pass to other InterFace Controller
    override func contextForSegue(withIdentifier segueIdentifier: String, in table: WKInterfaceTable, rowIndex: Int) -> Any? {
        
        if segueIdentifier == "CurrencyRowControllerSegue" {
            return symbols[rowIndex]
        }
        return nil
    }

}
