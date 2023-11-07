
    mNetRequest = softwareSystem "TX|Subtree|Block request Multicast Group" {
      description "Requests missing TX, Subtree, or Block to be remulticasted"
      tags "MNet"
      this -> nodeNetwork.publicEndpointsService \
      "New TX|Merkle Subtree|Block request"
      this -> overlayNetwork.publicEndpointsService \
      "New TX|Merkle Subtree|Block request"
    }
