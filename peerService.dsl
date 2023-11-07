
    peerService = softwareSystem "Peer Service" {
      description "Allows IPv4 Peer connections"
      this -> overlayNetwork.txStore "<-Get extended TX"
      this -> overlayNetwork.merkleSubtreeStore "Update Merkle Subtree Store"
      overlayNetwork.blockchainService -> this "Notify Block found"
      this -> nodeNetwork.txStore "<-Get extended TX"
      this -> nodeNetwork.merkleSubtreeStore "Update Merkle Subtree Store"
      nodeNetwork.blockchainService -> this "Notify Block found"
    }
