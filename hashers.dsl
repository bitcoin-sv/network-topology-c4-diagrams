
    hashers = softwareSystem "Hashing pool to find Proof-of-Work" {
      nodeNetwork.blockAssemblyService -> this \
      "Send Block Candidate to | Receive Proof-of-Work from"

      nodeNetwork.blockAssemblyService.blockAssemblyController -> this \
      "Send Block Candidate to | Receive Proof-of-Work from"
    }
