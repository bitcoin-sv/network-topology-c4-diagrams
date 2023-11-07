
    banlistService = softwareSystem "Banlist Service" {
      description \
      "Maintains a dynamic banlist related to rejected TXs, Blocks, and Subtrees"
      this -> nodeNetwork.utxoStore "Updates UTXO Store"
      this -> overlayNetwork.utxoStore "Updates UTXO Store"
    }
