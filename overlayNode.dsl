
//  Overlay Node
    overlayNetwork = softwareSystem "Overlay Network (Overlay Node)" {

      tags "SoftwareSystem"

        propagationService = container "Propagation Service" {
          description \
          "Responsible for the propagation of transactions and blocks across the network"
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
        txmetaStore = container "TxMeta Store" \
        "Manages transaction metadata" "TX Metadata" {
          tags "Database"
        }

        txStore = container "Tx Store" "Manages transaction metadata" "TX Metadata" {
          tags "Database"
        }

        utxoStore = container "UTXO Store" "Manages UTXOs" "UTXOs" {
          tags "Database"
        }

        blockHeaderStore = container "Block Header Store" \
        "Manages Block Headers" "Block Headers" {
          tags "Database"
          blockchainService -> this \
          "Update Block Header Store | <-Get best Block Header"
        }

        merkleSubtreeStore = container "Merkle Subtree Store" \
        "Manages Merkle Subtrees" "Merkle Subtrees" {
          tags "Database"
          publicEndpointsService -> this "Subtree received"
        }

    }
