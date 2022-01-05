//
//  BlockchainV3TezosRequest.swift
//  
//
//  Created by Julia Samol on 05.01.22.
//

import Foundation
import BeaconCore

public enum BlockchainV3TezosRequest: BlockchainV3BeaconRequestContentDataProtocol, Equatable, Codable {
    case operation(OperationV3TezosRequest)
    case signPayload(SignPayloadV3TezosRequest)
    case broadcast(BroadcastV3TezosRequest)
    
    // MARK: BeaconMessage Compatibility
    
    public init(from blockchainRequest: BlockchainBeaconRequestProtocol) throws {
        guard let blockchainRequest = blockchainRequest as? BlockchainTezosRequest else {
            throw Beacon.Error.unknownBeaconMessage
        }
        
        switch blockchainRequest {
        case let .operation(content):
            self = .operation(OperationV3TezosRequest(from: content))
        case let .signPayload(content):
            self = .signPayload(SignPayloadV3TezosRequest(from: content))
        case let .broadcast(content):
            self = .broadcast(BroadcastV3TezosRequest(from: content))
        }
    }
    
    public func toBeaconMessage<T: Blockchain>(
        id: String,
        version: String,
        senderID: String,
        origin: Beacon.Origin,
        blockchainIdentifier: String,
        accountID: String,
        using storageManager: StorageManager,
        completion: @escaping (Result<BeaconMessage<T>, Error>) -> ()
    ) {
        switch self {
        case let .operation(content):
            content.toBeaconMessage(
                id: id,
                version: version,
                senderID: senderID,
                origin: origin,
                blockchainIdentifier: blockchainIdentifier,
                accountID: accountID,
                using: storageManager,
                completion: completion
            )
        case let .signPayload(content):
            content.toBeaconMessage(
                id: id,
                version: version,
                senderID: senderID,
                origin: origin,
                blockchainIdentifier: blockchainIdentifier,
                accountID: accountID,
                using: storageManager,
                completion: completion
            )
        case let .broadcast(content):
            content.toBeaconMessage(
                id: id,
                version: version,
                senderID: senderID,
                origin: origin,
                blockchainIdentifier: blockchainIdentifier,
                accountID: accountID,
                using: storageManager,
                completion: completion
            )
        }
    }
    
    // MARK: Equatable
    
    public func equals(_ other: BlockchainV3BeaconRequestContentDataProtocol) -> Bool {
        guard let other = other as? BlockchainV3TezosRequest else {
            return false
        }
        
        return self == other
    }
    
    // MARK: Codable
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)
        switch type {
        case OperationV3TezosRequest.type:
            self = .operation(try OperationV3TezosRequest(from: decoder))
        case SignPayloadV3TezosRequest.type:
            self = .signPayload(try SignPayloadV3TezosRequest(from: decoder))
        case BroadcastV3TezosRequest.type:
            self = .broadcast(try BroadcastV3TezosRequest(from: decoder))
        default:
            throw Beacon.Error.unknownMessageType(type, version: "3")
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        switch self {
        case let .operation(content):
            try content.encode(to: encoder)
        case let .signPayload(content):
            try content.encode(to: encoder)
        case let .broadcast(content):
            try content.encode(to: encoder)
        }
    }
    
    // MARK: Types
    
    enum CodingKeys: String, CodingKey {
        case type
    }
}
