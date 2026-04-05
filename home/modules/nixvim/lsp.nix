{ pkgs, lib, ... }:
{
  plugins.lsp = {
    enable = true;

    # === LSP SERVERS ===
    servers = {
      lua_ls = {
        enable = true;
        package = pkgs.lua-language-server;
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT";
            };
            diagnostics = {
              globals = [ "vim" ];
            };
            workspace = {
              checkThirdParty = false;
            };
            telemetry = {
              enable = false;
            };
          };
        };
      };

      # TypeScript / JavaScript
      ts_ls = {
        enable = true;
        package = pkgs.typescript-language-server;
        filetypes = [
          "typescript"
          "typescriptreact"
          "javascript"
          "javascriptreact"
          "vue"
        ];
        rootMarkers = [
          "package.json"
          "tsconfig.json"
          "jsconfig.json"
          ".git"
        ];
      };

      # Vue
      vue_ls = {
        enable = true;
        package = pkgs.vue-language-server;
        filetypes = [ "vue" ];
        settings = {
          typescript = {
            tsdk = "node_modules/typescript/lib";
          };
        };
      };

      # Python
      pyright = {
        enable = true;
        package = pkgs.pyright;
      };

      # C/C++
      clangd = {
        enable = true;
        package = pkgs.clang-tools;
      };

      # Java
      jdtls = {
        enable = true;
        package = pkgs.jdt-language-server;
        extraOptions = {
          cmd = lib.nixvim.mkRaw ''
            (function()
              local workspace_dir = vim.fn.stdpath("cache") .. "/jdtls-workspace/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
              vim.fn.mkdir(workspace_dir, "p")
              
              -- Find Jars
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
            end)()
          '';
        };
        settings = {
          java = {
            eclipse.downloadSources = true;
            configuration.updateBuildConfiguration = "interactive";
            maven.downloadSources = true;
            implementationsCodeLens.enabled = true;
            referencesCodeLens.enabled = true;
            references.includeDecompiledSources = true;
            format.enabled = true;
            signatureHelp.enabled = true;
            completion = {
              favoriteStaticMembers = [
                "org.hamcrest.MatcherAssert.assertThat"
                "org.hamcrest.Matchers.*"
                "org.hamcrest.CoreMatchers.*"
                "org.junit.jupiter.api.Assertions.*"
                "java.util.Objects.requireNonNull"
                "java.util.Objects.requireNonNullElse"
                "org.mockito.Mockito.*"
              ];
              importOrder = [
                "java"
                "javax"
                "com"
                "org"
              ];
            };
            sources.organizeImports = {
              starThreshold = 9999;
              staticStarThreshold = 9999;
            };
            codeGeneration = {
              toString.template = "\${object.className}{\${member.name()}=\${member.value}, \${otherMembers}}";
              useBlocks = true;
            };
          };
        };
      };

      # Nix
      nil_ls = {
        enable = true;
        package = pkgs.nil;
      };

      # Rust
      rust_analyzer = {
        enable = true;
        package = pkgs.rust-analyzer;
        installCargo = false;
        installRustc = false;
      };
    };

    # === LSP KEYMAPS ===
    keymaps = {
      diagnostic = {
        "[d" = {
          action = "goto_prev";
          desc = "Prev diagnostic";
        };
        "]d" = {
          action = "goto_next";
          desc = "Next diagnostic";
        };
        "gl" = {
          action = "open_float";
          desc = "Show line diagnostics";
        };
      };
      lspBuf = {
        "gd" = {
          action = "definition";
          desc = "Go to definition";
        };
        "gr" = {
          action = "references";
          desc = "Show references";
        };
        "gi" = {
          action = "implementation";
          desc = "Go to implementation";
        };
        "gt" = {
          action = "type_definition";
          desc = "Type definition";
        };
        "K" = {
          action = "hover";
          desc = "Hover docs";
        };
        "<leader>rn" = {
          action = "rename";
          desc = "Rename symbol";
        };
        "<leader>ca" = {
          action = "code_action";
          desc = "Code actions";
        };
        "<leader>f" = {
          action = "format";
          desc = "Format buffer";
        };
      };
    };
  };

  diagnostic.settings = {
    virtual_text = false;
    signs = true;
    underline = true;
    update_in_insert = false;
    severity_sort = true;
  };
}
