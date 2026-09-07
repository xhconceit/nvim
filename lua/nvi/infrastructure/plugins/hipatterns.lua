return {
  {
    "nvim-mini/mini.hipatterns",
    version = false,
    event = "VeryLazy",

    config = function()
      local hipatterns = require("mini.hipatterns")

      hipatterns.setup({
        highlighters = {
          fixme = {
            pattern = {
              "%f[%w]()FIXME()%f[%W]",
              "%f[%w]()BUG()%f[%W]",
              "%f[%w]()XXX()%f[%W]",
            },
            group = "MiniHipatternsFixme",
          },
          hack = {
            pattern = {
              "%f[%w]()HACK()%f[%W]",
              "%f[%w]()WARN()%f[%W]",
            },
            group = "MiniHipatternsHack",
          },
          todo = {
            pattern = {
              "%f[%w]()TODO()%f[%W]",
              "%f[%w]()PERF()%f[%W]",
            },
            group = "MiniHipatternsTodo",
          },

          note = {
            pattern = {
              "%f[%w]()NOTE()%f[%W]",
              "%f[%w]()INFO()%f[%W]",
            },
            group = "MiniHipatternsNote",
          },

          hex_color = hipatterns.gen_highlighter.hex_color({
            style = "inline",
          }),
        },
      })
    end,
  },
}
