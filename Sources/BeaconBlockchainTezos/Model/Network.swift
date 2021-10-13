//
//  Network.swift
//  
//
//  Created by Julia Samol on 30.09.21.
//

import Foundation
import BeaconCore

extension Tezos {
    
    /// A group of values defining a network in Tezos..
    public struct Network: NetworkProtocol, Codable, Equatable {
        /// A type of the network
        public let type: `Type`
        
        /// An optional name of the network.
        public let name: String?
        
        /// An optional URL for the network RPC interface.
        public let rpcURL: String?
        
        public init(type: `Type`, name: String? = nil, rpcURL: String? = nil) {
            self.type = type
            self.name = name
            self.rpcURL = rpcURL
        }
        
        enum CodingKeys: String, CodingKey {
            case type
            case name
            case rpcURL = "rpcUrl"
        }
        
        /// Types of supported networks.
        public enum `Type`: String, Codable, CustomStringConvertible {
            case mainnet
            
            @available(*, deprecated, message: "'Delphinet' is no longer a maintained Tezos test network and will be removed from Beacon in future versions.")
            case delphinet
            
            @available(*, deprecated, message: "'Edonet' is no longer a maintained Tezos test network and will be removed from Beacon in future versions.")
            case edonet
            
            case florencenet
            case granadanet
            case custom
            
            public var description: String {
                self.rawValue
            }
        }
    }
}