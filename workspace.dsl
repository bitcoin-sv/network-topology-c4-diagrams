workspace {

  !identifiers hierarchical

  model {

//  Teranode
    !include ./teranode/teranode.dsl

//  Overlay Node
    !include ./overlayNode.dsl

//  Teranode Ancilliary Services
    !include ./legacyP2PNetworkBridge.dsl

    !include ./txLookupService.dsl

    !include ./peerService.dsl

    !include ./coinbaseOverlayNode.dsl

    !include ./txSubmissionService.dsl

    !include ./banlistService.dsl

    !include ./utxoLookupService.dsl

    !include ./hashers.dsl



//  Multicast Network (mNet or M-Net)
    !include ./mNet.dsl

    !include ./mNetTxSubmission.dsl

    !include ./mNetBlockAnnouncement.dsl

    !include ./mNetSubtreeAnnouncement.dsl

    !include ./mNetRequest.dsl

    !include ./wallet.dsl


//  SystemLandscape
    wallet -> overlayNetwork "Interacts with and submits transactions to"
    overlayNetwork -> mNet "Submits extended TXs to"
    mNet -> nodeNetwork "Multicasts extended TXs to"

  }

  !include ./views.dsl

}

