propagationService = container "Propagation Service" {
  description "Responsible for receiving TXs from the mNet, performing some \
  initial TX validation checks, and storing TXs in the TX Store"
  technology "Golang"

  mNetReceiverMicroservice1 = component "mNet Receiver Microservice1" {
    description "Receives extended transactions from mNet group addresses, \
    stores the TXs in the TX store, then forwards them to the \
    Propagation-TxValidation Message Broker"
    technology "Golang"
  }

  mNetReceiverMicroservice2 = component "mNet Receiver Microservice2" {
    description "Receives extended transactions from mNet group addresses, \
    stores the TXs in the TX store, then forwards them to the \
    Propagation-TxValidation Message Broker"
    technology "Golang"
  }

  mNetReceiverMicroservice3 = component "mNet Receiver Microservice3" {
    description "Receives extended transactions from mNet group addresses, \
    stores the TXs in the TX store, then forwards them to the \
    Propagation-TxValidation Message Broker"
    technology "Golang"
  }

  mNetReceiverMicroservice4 = component "mNet Receiver Microservice4" {
    description "Receives extended transactions from mNet group addresses, \
    stores the TXs in the TX store, then forwards them to the \
    Propagation-TxValidation Message Broker"
    technology "Golang"
  }


}
