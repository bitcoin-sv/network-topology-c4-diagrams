txValidationService = container "TX Validation Service" {

  description "Responsible for validating transactions"
  technology "Golang"


  txValidationMicroService1 = component "TX Validation Microservice1" {
    description "Validates transactions, updates UTXO Store, and updates TX \
    Status Store"
    technology "Golang"
  }

  txValidationMicroService2 = component "TX Validation Microservice2" {
    description "Validates transactions, updates UTXO Store, and updates TX \
    Status Store"
    technology "Golang"
  }

  txValidationMicroService3 = component "TX Validation Microservice3" {
    description "Validates transactions, updates UTXO Store, and updates TX \
    Status Store"
    technology "Golang"
  }

  txValidationMicroService4 = component "TX Validation Microservice4" {
    description "Validates transactions, updates UTXO Store, and updates TX \
    Status Store"
    technology "Golang"
  }

  propTxValBroker -> this "Broker extended TXs to"
  propTxValBroker -> txValidationMicroService1 "Broker extended TXs to"
  propTxValBroker -> txValidationMicroService2 "Broker extended TXs to"
  propTxValBroker -> txValidationMicroService3 "Broker extended TXs to"
  propTxValBroker -> txValidationMicroService4 "Broker extended TXs to"
}
