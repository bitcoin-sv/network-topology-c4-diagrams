
    mNetBlockAnnouncement = softwareSystem "Block announcement Multicast Group" {
      description "Multicasts found Blocks to the Node Network"
      tags "MNet"
      this -> nodeNetwork.publicEndpointsService "Block found | Notify Block found"
      this -> overlayNetwork.publicEndpointsService "Block found | Notify Block found"
    }
