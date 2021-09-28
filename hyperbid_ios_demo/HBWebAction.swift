//
//  HBWebAction.swift
//  HyperBidSDKDemo
//
//  Created by Jean on 2020/9/30.
//  Copyright © 2020 HyperBid. All rights reserved.
//

import Foundation

@objc protocol HBWebActionProtocol: NSObjectProtocol  {
    func goBack()
    func refresh()
    func goForward()
    func close()
}

enum HBWebAction {
    case goBack
    case goForward
    case refresh
    case close
    
    var action: Selector {
        switch self {
        case .goBack:
            return #selector(HBWebActionProtocol.goBack)
        case .goForward:
            return #selector(HBWebActionProtocol.goForward)
        case .refresh:
            return #selector(HBWebActionProtocol.refresh)
        case .close:
            return #selector(HBWebActionProtocol.close)
        
        }
    }
}
