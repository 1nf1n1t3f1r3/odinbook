// app/javascript/controllers/autosize_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    this.resize();
    this.element.addEventListener("input", () => this.resize());
  }

  resize() {
    this.element.style.height = "auto";

    const computed = window.getComputedStyle(this.element);
    const paddingTop = parseFloat(computed.paddingTop);
    const paddingBottom = parseFloat(computed.paddingBottom);

    this.element.style.height =
      this.element.scrollHeight + paddingTop + paddingBottom + "px";
  }
}
