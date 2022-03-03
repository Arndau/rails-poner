import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  connect() {
    console.log("Hello from our first Stimulus controller");
  }

  enable() {
    console.log(click);
  }

  modaldisplay() {
    this.element.innerText = "Bingo!"
    this.element.setAttribute(('#myModal').modal(option))
  }
}
