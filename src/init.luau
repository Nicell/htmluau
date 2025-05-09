type Children = { string | () -> string }
type Component<T> = (props: T) -> (children: Children) -> string

local function createComponent<T>(component: (props: T, children: Children) -> string): Component<T>
  return function(props: T): (children: Children) -> string
    return function(children: Children): string
      return component(props, children)
    end
  end
end

local function escapeAttribute(attribute: string): string
  attribute = string.gsub(attribute, "&", "&amp;")
  attribute = string.gsub(attribute, '"', "&quot;")
  return attribute
end

local function createElement(tag: string): Component<any?>
  return function(props: any?)
    return function(children: Children): string
      local attributes = ""
      if props then
        for key, value in props do
          attributes ..= ` {key}="{escapeAttribute(value)}"`
        end
      end

      for i, child in children do
        if type(child) == "function" then
          children[i] = child()
        end
      end
      local contents = table.concat(children, "\n")

      return `<{tag}{attributes}>{contents}</{tag}>`
    end
  end
end

return {
  createComponent = createComponent,

  div = createElement("div"),
  span = createElement("span"),
  h1 = createElement("h1"),
  h2 = createElement("h2"),
  h3 = createElement("h3"),
  h4 = createElement("h4"),
  h5 = createElement("h5"),
  h6 = createElement("h6"),
  p = createElement("p"),
  a = createElement("a"),
  img = createElement("img"),
  button = createElement("button"),
  input = createElement("input"),
  label = createElement("label"),
  textarea = createElement("textarea"),
  select = createElement("select"),
  option = createElement("option"),
  ul = createElement("ul"),
  ol = createElement("ol"),
  li = createElement("li"),
  table = createElement("table"),
  tr = createElement("tr"),
  td = createElement("td"),
  th = createElement("th"),
  thead = createElement("thead"),
  tbody = createElement("tbody"),
  tfoot = createElement("tfoot"),
  form = createElement("form"),
  br = createElement("br"),
  hr = createElement("hr"),
  strong = createElement("strong"),
  b = createElement("b"),
  em = createElement("em"),
  i = createElement("i"),
  u = createElement("u"),
  s = createElement("s"),
  sup = createElement("sup"),
  sub = createElement("sub"),
  small = createElement("small"),
  code = createElement("code"),
  pre = createElement("pre"),
  blockquote = createElement("blockquote"),
  nav = createElement("nav"),
  header = createElement("header"),
  footer = createElement("footer"),
  section = createElement("section"),
  article = createElement("article"),
  aside = createElement("aside"),
  main = createElement("main"),
  details = createElement("details"),
  summary = createElement("summary"),
  dialog = createElement("dialog"),
  time = createElement("time"),
  address = createElement("address"),
  mark = createElement("mark"),
  progress = createElement("progress"),
  meter = createElement("meter"),
  caption = createElement("caption"),
  figure = createElement("figure"),
  figcaption = createElement("figcaption"),
  legend = createElement("legend"),
  fieldset = createElement("fieldset"),
  dfn = createElement("dfn"),
  kbd = createElement("kbd"),
  var = createElement("var"),
  cite = createElement("cite"),
  q = createElement("q"),

  html = createElement("html"),
  head = createElement("head"),
  title = createElement("title"),
  meta = createElement("meta"),
  link = createElement("link"),
  style = createElement("style"),
  body = createElement("body"),

  script = createElement("script"),
  noscript = createElement("noscript"),

  audio = createElement("audio"),
  video = createElement("video"),
  source = createElement("source"),
  track = createElement("track"),
  iframe = createElement("iframe"),
  canvas = createElement("canvas"),
  svg = createElement("svg"),
}
