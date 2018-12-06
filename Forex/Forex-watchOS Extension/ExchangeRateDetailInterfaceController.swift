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
    
    // MARK: - Properties

    @IBOutlet weak var exchangeRateLabel: WKInterfaceLabel!
    @IBOutlet weak var historyGraphImage: WKInterfaceImage!
    
    private let fetcher = ExchangeRateFetcher()
    private var exchangeRate: ExchangeRate? {
        didSet {
            DispatchQueue.main.async {
                self.updateViews()
            }
        }
    }
    
    private let currencyFormatter: NumberFormatter = {
        let result = NumberFormatter()
        result.numberStyle = .decimal
        result.maximumFractionDigits = 2
        result.minimumIntegerDigits = 1
        return result
    }()
    
    // MARK: - Lifecycle
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        let symbol = context as! String
        setTitle(symbol)
        
        fetcher.fetchCurrentExchangeRate(for: symbol) { (rate, error) in
            if let error = error {
                NSLog("Error fetching exchange rate for \(symbol): \(error)")
                return
            }
            
            self.exchangeRate = rate
        }
        
        let calendar = Calendar.current
        let now = calendar.startOfDay(for: Date())
        var components = DateComponents()
        components.calendar = calendar
        components.year = -1
        let aYearAgo = calendar.date(byAdding: components, to: now)!
        
        fetcher.fetchExchangeRates(startDate: aYearAgo, symbols: [symbol]) { (rates, error) in
            if let error = error {
                NSLog("Error fetching exchange rates for \(symbol): \(error)")
                return
            }
            
            guard let rates = rates else { return }
            
            let graphRenderer = RateHistoryRenderer(exchangeRates: rates)
            let grapgImage = graphRenderer?.image(with: CGSize(width: 300, height: 300))
            DispatchQueue.main.async {
                self.historyGraphImage.setImage(grapgImage)
            }
            
        }
    }
    
    // MARK: - Update Interface
    
    private func updateViews() {
        guard let rate = exchangeRate else { return }
        
        let rateString = currencyFormatter.string(from: rate.rate as NSNumber) ?? "N/A"
        let rateLabelText = "\(rateString) \(rate.symbol) = 1 \(rate.base)"
        exchangeRateLabel.setText(rateLabelText)
    }
}
