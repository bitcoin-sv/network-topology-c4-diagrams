
    nodeNetwork = softwareSystem "Node Network (Teranode)" "Timestamps  \
    transactions into Blocks, maintains UTXO set, and enforces the rules  \
    of the Blockchain" {

        tags "SoftwareSystem"


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
          propagationService -> this "Send extended TXs to"
        }

        txValidationService = container "TX Validation Service" {
          description "Responsible for validating transactions"
          technology "Golang"
          propTxValBroker -> this "Broker extended TXs to"
        }

        txValBlockAssBroker = container "TxValidation-BlockAssembly Message Broker" {
          description "Responsible for brokering TXIDs from the TX Validation \
          Services to the Block Assembly Services"
          tags "MessageBroker"
          technology "Golang"
          txValidationService -> this "Send TXIDs to"
        }

        blockassemblyService = container "BlockAssembly Service" \
        "Responsible for assembling new blocks with transactions" "Golang" {
          txValBlockAssBroker -> this "Broker TXIDs to"
        }

        blockchainService = container "Blockchain Service" \
        "Handles operations related to the blockchain" "Golang" {
          blockAssemblyService -> this \
          "Notify Block found | <-Get best Block Header"
        }

        blockvalidationService = container "BlockValidation Service" {
          description "Validates new Blocks"
          technology "Golang"
          this -> blockchainService "Valid Block found"
        }

        publicEndpointsService = container "Public Endpoints Service" {
          description "Provides API Endppoints"
          technology "Golang"
          this -> blockValidationService \
          "Block found| <-Notify Block found"
        }

        //Teranode Data Stores
        txmetaStore = container "TxMeta Store" \
        "Manages transaction metadata" "TX Metadata" {
          tags "Database"
          txValidationService -> this "Store TX metadata"
          blockAssemblyService -> this "Update TX Meta Store"
          blockValidationService -> this "Update TX Meta Meta Store"
        }

        txStore = container "Tx Store" "Manages transaction metadata" \
        "TX Metadata" {
          tags "Database"
        }

        utxoStore = container "UTXO Store" "Manages UTXOs" "UTXOs" {
          tags "Database"
          txValidationService -> this "Validate against UTXO set | Update UTXO set"
          blockAssemblyService -> this "Update UTXO set"
        }

        blockHeaderStore = container "Block Header Store" {
          description "Manages Block Headers"
          technology "Block Headers"
          tags "Database"
          blockchainService -> this \
          "Update Block Header Store | <-Get best Block Header"
        }

        merkleSubtreeStore = container "Merkle Subtree Store" \
        "Manages Merkle Subtrees" "Merkle Subtrees" {
          tags "Database"
          blockAssemblyService -> this \
          "Store Merkle Subtrees | <-Get new Merkle Subtrees"
          blockValidationService -> this "Get new Merkle Subtrees"
          publicEndpointsService -> this "Subtree received"
        }
    }
