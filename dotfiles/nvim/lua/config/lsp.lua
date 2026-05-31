local capabilities = vim.tbl_deep_extend(
    "force",
    vim.lsp.protocol.make_client_capabilities(),
    require("blink.cmp").get_lsp_capabilities()
)

-- Find @vue/typescript-plugin bundled inside @vue/language-server
local function find_vue_ts_plugin()
    local tsserver = vim.fn.exepath("vue-language-server")
    if tsserver ~= "" then
        local prefix = vim.fn.fnamemodify(tsserver, ":h:h")
        local candidate = prefix .. "/lib/node_modules/@vue/language-server/node_modules/@vue/typescript-plugin"
        if vim.fn.isdirectory(candidate) == 1 then
            return candidate
        end
        candidate = prefix .. "/lib/node_modules/@vue/typescript-plugin"
        if vim.fn.isdirectory(candidate) == 1 then
            return candidate
        end
    end
    return nil
end

local function find_tsdk()
    local tsserver = vim.fn.exepath("typescript-language-server")
    if tsserver ~= "" then
        local prefix = vim.fn.fnamemodify(tsserver, ":h:h")
        local candidate = prefix .. "/lib/node_modules/typescript/lib"
        if vim.fn.isdirectory(candidate) == 1 then
            return candidate
        end
    end
    return vim.fn.expand("$HOME/.npm-global/lib/node_modules/typescript/lib")
end

local vue_plugin_path = find_vue_ts_plugin()

local servers = {
    lua_ls = {
        cmd       = { "lua-language-server" },
        filetypes = { "lua" },
        settings  = {
            Lua = {
                runtime     = { version = "LuaJIT" },
                diagnostics = { globals = { "vim" } },
                workspace   = { checkThirdParty = false },
                telemetry   = { enable = false },
            },
        },
    },
    ts_ls = {
        cmd          = { "typescript-language-server", "--stdio" },
        filetypes    = { "typescript", "typescriptreact", "javascript", "javascriptreact", "vue" },
        init_options = {
            plugins = vue_plugin_path and {
                {
                    name      = "@vue/typescript-plugin",
                    location  = vue_plugin_path,
                    languages = { "vue" },
                },
            } or nil,
        },
    },
    volar = {
        cmd       = { "vue-language-server", "--stdio" },
        filetypes = { "vue" },
        settings  = {
            typescript = {
                tsdk = find_tsdk(),
            },
        },
    },
    jdtls = {
        cmd          = (function()
            local workspace_dir = vim.fn.stdpath("cache") ..
                "/jdtls-workspace/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
            vim.fn.mkdir(workspace_dir, "p")

            local function find_jar(artifact_id, group_path)
                local possible_paths = {
                    vim.fn.expand("~/.m2/repository/" .. (group_path or "")),
                    vim.fn.expand("~/.gradle/caches/modules-2/files-2.1/" .. (group_path or "")),
                    "/usr/share/java",
                    "/run/current-system/sw/share/java",
                }
                for _, base_path in ipairs(possible_paths) do
                    if vim.fn.isdirectory(base_path) == 1 then
                        local pattern = string.format("**/%s*.jar", artifact_id)
                        local jars = vim.fn.globpath(base_path, pattern, true, true)
                        if #jars > 0 then
                            table.sort(jars)
                            return jars[#jars]
                        end
                    end
                end
                return nil
            end

            local lombok_jar = find_jar("lombok", "org/projectlombok/lombok")
            local cmd = { "jdtls", "-data", workspace_dir }
            if lombok_jar then
                table.insert(cmd, "--jvm-arg=-javaagent:" .. lombok_jar)
            end
            return cmd
        end)(),
        filetypes    = { "java" },
        root_markers = { "pom.xml", "build.gradle", ".git", "mvnw", "gradlew" },
        settings     = {
            java = {
                eclipse                 = { downloadSources = true },
                configuration           = { updateBuildConfiguration = "interactive" },
                maven                   = { downloadSources = true },
                implementationsCodeLens = { enabled = true },
                referencesCodeLens      = { enabled = true },
                references              = { includeDecompiledSources = true },
                format                  = { enabled = true },
                signatureHelp           = { enabled = true },
                completion              = {
                    favoriteStaticMembers = {
                        "org.hamcrest.MatcherAssert.assertThat",
                        "org.hamcrest.Matchers.*",
                        "org.hamcrest.CoreMatchers.*",
                        "org.junit.jupiter.api.Assertions.*",
                        "java.util.Objects.requireNonNull",
                        "java.util.Objects.requireNonNullElse",
                        "org.mockito.Mockito.*",
                    },
                    importOrder = { "java", "javax", "com", "org" },
                },
                sources                 = {
                    organizeImports = { starThreshold = 9999, staticStarThreshold = 9999 },
                },
                codeGeneration          = {
                    toString  = {
                        template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
                    },
                    useBlocks = true,
                },
            },
        },
    },
    pyright = {
        cmd       = { "pyright-langserver", "--stdio" },
        filetypes = { "python" },
    },
    clangd = {
        cmd       = { "clangd" },
        filetypes = { "c", "cpp", "objc", "objcpp" },
    },
    nil_ls = {
        cmd       = { "nil" },
        filetypes = { "nix" },
    },
    rust_analyzer = {
        cmd       = { "rust-analyzer" },
        filetypes = { "rust" },
    },
}

for name, config in pairs(servers) do
    config.capabilities = vim.tbl_deep_extend("force", capabilities, config.capabilities or {})
    vim.lsp.config(name, config)
    vim.lsp.enable(name)
end
