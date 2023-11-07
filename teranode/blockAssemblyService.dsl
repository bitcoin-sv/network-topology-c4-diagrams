
        blockAssemblyService = container "BlockAssembly Service" \
        "Responsible for assembling new block templates" \
        "Golang" {

          subtreeMicroService1 = component "Subtree Microservice1" \
          "Resonsible for building subtrees from blessed transactions" \
          "Golang" {
          }

          subtreeMicroService2 = component "Subtree Microservice2" \
          "Resonsible for building subtrees from blessed transactions" \
          "Golang" {
          }

          subtreeMicroService3 = component "Subtree Microservice3" \
          "Resonsible for building subtrees from blessed transactions" \
          "Golang" {
          }

          subtreeMicroService4 = component "Subtree Microservice4" \
          "Resonsible for building subtrees from blessed transactions" \
          "Golang" {
          }

          blockAssemblyController = component "BlockAssembly Controller" \
          "Combines subtrees with Merkle Tree, then constructs Block Template" \
          "Golang" {

          }

          txValBlockAssBroker -> this "Broker TXIDs to"
          txValBlockAssBroker -> subtreeMicroService1 "TXIDs to"
          txValBlockAssBroker -> subtreeMicroService2 "TXIDs to"
          txValBlockAssBroker -> subtreeMicroService3 "TXIDs to"
          txValBlockAssBroker -> subtreeMicroService4 "TXIDs to"
          subtreeMicroService1 -> blockAssemblyController "Sends subtree root hash to"
          subtreeMicroService2 -> blockAssemblyController "Sends subtree root hash to"
          subtreeMicroService3 -> blockAssemblyController "Sends subtree root hash to"
          subtreeMicroService4 -> blockAssemblyController "Sends subtree root hash to"
        }
