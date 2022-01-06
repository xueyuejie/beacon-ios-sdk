//
//  PermissionTezosResponse.swift
//
//
//  Created by Julia Samol on 13.11.20.
//  Copyright © 2020 Papers AG. All rights reserved.
//

import Foundation
import BeaconCore
    
/// Content of the `BeaconResponse.permission` message.
public struct PermissionTezosResponse: PermissionBeaconResponseProtocol, Equatable, Codable {
    
    /// The value that identifies the request to which the message is responding.
    public let id: String
    
    /// The version of the message.
    public let version: String
    
    /// The origination data of the request.
    public let requestOrigin: Beacon.Origin
    
    /// The unique name of the blockchain that specifies the request.
    public let blockchainIdentifier: String
    
    ///  The account identifier of the account that is granting the permissions.
    public let accountID: String
    
    /// The public key of the account that is granting the permissions.
    public let publicKey: String
    
    /// The network to which the permissions apply.
    public let network: Tezos.Network
    
    /// The list of granted permissions.
    public let scopes: [Tezos.Permission.Scope]
    
    public init(
        from request: Tezos.Request.Permission,
        publicKey: String,
        network: Tezos.Network? = nil,
        scopes: [Tezos.Permission.Scope]? = nil
    ) throws {
        let network = network ?? request.network
        let scopes = scopes ?? request.scopes
        
        let address = try dependencyRegistry().extend().tezosWallet.address(fromPublicKey: publicKey)
        let accountID = try dependencyRegistry().identifierCreator.accountIdentifier(forAddress: address, on: network)
        
        self.init(
            id: request.id,
            version: request.version,
            requestOrigin: request.origin,
            blockchainIdentifier: request.blockchainIdentifier,
            accountID: accountID,
            publicKey: publicKey,
            network: network,
            scopes: scopes
        )
    }
    
    public init(
        id: String,
        version: String,
        requestOrigin: Beacon.Origin,
        blockchainIdentifier: String,
        accountID: String,
        publicKey: String,
        network: Tezos.Network,
        scopes: [Tezos.Permission.Scope]
    ) {
        self.id = id
        self.version = version
        self.requestOrigin = requestOrigin
        self.blockchainIdentifier = blockchainIdentifier
        self.accountID = accountID
        self.publicKey = publicKey
        self.network = network
        self.scopes = scopes
    }
}
