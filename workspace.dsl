workspace {

  !identifiers hierarchical

  model {

//  Teranode
    !include ./teranode.dsl

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

  views {

    systemlandscape "SystemLandscape" {
      include wallet overlayNetwork mNet nodeNetwork
      autolayout lr
    }

    container "nodeNetwork" {
      include *
      //autolayout lr
    }

    container "overlayNetwork" {
      include *
      //autolayout lr
    }

    styles {
      element "SoftwareSystem" {
        strokeWidth 4
        background #1168bd
        color #ffffff
        shape roundedBox
      }
      element "Person" {
        shape person
        background #08427b
        color #ffffff
      }
      element "Container" {
        shape roundedBox
        background #438dd5
        color #ffffff
      }
      element "Database" {
        background #0ba789
        color #ffffff
        shape cylinder
      }

      element "MNet" {
        background #929292
        color #ffffff
        shape hexagon
      }

      element "MessageBroker" {
        background #929292
        color #ffffff
        shape pipe
      }
    }
  }
}

