{ pkgs, lib, ... }:
{
  plugins.lsp = {
    enable = true;

    servers = {
      lua_ls = {
        enable = true;
        package = pkgs.lua-language-server;
        settings.Lua = {
          runtime.version = "LuaJIT";
          diagnostics.globals = [ "vim" ];
          workspace.checkThirdParty = false;
          telemetry.enable = false;
        };
      };

      vtsls = {
        enable = true;
        package = pkgs.vtsls;
        filetypes = [
          "typescript"
          "typescriptreact"
          "javascript"
          "javascriptreact"
          "vue"
        ];
        settings.vtsls.tsserver.globalPlugins = [
          {
            name = "@vue/typescript-plugin";
            location = "${pkgs.vue-language-server}/lib/node_modules/@vue/language-server";
            languages = [ "vue" ];
            configNamespace = "typescript";
            enableForWorkspaceTypeScriptVersions = true;
          }
        ];
      };

      vue_ls = {
        enable = true;
        package = pkgs.vue-language-server;
        filetypes = [ "vue" ];
        settings.typescript.tsdk = "${pkgs.typescript}/lib/node_modules/typescript/lib";
      };

      svelte = {
        enable = true;
        package = pkgs.svelte-language-server;
      };
      pyright = {
        enable = true;
        package = pkgs.pyright;
      };
      clangd = {
        enable = true;
        package = pkgs.clang-tools;
      };
      nil_ls = {
        enable = true;
        package = pkgs.nil;
      };

      rust_analyzer = {
        enable = true;
        package = pkgs.rust-analyzer;
        installCargo = false;
        installRustc = false;
        settings.check.command = "clippy";
      };

      jdtls = {
        enable = true;
        package = pkgs.jdt-language-server;
        extraOptions.cmd = lib.nixvim.mkRaw ''
          function(dispatchers, config)
            local root = config.root_dir or vim.uv.cwd()
            local ws = vim.fn.stdpath("cache") .. "/jdtls/"
              .. vim.fn.fnamemodify(root, ":t") .. "-" .. vim.fn.sha256(root):sub(1, 8)
            return vim.lsp.rpc.start({
              "jdtls", "-data", ws,
              "--jvm-arg=-javaagent:${pkgs.lombok}/share/java/lombok.jar",
            }, dispatchers, { cwd = root })
          end
        '';
        settings.java = {
          eclipse.downloadSources = true;
          configuration.updateBuildConfiguration = "automatic";
          maven.downloadSources = true;
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

    # Everything else (grn/gra/grr/gri/grt/gO/K/]d/[d) is built into 0.12
    keymaps = {
      diagnostic."gl" = {
        action = "open_float";
        desc = "Line diagnostics";
      };
      lspBuf."gd" = {
        action = "definition";
        desc = "Go to definition";
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
