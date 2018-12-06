//
//  ExchangeRateDetailInterfaceController.swift
//  Forex-watchOS Extension
//
//  Created by Ilgar Ilyasov on 12/5/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import WatchKit
import Foundation
import ForexCore

class ExchangeRateDetailInterfaceController: WKInterfaceController {

    @IBOutlet weak var exchangeRateLabel: WKInterfaceLabel!
    @IBOutlet weak var historyGraphImage: WKInterfaceImage!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        let symbol = context as! String
        setTitle(symbol)
    }
}
