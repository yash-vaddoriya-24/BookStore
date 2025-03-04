// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import { Turbo } from "@hotwired/turbo-rails"
import { StreamActions } from "@hotwired/turbo"
Turbo.session.drive = true
StreamActions.log = function () {
    console.log(this.getAttribute("message"))
}
import "controllers"
import "bootstrap"
import "popper.js"
