
    utxoLookupService = softwareSystem "UTXO Lookup Service" {
      description "Provides an API to lookup the statuses of UTXOs"
      this -> nodeNetwork.utxoStore "<-Get UTXO status"
      this -> nodeNetwork.txmetaStore "<-Get TX metadata"
      this -> overlayNetwork.utxoStore "<-Get UTXO status"
      this -> overlayNetwork.txmetaStore "<-Get TX metadata"
    }
