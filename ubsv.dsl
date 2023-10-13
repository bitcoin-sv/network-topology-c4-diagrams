workspace {

    model {
        user = person "User"
        bsvNode = softwareSystem "Bitcoin SV Node" {
            description "A comprehensive Bitcoin SV (BSV) node implementation"
            database = container "Database" "Stores blockchain data, UTXOs, transaction metadata" "SQL"
            blockchainService = container "Blockchain Service" "Interacts with the Bitcoin SV blockchain"
            utxoService = container "UTXO Service" "Manages UTXOs"
            transactionService = container "Transaction Metadata Service" "Manages transaction metadata"
            p2pService = container "P2P Service" "Handles P2P communication"
            minerService = container "Miner Service" "Mines new blocks"
            blobServer = container "Blob Server" "Stores and retrieves large data objects"
            ui = container "UI Dashboard" "User interface for interacting with the node" "Svelte"
            blockAssemblyService = container "Block Assembly Service" "Assembles new blocks"
            blockValidationService = container "Block Validation Service" "Validates new blocks"
            propagationService = container "Propagation Service" "Propagates new blocks and transactions"
            seederService = container "Seeder Service" "Seeds new transactions"
            coinbaseService = container "Coinbase Service" "Manages coinbase transactions"
            bootstrapService = container "Bootstrap Service" "Bootstraps the system"

            blockchainService -> database "Reads from and writes to"
            utxoService -> database "Reads from and writes to"
            transactionService -> database "Reads from and writes to"
            minerService -> blockchainService "Interacts with"
            minerService -> utxoService "Interacts with"
            minerService -> transactionService "Interacts with"
            p2pService -> blockchainService "Interacts with"
            p2pService -> utxoService "Interacts with"
            p2pService -> transactionService "Interacts with"
            blobServer -> database "Reads from and writes to"
            ui -> blockchainService "Interacts with"
            ui -> utxoService "Interacts with"
            ui -> transactionService "Interacts with"
            ui -> p2pService "Interacts with"
            ui -> minerService "Interacts with"
            ui -> blobServer "Interacts with"
            blockAssemblyService -> blockchainService "Interacts with"
            blockValidationService -> blockchainService "Interacts with"
            propagationService -> p2pService "Interacts with"
            seederService -> p2pService "Interacts with"
            coinbaseService -> minerService "Interacts with"
            bootstrapService -> blockchainService "Interacts with"
            bootstrapService -> utxoService "Interacts with"
            bootstrapService -> transactionService "Interacts with"
            bootstrapService -> p2pService "Interacts with"
            bootstrapService -> minerService "Interacts with"
            bootstrapService -> blobServer "Interacts with"
        }

        user -> bsvNode "Interacts with"
    }

    views {
        systemContext bsvNode {
            include *
            autoLayout
        }
        container bsvNode {
            include *
            autoLayout
        }
    }
}
