{ pkgs, lib, ... }:
{
  config = {
    plugins.lsp.enable = true;

    # === LSP SERVERS ===
    plugins.lsp.servers = {
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

    diagnostic.settings = {
      virtual_text = false;
      signs = true;
      underline = true;
      update_in_insert = false;
      severity_sort = true;
    };

    # === LSP KEYMAPS ===
    plugins.lsp.keymaps = {
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

    # === AUTOCOMPLETION ===
    plugins.cmp = {
      enable = true;
      settings = {
        mapping = {
          "<C-n>" = "cmp.mapping.select_next_item()";
          "<C-p>" = "cmp.mapping.select_prev_item()";
          "<C-Space>" = "cmp.mapping.complete()";
          "<CR>" = "cmp.mapping.confirm({ select = true })";
        };
        sources = [
          { name = "nvim_lsp"; }
          { name = "path"; }
          { name = "buffer"; }
        ];
      };
    };

    plugins.cmp-nvim-lsp.enable = true;
    plugins.cmp-buffer.enable = true;
    plugins.cmp-path.enable = true;

    extraPlugins = with pkgs.vimPlugins; [
      kanagawa-nvim
    ];

    plugins.web-devicons.enable = true;

    # === Kanagawa Colorscheme ===
    colorschemes.kanagawa = {
      enable = true;
      settings = {
        theme = "dragon";
        background = {
          dark = "dragon";
          light = "lotus";
        };
        compile = false;
        transparent = false;
        dimInactive = false;
        commentStyle = {
          italic = true;
        };
        keywordStyle = {
          italic = false;
        };
        statementStyle = {
          bold = false;
        };
        functionStyle = {
          bold = false;
        };
        typeStyle = {
          bold = false;
        };
        undercurl = true;
        terminalColors = true;
        colors = {
          palette = {
            lotusWhite0 = "#ffffff";
            lotusWhite1 = "#f7f7f7";
            lotusWhite2 = "#eeeeee";
          };
          theme = {
            all = {
              ui = {
                bg_gutter = "none";
              };
            };
            lotus = {
              ui = {
                bg = "#ffffff"; # true white background
                bg_dim = "#f7f7f7"; # subtle inactive background
                bg_p1 = "#eeeeee";
                bg_p2 = "#e6e6e6";
              };
              syn = {
                comment = "#6f6f6f"; # neutral gray comments
              };
            };
            dragon = {
              ui = {
                bg = "#0f0f14"; # slightly calmer than default
              };
            };
          };
        };
      };
    };

    globals = {
      mapleader = " ";
      maplocalleader = "\\";
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>e";
        action = "<cmd>lua MiniFiles.open()<CR>";
        options = {
          desc = "Open file explorer";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<C-h>";
        action = "<C-w>h";
        options = {
          desc = "Window left";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<C-j>";
        action = "<C-w>j";
        options = {
          desc = "Window down";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<C-k>";
        action = "<C-w>k";
        options = {
          desc = "Window up";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<C-l>";
        action = "<C-w>l";
        options = {
          desc = "Window right";
          silent = true;
        };
      }
      # Scroll centering
      {
        mode = "n";
        key = "<C-d>";
        action = "<C-d>zz";
        options = {
          desc = "Scroll half page down and center";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<C-u>";
        action = "<C-u>zz";
        options = {
          desc = "Scroll half page up and center";
          silent = true;
        };
      }
      # Diagnostics
      {
        mode = "n";
        key = "<leader>xx";
        action = "<CMD>Telescope diagnostics<CR>";
        options = {
          desc = "Show all diagnostics";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>ff";
        action = "<cmd>Telescope find_files<cr>";
        options.desc = "Find files";
      }
      {
        mode = "n";
        key = "<leader>fg";
        action = "<cmd>Telescope live_grep<cr>";
        options.desc = "Live grep";
      }
      {
        mode = "n";
        key = "<leader>q";
        action = "<cmd>bd<cr>";
        options.desc = "Close buffer";
      }
    ];

    plugins.lualine = {
      enable = true;
      settings = {
        options = {
          section_separators = "";
          component_separators = "";
          globalstatus = true;
          disabled_filetypes = [
            "minifiles"
          ];
          icons_enabled = true;
        };
        sections = {
          lualine_a = [ "mode" ];
          lualine_b = [ "branch" ];
          lualine_c = [
            "filename"
            "diff"
          ];
          lualine_x = [
            "diagnostics"
            "filetype"
          ];
          lualine_y = [ ];
          lualine_z = [ "location" ];
        };
        inactive_sections = {
          lualine_a = [ ];
          lualine_b = [ "branch" ];
          lualine_c = [ "filename" ];
          lualine_x = [ "location" ];
          lualine_y = [ ];
          lualine_z = [ ];
        };
      };
    };

    # === Treesitter ===
    plugins.treesitter = {
      enable = true;
      nixGrammars = true;
      nixvimInjections = true;
      settings = {
        ensure_installed = [
          "lua"
          "python"
          "javascript"
          "typescript"
          "html"
          "css"
          "markdown"
          "java"
          "nix"
          "c"
          "rust"
        ];
        highlight = {
          enable = true;
        };
        indent = {
          enable = true;
        };
      };
    };

    extraConfigLua = ''
      vim.api.nvim_create_autocmd({"InsertLeave", "FocusLost"}, {
        callback = function()
          if
            vim.bo.modified
            and not vim.bo.readonly
            and vim.bo.buftype == ""
            and vim.bo.filetype ~= ""
            and vim.fn.expand("%") ~= ""
          then
            vim.cmd("silent! write")
          end
        end,
      })
                  	
      -- Highlight on yank
      vim.api.nvim_create_autocmd('TextYankPost', {
        desc = 'Highlight when yanking text',
        group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
        callback = function() vim.hl.on_yank() end,
      })
    '';

    plugins.mini-files = {
      enable = true;
      autoLoad = true;

      settings = {
        options = {
          use_as_default_explorer = true;
          permanent_delete = true;
        };

        windows = {
          preview = false;
          width_focus = 40;
          width_nofocus = 20;
        };

        mappings = {
          close = "q";
          go_in = "l";
          go_out = "h";
          reset = "<BS>";
          show_help = "g?";
        };
      };
    };

    plugins.nvim-autopairs = {
      enable = true;
      settings = {
        disable_filetype = [ "TelescopePrompt" ];
        map_cr = true;
      };
    };

    plugins.telescope = {
      enable = true;
      settings = {
        defaults = {
          sorting_strategy = "ascending";
          layout_strategy = "flex";
          layout_config = {
            width = 0.85;
            height = 0.85;
            preview_cutoff = 120;
          };
        };
      };
    };

    # === Editor options ===
    opts = {
      scrolloff = 8;
      sidescrolloff = 8;
      clipboard = "unnamedplus";
      showmode = false;
      number = true;
      relativenumber = true;
      signcolumn = "yes";
      tabstop = 4;
      softtabstop = 4;
      shiftwidth = 4;
      expandtab = true;
      updatetime = 300;
      termguicolors = true;
      wrap = false;
    };
  };
}
