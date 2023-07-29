import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="richer-text-editor"
export default class extends Controller {
  static targets = ["input"];

  update(event) {
    this.inputTarget.value = event.detail.html;
  }
}
