local net = require("@lute/net")

local htmluau = require("../src")

local html = htmluau.html
local div = htmluau.div
local head = htmluau.head
local title = htmluau.title
local body = htmluau.body
local img = htmluau.img
local h2 = htmluau.h2
local p = htmluau.p

local createComponent = htmluau.createComponent

local Card = createComponent(function(props: { image: string, title: string, content: string })
	return div({ style = "display: flex; flex-direction: column; width: 200px" }) {
		img({ src = props.image, alt = props.title }),
		h2() {
			props.title,
		},
		p() {
			props.content,
		},
	}
end)

local website = html({ lang = "en" }) {
	head() {
		title() {
			"Card Example",
		},
	},
	body({ style = "font-family: sans-serif; margin: 0; padding: 20px" }) {
		div({ style = "display: flex; gap: 10px" }) {
			Card({
				image = "https://picsum.photos/id/237/200",
				title = "Card Title",
				content = "This is the content of the card.",
			}),
			Card({
				image = "https://picsum.photos/id/234/200",
				title = "Another Card Title",
				content = "This is the content of another card.",
			}),
		},
	},
}

net.serve(function()
	return website()
end)
