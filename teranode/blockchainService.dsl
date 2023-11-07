blockchainService = container "Blockchain Service" {
  description "Responsible for managing the Block Headers and list of \
  subtrees in a Block."
  technology "Golang"

  blockchainServer = component "Blockchain Server" {
    description "Manages the Block Headers and subtree lists in a block"
    technology "Golang"
  }




  blockAssemblyService -> this "Notify Block found | <-Get best Block Header"
  blockAssemblyService -> blockchainServer "Notify Block found"
  blockchainServer -> blockAssemblyService "Return Best Block Header"

  //TODO: Add relationship to Public Endpoints Service
}
