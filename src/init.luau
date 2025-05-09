type Element = () -> string
type Child = string | Element | () -> Element
type Component<T> = (props: T) -> (children: { Child }?) -> Element

local function escapeHtml(attribute: string): string
	attribute = string.gsub(attribute, "&", "&amp;")
	attribute = string.gsub(attribute, "<", "&lt;")
	attribute = string.gsub(attribute, ">", "&gt;")
	attribute = string.gsub(attribute, "'", "&apos;")
	attribute = string.gsub(attribute, '"', "&quot;")
	return attribute
end

--[[
Wraps a two-argument function into a "component" nested function.

local Text = createComponent(function(props: { bold: boolean }, children)
  local constents = table.concat(children, "\n")
  if props.bold then
    return `<strong>{contents}</strong>`
  else
    return contents
  end
end)

local boldText = Text({ bold = true }) {
  "Hello World",
}

print(boldText()) -- <strong>Hello World</strong>
]]--
local function createComponent<T>(component: (props: T, children: { string }?) -> string): Component<T>
	return function(props: T)
		return function(children: { Child }?)
      -- Turn the Child array into a string array. Child may be an Element or unwrapped Element.
			local stringChildren: { string }?
      if children then
        stringChildren = {}
        for i, child in children do
          if typeof(child) == "function" then -- Is an Element or unwrapped Element
            -- Child may still be a function, this is when children haven't been passed:
            -- Component(props) {
            --   OtherComponent(), <-- OtherComponent to be unwrapped twice! Once to get the Element and once to get the string
            -- }
            local wrappedElement = child()
            if typeof(wrappedElement) == "function" then
              stringChildren[i] = wrappedElement()
            else
              stringChildren[i] = wrappedElement
            end
          else
            -- Any raw strings passed in as children are escaped.
            stringChildren[i] = escapeHtml(child)
          end
        end
      end

      -- Return final Element
			return function()
				return component(props, stringChildren)
			end
		end
	end
end

local function createHtmlElement(tag: string)
	local function htmlElement(props: { [string]: string }?, children: { string }?)
		local attributes = ""
		if props then
			for key, value in props do
				attributes ..= ` {key}="{escapeHtml(value)}"`
			end
		end

		if children then
			return `<{tag}{attributes}>{table.concat(children, "\n")}</{tag}>`
		else
			return `<{tag}{attributes}></{tag}>`
		end
	end

	return createComponent(htmlElement)
end

return {
	createComponent = createComponent,

	div = createHtmlElement("div"),
	span = createHtmlElement("span"),
	h1 = createHtmlElement("h1"),
	h2 = createHtmlElement("h2"),
	h3 = createHtmlElement("h3"),
	h4 = createHtmlElement("h4"),
	h5 = createHtmlElement("h5"),
	h6 = createHtmlElement("h6"),
	p = createHtmlElement("p"),
	a = createHtmlElement("a"),
	img = createHtmlElement("img"),
	button = createHtmlElement("button"),
	input = createHtmlElement("input"),
	label = createHtmlElement("label"),
	textarea = createHtmlElement("textarea"),
	select = createHtmlElement("select"),
	option = createHtmlElement("option"),
	ul = createHtmlElement("ul"),
	ol = createHtmlElement("ol"),
	li = createHtmlElement("li"),
	table = createHtmlElement("table"),
	tr = createHtmlElement("tr"),
	td = createHtmlElement("td"),
	th = createHtmlElement("th"),
	thead = createHtmlElement("thead"),
	tbody = createHtmlElement("tbody"),
	tfoot = createHtmlElement("tfoot"),
	form = createHtmlElement("form"),
	br = createHtmlElement("br"),
	hr = createHtmlElement("hr"),
	strong = createHtmlElement("strong"),
	b = createHtmlElement("b"),
	em = createHtmlElement("em"),
	i = createHtmlElement("i"),
	u = createHtmlElement("u"),
	s = createHtmlElement("s"),
	sup = createHtmlElement("sup"),
	sub = createHtmlElement("sub"),
	small = createHtmlElement("small"),
	code = createHtmlElement("code"),
	pre = createHtmlElement("pre"),
	blockquote = createHtmlElement("blockquote"),
	nav = createHtmlElement("nav"),
	header = createHtmlElement("header"),
	footer = createHtmlElement("footer"),
	section = createHtmlElement("section"),
	article = createHtmlElement("article"),
	aside = createHtmlElement("aside"),
	main = createHtmlElement("main"),
	details = createHtmlElement("details"),
	summary = createHtmlElement("summary"),
	dialog = createHtmlElement("dialog"),
	time = createHtmlElement("time"),
	address = createHtmlElement("address"),
	mark = createHtmlElement("mark"),
	progress = createHtmlElement("progress"),
	meter = createHtmlElement("meter"),
	caption = createHtmlElement("caption"),
	figure = createHtmlElement("figure"),
	figcaption = createHtmlElement("figcaption"),
	legend = createHtmlElement("legend"),
	fieldset = createHtmlElement("fieldset"),
	dfn = createHtmlElement("dfn"),
	kbd = createHtmlElement("kbd"),
	var = createHtmlElement("var"),
	cite = createHtmlElement("cite"),
	q = createHtmlElement("q"),

	html = createHtmlElement("html"),
	head = createHtmlElement("head"),
	title = createHtmlElement("title"),
	meta = createHtmlElement("meta"),
	link = createHtmlElement("link"),
	style = createHtmlElement("style"),
	body = createHtmlElement("body"),

	script = createHtmlElement("script"),
	noscript = createHtmlElement("noscript"),

	audio = createHtmlElement("audio"),
	video = createHtmlElement("video"),
	source = createHtmlElement("source"),
	track = createHtmlElement("track"),
	iframe = createHtmlElement("iframe"),
	canvas = createHtmlElement("canvas"),
	svg = createHtmlElement("svg"),
}
