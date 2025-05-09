local net = require("@lute/net")

local htmluau = require("./src")

local html = htmluau.html
local head = htmluau.head
local title = htmluau.title
local body = htmluau.body
local h1 = htmluau.h1
local button = htmluau.button
local p = htmluau.p

local website = html({ lang = "en" }) {
  head() {
    title() {
      "Hello World",
    },
  },
  body() {
    h1() {
      "Hello World",
    },
    button({ onclick = "alert('Hello World!')" }) {
      "Click Me",
    },
    p() {
      "This is a simple HTML page generated using Luau.",
      "Lines are concatenated.",
      "So you can write sentences on separate lines"
    }
  },
}

net.serve(function()
  return website
end)
