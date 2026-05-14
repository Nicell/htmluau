local test = require("@std/test")

local htmluau = require("../src")

test.suite("HTMLuau", function(suite)
	suite:case("renders nested elements and joins sibling children with newlines", function(assert)
		local document = htmluau.div({ id = "root" }) {
			htmluau.h1() {
				"Hello",
			},
			htmluau.p() {
				"First line",
				"Second line",
			},
		}

		assert.eq('<div id="root"><h1>Hello</h1>\n<p>First line\nSecond line</p></div>', document())
	end)

	suite:case("escapes raw text children and attribute values", function(assert)
		local element = htmluau.p({
			title = "5 > 3 & \"quoted\" 'single'",
		}) {
			"<script>alert(\"x\")</script> & 'raw'",
		}

		assert.eq(
			'<p title="5 &gt; 3 &amp; &quot;quoted&quot; &apos;single&apos;">&lt;script&gt;alert(&quot;x&quot;)&lt;/script&gt; &amp; &apos;raw&apos;</p>',
			element()
		)
	end)

	suite:case("does not escape markup returned from elements", function(assert)
		local element = htmluau.div() {
			htmluau.strong() {
				"safe",
			},
			htmluau.br(),
		}

		assert.eq("<div><strong>safe</strong>\n<br></br></div>", element())
	end)

	suite:case("renders custom components that return elements", function(assert)
		local Panel = htmluau.createComponent(function(props: { title: string }, children: { string }?)
			return htmluau.section({ role = "region" }) {
				htmluau.h2() {
					props.title,
				},
				htmluau.div() {
					children or {},
				},
			}
		end)

		local panel = Panel({ title = "Summary" }) {
			"Total < 10",
			htmluau.strong() {
				"ok",
			},
		}

		assert.eq(
			'<section role="region"><h2>Summary</h2>\n<div>Total &lt; 10\n<strong>ok</strong></div></section>',
			panel()
		)
	end)

	suite:case("flattens element lists from map", function(assert)
		local items = { "one", "two", "three" }

		local list = htmluau.ul() {
			htmluau.map(items, function(value, index)
				return htmluau.li({ ["data-index"] = tostring(index) }) {
					value,
				}
			end),
		}

		assert.eq(
			'<ul><li data-index="1">one</li>\n<li data-index="2">two</li>\n<li data-index="3">three</li></ul>',
			list()
		)
	end)
end)
