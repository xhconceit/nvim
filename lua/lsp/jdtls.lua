local lsp = require("lsp")
local keymap = require("core.keymap")
-- brew install jdtls

local jdtls_path = vim.fn.exepath("jdtls")

if jdtls_path == "" then
    vim.notify("jdtls 未安装，请先安装", vim.log.levels.WARN)
    return
end

-- 每个项目一个 workspace 目录，避免冲突
local function get_workspace_folder()
    local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
    return vim.fn.stdpath("data") .. "/jdtls-workspace/" .. project_name
end

-- 查找项目根目录

local function get_root_folder()
    return require("jdtls.setup").find_root({
        ".git",
        "mvnw",
        "gradlew",
        "pom.xml",
        "build.gradle",
        "build.gradle.kts",
    })
end

local function start_jdtls()
    local config = {
        cmd = {
            "jdtls",
            "-data",
            get_workspace_folder(),
        },
        root_dir = get_root_folder(),
        on_attach = function(client, bufnr)
            lsp.on_attach(client, bufnr)

            keymap.nmap("<leader>jo", require("jdtls").organize_imports, {
                desc = "整理 imports",
                buffer = bufnr,
            })
            keymap.nmap("<leader>jv", require("jdtls").extract_variable, {
                desc = "提取变量",
                buffer = bufnr,
            })
            keymap.nmap("<leader>jc", require("jdtls").extract_constant, {
                desc = "提取常量",
                buffer = bufnr,
            })
            keymap.nmap("<leader>jt", require("jdtls").test_nearest_method, {
                desc = "测试当前方法",
                buffer = bufnr,
            })
            keymap.nmap("<leader>jT", require("jdtls").test_class, {
                desc = "测试当前类",
                buffer = bufnr,
            })
        end,
        capabilities = lsp.capabilities,
        settings = {
            java = {
              signatureHelp = { enabled = true },
              contentProvider = { preferred = "fernflower" },
              completion = {
                favoriteStaticMembers = {
                  "org.junit.Assert.*",
                  "org.junit.jupiter.api.Assertions.*",
                  "org.mockito.Mockito.*",
                  "java.util.Objects.requireNonNull",
                  "java.util.Objects.requireNonNullElse",
                },
              },
              sources = {
                organizeImports = {
                  starThreshold = 9999,
                  staticStarThreshold = 9999,
                },
              },
            },
        }
    }
    require("jdtls").start_or_attach(config)
end

vim.api.nvim_create_autocmd("FileType", {
    pattern = "java",
    callback = function()
        start_jdtls()
    end,
})
