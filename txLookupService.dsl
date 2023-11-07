
    txLookupService = softwareSystem "TX/TXO Lookup Service" {
      description "Allows legacy lookup of transactions and transaction outputs"
      this -> overlayNetwork.txStore "<-Get extended TX"
      this -> nodeNetwork.txStore "<-Get extended TX"
      legacyP2PNetworkBridge -> this "Extend TX if needed"
    }
