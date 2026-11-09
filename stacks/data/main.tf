# PR 2: gi fra seg dataressursene, uten å slette dem i Azure.
removed {
  from = module.storage
  lifecycle {
    destroy = false
  }
}

removed {
  from = module.keyvault
  lifecycle {
    destroy = false
  }
}
