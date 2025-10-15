import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["form"];

  connect() {
    this.boundHandleSubmitEnd = this.handleSubmitEnd.bind(this);
    this.element.addEventListener(
      "turbo:submit-end",
      this.boundHandleSubmitEnd
    );
  }

  handleSubmitEnd(event) {
    if (event.detail.success) {
      setTimeout(() => {
        this.clear();
      }, 100);
    }
  }

  clear() {
    if (!this.hasFormTarget) return;

    this.formTarget.reset();

    const errorElements = this.element.querySelectorAll(".error_messages");
    errorElements.forEach((el) => el.remove());

    const fieldElements = this.element.querySelectorAll(".field_with_errors");
    fieldElements.forEach((el) => el.classList.remove("field_with_errors"));

    const firstInput = this.formTarget.querySelector(
      'input:not([type="submit"]):not([type="hidden"]), textarea'
    );
    if (firstInput) {
      firstInput.focus();
    }
  }

  disconnect() {
    if (this.boundHandleSubmitEnd) {
      this.element.removeEventListener(
        "turbo:submit-end",
        this.boundHandleSubmitEnd
      );
    }
  }
}
