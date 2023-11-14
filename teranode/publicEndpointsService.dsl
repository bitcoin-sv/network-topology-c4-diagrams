publicEndpointsService = container "Public Endpoints Service" {
  description "Provides API Endppoints"
  technology "Golang"
  this -> blockValidationService \
  "Block found | Subtree received"
}
