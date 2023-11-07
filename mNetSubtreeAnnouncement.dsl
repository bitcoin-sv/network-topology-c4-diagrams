
    mNetSubtreeAnnouncement = softwareSystem \
    "Merkle Subtree announcement Multicast Group" {
      description "Multicasts constructed Subtrees to the Node Network"
      tags "MNet"
      this -> nodeNetwork.publicEndpointsService "New Merkle Subtree"
      this -> overlayNetwork.publicEndpointsService "New Merkle Subtree"
    }
