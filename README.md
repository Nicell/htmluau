# HTMLuau

Simple HTML templating in Luau.

```luau
html({ lang = "en" }) {
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
```
