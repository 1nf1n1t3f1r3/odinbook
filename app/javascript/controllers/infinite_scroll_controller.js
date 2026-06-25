import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["link"];

  connect() {
    // 1. Create an observer that watches for elements entering the screen
    this.observer = new IntersectionObserver(
      (entries) => {
        entries.forEach((entry) => {
          // 2. If our pagination frame enters the viewport, trigger the load!
          if (entry.isIntersecting) {
            this.loadMore();
          }
        });
      },
      {
        rootMargin: "200px", // Starts loading 200px before the user even hits the absolute bottom!
      },
    );

    // 3. Start observing this target element
    if (this.hasLinkTarget) {
      this.observer.observe(this.element);
    }
  }

  disconnect() {
    // Clean up memory if the user leaves the page
    if (this.observer) this.observer.disconnect();
  }

  loadMore() {
    // Programmatically trigger a click on our hidden Turbo Stream link
    this.linkTarget.click();
  }
}
