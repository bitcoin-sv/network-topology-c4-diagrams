workspace {

  !identifiers hierarchical

  model {

    nodeNetwork = softwareSystem "Node Network (Teranode)" "Timestamps  \
    transactions into Blocks, maintains UTXO set, and enforces the rules  \
    of the Blockchain" {

        propagationService = container "Propagation Service" {
          description "Responsible for the propagation of transactions and \
          blocks across the network"
          technology "Golang"
        }

        propTxValBroker = container "Propagation-TxValidation Message Broker" {
          description "Responsible for brokering transactions from Propagation \
          Services to TX Validation Services"
          technology "Kafka"
          tags "MessageBroker"
          nodeNetwork.propagationService -> this "Send extended TXs to"
        }

        txValidationService = container "TX Validation Service" {
          description "Responsible for validating transactions"
          technology "Golang"
          nodeNetwork.propTxValBroker -> this "Broker extended transactions to"
        }

        txValBlockAssBroker = container "TxValidation-BlockAssembly Message Broker" {
          description "Responsible for brokering TXIDs from the TX Validation \
          Services to the Block Assembly Services"
          tags "MessageBroker"
          technology "Golang"
          nodeNetwork.txValidationService -> this "Send TXIDs to"
        }

        blockassemblyService = container "BlockAssembly Service" "Responsible for assembling new blocks with transactions" "Golang" {
          nodeNetwork.txValBlockAssBroker -> this "Broker TXIDs to"
        }

        blockchainService = container "Blockchain Service" "Handles operations related to the blockchain" "Golang" {
          nodeNetwork.blockAssemblyService -> this "Notify Block found | <-Get best Block Header"
        }

        blockvalidationService = container "BlockValidation Service" {
          description "Validates new Blocks"
          technology "Golang"
          this -> nodeNetwork.blockchainService "Valid Block found"
        }

        publicEndpointsService = container "Public Endpoints Service" {
          description "Provides API Endppoints"
          technology "Golang"
          this -> nodeNetwork.blockValidationService "Block found| <-Notify Block found"
        }

        //Teranode Data Stores
        txmetaStore = container "TxMeta Store" "Manages transaction metadata" "TX Metadata" {
          tags "Database"
          this -> nodeNetwork.txmetaStore "Store TX metadata"
          nodeNetwork.blockAssemblyService -> this "Update TX Meta Store"
          nodeNetwork.blockValidationService -> this "Update TX Meta Meta Store"
        }

        txStore = container "Tx Store" "Manages transaction metadata" "TX Metadata" {
          tags "Database"
        }

        utxoStore = container "UTXO Store" "Manages UTXOs" "UTXOs" {
          tags "Database"
          this -> nodeNetwork.utxoStore "Validate against UTXO set | Update UTXO set"
          nodeNetwork.blockAssemblyService -> this "Update UTXO set"
        }

        blockHeaderStore = container "Block Header Store" {
          description "Manages Block Headers"
          technology "Block Headers"
          tags "Database"
          nodeNetwork.blockchainService -> this "Update Block Header Store | <-Get best Block Header"
        }

        merkleSubtreeStore = container "Merkle Subtree Store" "Manages Merkle Subtrees" "Merkle Subtrees" {
          tags "Database"
          nodeNetwork.blockAssemblyService -> this "Store Merkle Subtrees | <-Get new Merkle Subtrees"
          nodeNetwork.blockValidationService -> this "Get new Merkle Subtrees"
          nodeNetwork.publicEndpointsService -> this "Subtree received"
        }
    }

//  Overlay Node
    overlayNetwork = softwareSystem "Overlay Network (Overlay Node)" {

        propagationService = container "Propagation Service" {
          description "Responsible for the propagation of transactions and blocks across the network"
          technology "Golang"
        }

        propTxValBroker = container "Propagation-TxValidation Message Broker" {
          description "Responsible for brokering transactions from Propagation \
          Services to TX Validation Services"
          technology "Kafka"
          tags "MessageBroker"
          overlayNetwork.propagationService -> this "Send extended transactions to"
        }

        txValidationService = container "TX Validation Service" {
          description "Responsible for validating transactions"
          technology "Golang"
          overlayNetwork.propTxValBroker -> this "Broker extended transactions to"
        }

        blockchainService = container "Blockchain Service" {
          description "Handles operations related to the blockchain"
          technology "Golang"
        }

        publicEndpointsService = container "Public Endpoints Service" {
          description "Provides API Endppoints"
          technology "Golang"
        }

        //Teranode Data Stores
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
          overlayNetwork.blockchainService -> this "Update Block Header Store | <-Get best Block Header"
        }

        merkleSubtreeStore = container "Merkle Subtree Store" "Manages Merkle Subtrees" "Merkle Subtrees" {
          tags "Database"
          overlayNetwork.publicEndpointsService -> this "Subtree received"
        }

    }

//  Teranode Ancilliary Services
    legacyP2PNetworkBridge = softwareSystem "Legacy P2P Network Bridge" {
      description "Handles peer-to-peer network communication"
    }

    txLookupService = softwareSystem "TX/TXO Lookup Service" {
      description "Allows legacy lookup of transactions and transaction outputs"
      this -> overlayNetwork.txStore "<-Get extended TX"
      this -> nodeNetwork.txStore "<-Get extended TX"
      legacyP2PNetworkBridge -> this "Extend TX if needed"
    }

    peerService = softwareSystem "Peer Service" {
      description "Allows IPv4 Peer connections"
      this -> overlayNetwork.txStore "<-Get extended TX"
      this -> overlayNetwork.merkleSubtreeStore "Update Merkle Subtree Store"
      overlayNetwork.blockchainService -> this "Notify Block found"
      this -> nodeNetwork.txStore "<-Get extended TX"
      this -> nodeNetwork.merkleSubtreeStore "Update Merkle Subtree Store"
      nodeNetwork.blockchainService -> this "Notify Block found"
    }

    coinbaseOverlayNode = softwareSystem "Coinbase Overlay Node" {
      description "Handles operations related to the coinbase transaction of a block"
    }

    txSubmissionService = softwareSystem "TX Submission Service (ARC)" {
      description "Submits transactions to the Node network via IPv6 multicast"
    }

    banlistService = softwareSystem "Banlist Service" {
      description "Maintains a dynamic banlist related to rejected TXs, Blocks, and Subtrees"
      this -> nodeNetwork.utxoStore "Updates UTXO Store"
      this -> overlayNetwork.utxoStore "Updates UTXO Store"
    }

    utxoLookupService = softwareSystem "UTXO Lookup Service" {
      description "Provides an API to lookup the statuses of UTXOs"
      this -> nodeNetwork.utxoStore "<-Get UTXO status"
      this -> nodeNetwork.txmetaStore "<-Get TX metadata"
      this -> overlayNetwork.utxoStore "<-Get UTXO status"
      this -> overlayNetwork.txmetaStore "<-Get TX metadata"
    }

    hashers = softwareSystem "Hashing pool to find Proof-of-Work" {
      nodeNetwork.blockAssemblyService -> this "Send Block Candidate to | Receive Proof-of-Work from"
    }


//  Multicast Network (mNet or M-Net)
    mNet = softwareSystem "Multicast Network" {
      description "Handles incoming transactions and subtrees for the Node network"
      tags "MNet"
    }

    mNetTXSubmission = softwareSystem "TX Submission Multicast Group" {
      description "Multicasts received extended transactions to the Node Network"
      tags "MNet"
      this -> nodeNetwork.txStore "Multicasts extended TXs to"
      this -> nodeNetwork.propagationService "Multicasts extended TXs to"
      this -> banlistService "Multicasts transactions to"
      this -> txSubmissionService "Receives TXs from"
      this -> overlayNetwork.txStore "Multicasts extended TXs to"
      this -> overlayNetwork.propagationService "Multicasts extended TXs to"
      legacyP2PNetworkBridge -> this "Receive extended TXs from | Send TXs to"
    }

    mNetBlockAnnouncement = softwareSystem "Block announcement Multicast Group" {
      description "Multicasts found Blocks to the Node Network"
      tags "MNet"
      this -> nodeNetwork.publicEndpointsService "Block found | Notify Block found"
      this -> overlayNetwork.publicEndpointsService "Block found | Notify Block found"
    }

    mNetSubtreeAnnouncement = softwareSystem "Merkle Subtree announcement Multicast Group" {
      description "Multicasts constructed Subtrees to the Node Network"
      tags "MNet"
      this -> nodeNetwork.publicEndpointsService "New Merkle Subtree"
      this -> overlayNetwork.publicEndpointsService "New Merkle Subtree"
    }

    mNetRequest = softwareSystem "TX|Subtree|Block request Multicast Group" {
      description "Requests missing TX, Subtree, or Block to be remulticasted"
      tags "MNet"
      this -> nodeNetwork.publicEndpointsService "New TX|Merkle Subtree|Block request"
      this -> overlayNetwork.publicEndpointsService "New TX|Merkle Subtree|Block request"
    }

    wallet = person "A Wallet" "A User's wallet" {
      tags "System"
    }


//  SystemLandscape
    wallet -> overlayNetwork "Interacts with and submits transactions to"
    overlayNetwork -> mNet "Submits extended TXs to"
    mNet -> nodeNetwork "Multicasts extended TXs to"

  }

  views {

    systemlandscape "SystemLandscape" {
      include wallet overlayNetwork mNet nodeNetwork
      autolayout lr
    }

    container "nodeNetwork" {
      include *
      //autolayout lr
    }

    container "overlayNetwork" {
      include *
      //autolayout lr
    }

    styles {
      softwareSystem {
        border {
          thickness 4
        }
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
      element "Database" {
        background #0ba789
        color #ffffff
        shape cylinder
      }

      element "MNet" {
        background #929292
        color #ffffff
        shape hexagon
      }

      element "MessageBroker" {
        background #929292
        color #ffffff
        shape pipe
      }
    }
  }
}

