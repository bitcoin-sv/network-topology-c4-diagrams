
    mNetSubtreeAnnouncement = softwareSystem \
    "Merkle Subtree announcement Multicast Group" {
      description "Multicasts constructed Subtrees to the Node Network"
      tags "MNet"
      this -> nodeNetwork.publicEndpointsService "New Merkle Subtree"
      this -> overlayNetwork.publicEndpointsService "New Merkle Subtree"
      this -> nodeNetwork.blockValidationService.bVSubtreeMicroservice1 "Receive subtree"
      this -> nodeNetwork.blockValidationService.bVSubtreeMicroservice2 "Receive subtree"
    }
