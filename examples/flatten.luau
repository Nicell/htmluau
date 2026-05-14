local htmluau = require("../src")

local html = htmluau.html
local body = htmluau.body
local article = htmluau.article
local div = htmluau.div
local p = htmluau.p
local map = htmluau.map

local cards = {
	article() {
		"First",
	},
	article() {
		"Second",
	},
}

local sites = {
	home = "https://luau.page",
	docs = "https://luau.org",
}

return html({ lang = "en" }) {
	body() {
		article() {
			"Hello",
		},
		cards,
		div() {
			cards,
		},
		map(sites, function(value, key)
			return p() {
				key,
				": ",
				value,
			}
		end),
	},
}
