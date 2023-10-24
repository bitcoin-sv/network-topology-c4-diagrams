workspace {

  model {
    wallet = person "A Wallet" "A User's wallet" {
      tags "System"
    }

    teranode = softwareSystem "Teranode" "Timestamps transactions into Blocks, maintains UTXO set, and enforces the rules of the Blockchain" {

      blockchainService = container "Blockchain Service" "Handles operations related to the blockchain" "Golang"
      coinbaseService = container "Coinbase Service" "Handles operations related to the coinbase transaction of a block" "Golang"
      txValidationService = container "TX Validation Service" "Responsible for validating transactions" "Golang"
      minerService = container "Miner Service" "Responsible for mining new blocks" "Golang"
      propagationService = container "Propagation Service" "Responsible for the propagation of transactions and blocks across the network" "Golang"
      blockassemblyService = container "BlockAssembly Service" "Responsible for assembling new blocks with transactions" "Golang"
      blockvalidationService = container "BlockValidation Service" "Validates new Blocks" "Golang"
      seederService = container "Seeder Service" "Responsible for seeding the network with transactions or blocks" "Golang"
      p2pService = container "P2P Service" "Handles peer-to-peer network communication" "Golang"
      publicEndpointsService = container "Public Endpoints Service" "Provides API Endppoints" "Golang"

      sqlStore = container "SQL Store" "Stores transaction metadata and block data" "SQL" {
        tags "Database"
      }
      memoryStore = container "In-Memory Store" "Stores UTXOs" "In-Memory" {
        tags "Database"
      }

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

    overlayNode = softwareSystem "Overlay Node" "Handles a subsection of transactions and UTXOs for a specific application" {

    }

    mNet = softwareSystem "Multicast Network" "Handles incoming transactions and subtrees for the Node network" {
      tags "MNet"
    }


    wallet -> overlayNode "Interacts with and submits transactions to"
    overlayNode -> mNet "Submits transactions to"
    mNet -> teranode "Multicasts transactions to"
    propagationService -> txStore "Store all transactions until outputs have been spent"
    propagationService -> txValidationService "Validate transactions"
    txValidationService -> utxoStore "Update UTXO set"
    txValidationService -> txmetaStore "Store TX metadata"
    txValidationService -> blockassemblyService "Build Blocks"
    blockAssemblyService -> blockchainService "Manage Chain Tips"
    blockAssemblyService -> merkleSubtreeStore "Store Merkle Subtrees"
    blockAssemblyService -> utxoStore "Update UTXO set"
    blockAssemblyService -> txmetaStore "Update TX metaStore"
    minerService -> blockassemblyService "Gets Proofs of Work"
    propagationService -> p2pService "Propagates transactions and blocks"
    blockValidationService -> blockchainService "Update chain tips"
    merkleSubtreeStore -> blockValidationService "get new Merkle subtrees"
    p2pService -> propagationService "Receives propagated transactions and blocks"
    seederService -> p2pService "Seeds the network"
  }

  views {

    systemlandscape "SystemLandscape" {
      include *
      autolayout lr
    }

    container teranode {
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
        shape roundedBox
      }
    }
  }
}

