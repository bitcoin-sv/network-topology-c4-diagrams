blockvalidationService = container "BlockValidation Service" {
  description "Validates new Blocks"
  technology "Golang"

  bVSubtreeMicroservice1 = component "BlockValidation Subtree Microservice1" {
    description "Receives subtree lists and Block Announcements for validation"
    technology "Golang"
  }

  bVSubtreeMicroservice2 = component "BlockValidation Subtree Microservice2" {
    description "Receives, validates, and stores subtree lists and \
    Block Announcements for validation"
    technology "Golang"
  }

  bVController = component "BlockValidation Controller" {
    description "Consolodates subtrees and Announces when a valid Block \
    has been found to the Blockchain Service"
    technology "Golang"
  }


  this -> blockchainService "Valid Block found"
  bVController -> blockchainService "Valid Block found"
  bVSubtreeMicroservice1 -> bVController "Valid subtree to"
  bVSubtreeMicroservice2 -> bVController "Valid subtree to"
}
