
    mNetTXSubmission = softwareSystem "TX Submission Multicast Group" {
      description "Multicasts received extended transactions to the Node Network"
      tags "MNet"
      this -> nodeNetwork.txStore "Multicasts extended TXs to"
      this -> nodeNetwork.propagationService "Multicasts extended TXs to"
      this -> banlistService "Multicasts transactions to"
      this -> txSubmissionService "Receives TXs from"
      this -> overlayNetwork.txStore "Multicasts extended TXs to"
      this -> overlayNetwork.propagationService "Multicasts extended TXs to"
      legacyP2PNetworkBridge -> this "Receive extended TXs from | Send TXs to"
    }
