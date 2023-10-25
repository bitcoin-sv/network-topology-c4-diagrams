workspace {

  model {
    wallet = person "A Wallet" "A User's wallet" {
      tags "System"
    }

    nodeNetwork = softwareSystem "Node Network (Teranode)" "Timestamps transactions into Blocks, maintains UTXO set, and enforces the rules of the Blockchain" {

      propagationService = container "Propagation Service" "Responsible for the propagation of transactions and blocks across the network" "Golang"
      propTxValBroker = container "Propagation-TxValidation Message Broker" "Responsible for brokering transactions from Propagation Services to TX Validation Services" "Kafka"
      txValidationService = container "TX Validation Service" "Responsible for validating transactions" "Golang"
      txValBlockAssBroker = container "TxValidation-BlockAssembly Message Broker" "Responsible for brokering TXIDs from the TX Validation Services to the Block Assembly Services"
      blockassemblyService = container "BlockAssembly Service" "Responsible for assembling new blocks with transactions" "Golang"
      blockchainService = container "Blockchain Service" "Handles operations related to the blockchain" "Golang"
      blockvalidationService = container "BlockValidation Service" "Validates new Blocks" "Golang"
      publicEndpointsService = container "Public Endpoints Service" "Provides API Endppoints" "Golang"

      txmetaStore = container "TxMeta Store" "Manages transaction metadata" "TX Metadata" {
        tags "Database"
      }
      txStore = container "Tx Store" "Manages transaction metadata" "TX Metadata" {
        tags "Database"
      }
      utxoStore = container "UTXO Store" "Manages UTXOs" "UTXOs" {
        tags "Database"
      }
      blockHeaderStore = container "Block Header Store" "Manages Block Headers" "Block Headers" {
        tags "Database"
      }
      merkleSubtreeStore = container "Merkle Subtree Store" "Manages Merkle Subtrees" "Merkle Subtrees" {
        tags "Database"
      }
      tags "system"
    }

    legacyP2pService = softwareSystem "Legacy P2P Service" "Handles peer-to-peer network communication" "Golang"
    txLookupService = softwareSystem "TX/TXO Lookup Service" "Allows legacy lookup of transactions and transaction outputs" "Golang"
    peerService = softwareSystem "Peer Service" "Allows IPv4 Peer connections" "Golang"
    coinbaseOverlayNode = softwareSystem "Coinbase Overlay Node" "Handles operations related to the coinbase transaction of a block" "Golang"
    txSubmissionService = softwareSystem "TX Submission Service (ARC)" "Submits transactions to the Node network via IPv6 multicast" "Golang"
    banlistService = softwareSystem "Banlist Service" "Maintains a dynamic banlist related to rejected TXs, Blocks, and Subtrees" "Golang"
    utxoLookupService = softwareSystem "UTXO Lookup Service" "Provides an API to lookup the statuses of UTXOs" "Golang"
    hashers = softwareSystem "Hashing pool to find Proof-of-Work"

    overlayNetwork = softwareSystem "An application and/or transaction type(s) specific overlay network"

    mNet = softwareSystem "Multicast Network" "Handles incoming transactions and subtrees for the Node network" {
      tags "MNet"
    }



    wallet -> overlayNetwork "Interacts with and submits transactions to"
    overlayNetwork -> mNet "Submits transactions to"
    txSubmissionService -> mNet "Submits transactions to"
    mNet -> nodeNetwork "Multicasts transactions to Node Network"
    mNet -> propagationService "Multicasts extended transactions to"
    propagationService -> propTxValBroker "Send extended transactions to"
    propTxValBroker -> txValidationService "Broker extended transactions to"
    txValidationService -> utxoStore "Update UTXO set"
    txValidationService -> txmetaStore "Store TX metadata"
    txValidationService -> txValBlockAssBroker "Send TXIDs to"
    txValBlockAssBroker -> blockAssemblyService "Broker TXIDs to"
    blockAssemblyService -> hashers "Send Block Candidate to | Receive Proof-of-Work from"
    blockAssemblyService -> blockchainService "Manage Chain Tips"
    blockAssemblyService -> merkleSubtreeStore "Store Merkle Subtrees"
    blockAssemblyService -> utxoStore "Update UTXO set"
    blockAssemblyService -> txmetaStore "Update TX metaStore"
    propagationService -> legacyP2pService "Propagates transactions and blocks"
    blockValidationService -> blockchainService "Update chain tips"
    merkleSubtreeStore -> blockValidationService "get new Merkle subtrees"
    legacyP2pService -> propagationService "Receives propagated transactions and blocks"
  }

  views {

    systemlandscape "SystemLandscape" {
      include wallet overlayNetwork mNet nodeNetwork
      autolayout lr
    }

    container "nodeNetwork" {
      include *
      autolayout lr
    }

    styles {
      element "Software System" {
        background #1168bd
        color #ffffff
        shape roundedBox
      }
      element "Person" {
        shape person
        background #08427b
        color #ffffff
      }
      element "Container" {
        shape roundedBox
        background #438dd5
        color #ffffff
      }
      element "database" {
        background #0ba789
        color #ffffff
        shape cylinder
      }

      element "MNet" {
        background #1168bd
        color #ffffff
        shape hexagon
      }
    }
  }
}

