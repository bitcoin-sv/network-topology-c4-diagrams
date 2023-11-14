views {

  systemlandscape "SystemLandscape" {
    include alice bob overlayNetwork mNet nodeNetwork
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

  component "nodeNetwork.blockAssemblyService" {
    include *
    //autolayout tb
  }

  component "nodeNetwork.txValidationService" {
    include *
    //autolayout tb
  }

  component "nodeNetwork.propagationService" {
    include *
    //autolayout tb
  }

  component "nodeNetwork.blockchainService" {
    include *
    autolayout tb
  }

  component "nodeNetwork.blockValidationService" {
    include *
    //autolayout tb
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
