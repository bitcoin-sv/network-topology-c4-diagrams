
    nodeNetwork = softwareSystem "Node Network (Teranode)" "Timestamps  \
    transactions into Blocks, maintains UTXO set, and enforces the rules  \
    of the Blockchain" {

        tags "SoftwareSystem"

        !include ./propagationService.dsl

        propTxValBroker = container "Propagation-TxValidation Message Broker" {
          description "Responsible for brokering transactions from Propagation \
          Services to TX Validation Services"
          technology "Kafka"
          tags "MessageBroker"
          propagationService -> this "Sends extended TXs to"
          propagationService.mNetReceiverMicroservice1 -> this "Sends extended TXs to"
          propagationService.mNetReceiverMicroservice2 -> this "Sends extended TXs to"
          propagationService.mNetReceiverMicroservice3 -> this "Sends extended TXs to"
          propagationService.mNetReceiverMicroservice4 -> this "Sends extended TXs to"
        }

        !include ./txValidationService.dsl

        txValBlockAssBroker = container "TxValidation-BlockAssembly Message Broker" {
          description "Responsible for brokering TXIDs from the TX Validation \
          Services to the Block Assembly Services"
          tags "MessageBroker"
          technology "Golang"
          txValidationService -> this "Send TXIDs to"
          txValidationService.txValidationMicroservice1 -> this "Send TXIDs to"
          txValidationService.txValidationMicroservice2 -> this "Send TXIDs to"
          txValidationService.txValidationMicroservice3 -> this "Send TXIDs to"
          txValidationService.txValidationMicroservice4 -> this "Send TXIDs to"
        }

        !include ./blockAssemblyService.dsl

        !include ./blockchainService.dsl

        !include ./blockValidationService.dsl


        publicEndpointsService = container "Public Endpoints Service" {
          description "Provides API Endppoints"
          technology "Golang"
          this -> blockValidationService \
          "Block found | Subtree received"
        }

        //Teranode Data Stores
        txmetaStore = container "TxMeta Store" \
        "Manages transaction metadata" "TX Metadata" {
          tags "Database"
          txValidationService -> this "Store TX metadata"
          blockAssemblyService -> this "Update TX Meta Store"
          blockValidationService -> this "Update TX Meta Meta Store"
          blockAssemblyService.subtreeMicroService1 -> this "Validates TXIDs against"
          blockAssemblyService.subtreeMicroService2 -> this "Validates TXIDs against"
          blockAssemblyService.subtreeMicroService3 -> this "Validates TXIDs against"
          blockAssemblyService.subtreeMicroService4 -> this "Validates TXIDs against"
          txValidationService.txValidationMicroservice1 -> this "TX metadata to"
          txValidationService.txValidationMicroservice2 -> this "TX metadata to"
          txValidationService.txValidationMicroservice3 -> this "TX metadata to"
          txValidationService.txValidationMicroservice4 -> this "TX metadata to"
          blockValidationService.bVSubtreeMicroservice1 -> this "TX metadata to"
          blockValidationService.bVSubtreeMicroservice2 -> this "TX metadata to"
        }

        txStore = container "Tx Store" "Stores TXs" \
        "TXs" {
          tags "Database"
          propagationService.mNetReceiverMicroservice1 -> this "Stores TXs in"
          propagationService.mNetReceiverMicroservice2 -> this "Stores TXs in"
          propagationService.mNetReceiverMicroservice3 -> this "Stores TXs in"
          propagationService.mNetReceiverMicroservice4 -> this "Stores TXs in"
          blockValidationService.bVSubtreeMicroservice1 -> this "Store missing TXs in"
          blockValidationService.bVSubtreeMicroservice2 -> this "Store missing TXs in"
        }

        utxoStore = container "UTXO Store" "Manages UTXOs" "UTXOs" {
          tags "Database"
          txValidationService -> this "Validate against UTXO set | Update UTXO set"
          blockAssemblyService -> this "Update UTXO set"
          txValidationService.txValidationMicroservice1 -> this "Update UTXOs to 'spent'"
          txValidationService.txValidationMicroservice2 -> this "Update UTXOs to 'spent'"
          txValidationService.txValidationMicroservice3 -> this "Update UTXOs to 'spent'"
          txValidationService.txValidationMicroservice4 -> this "Update UTXOs to 'spent'"
          blockValidationService.bVSubtreeMicroservice1 -> this "Update UTXOs to 'spent'"
          blockValidationService.bVSubtreeMicroservice2 -> this "Update UTXOs to 'spent'"
        }

        blockHeaderStore = container "Block Header Store" {
          description "Manages Block Headers"
          technology "Block Headers"
          tags "Database"
          blockchainService -> this \
          "Update Block Header Store | <-Get best Block Header"
          blockchainService.blockchainServer -> this \
          "Update Block Header Store | <-Get best Block Header"
        }

        merkleSubtreeStore = container "Merkle Subtree Store" \
        "Manages Merkle Subtrees" "Merkle Subtrees" {
          tags "Database"
          blockAssemblyService -> this \
          "Store Merkle Subtrees | <-Get new Merkle Subtrees"
          blockValidationService -> this "Get new Merkle Subtrees"
          publicEndpointsService -> this "Subtree received"
          blockAssemblyService.subtreeMicroService1 -> this "Store subtrees in"
          blockAssemblyService.subtreeMicroService2 -> this "Store subtrees in"
          blockAssemblyService.subtreeMicroService3 -> this "Store subtrees in"
          blockAssemblyService.subtreeMicroService4 -> this "Store subtrees in"
          blockValidationService.bVSubtreeMicroservice1 -> this "Store subtrees in"
          blockValidationService.bVSubtreeMicroservice2 -> this "Store subtrees in"
        }
    }
