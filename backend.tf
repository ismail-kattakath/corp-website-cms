terraform {
  backend "gcs" {
    bucket = "kattakath-com-firebase-tf-state"
    prefix = "terraform/state"
  }
}
