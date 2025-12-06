{ pkgs, lib, ... }:
{
  config = {
    plugins.lsp.enable = true;
	
	# === LSP SERVERS ===
    plugins.lsp.servers = {
      # Lua (para editar Neovim configs e Lua em geral)
      lua_ls = {
        enable = true;
        package = pkgs.lua-language-server;
        settings = {
          Lua = {
            runtime = { version = "LuaJIT"; };
            diagnostics = { globals = [ "vim" ]; };
            workspace = { checkThirdParty = false; };
            telemetry = { enable = false; };
          };
        };
      };

      # TypeScript / JavaScript
      ts_ls = {
        enable = true;
        package = pkgs.typescript-language-server;
        filetypes = [ "typescript" "typescriptreact" "javascript" "javascriptreact" "vue" ];
        rootMarkers = [ "package.json" "tsconfig.json" "jsconfig.json" ".git" ];
      };

      # Vue 
      vue_ls = {
        enable = true;
        package = pkgs.vue-language-server;
        filetypes = [ "vue" ];
        settings = {
          typescript = { tsdk = "node_modules/typescript/lib"; };
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
              
              -- Função para encontrar JARs
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
              importOrder = [ "java" "javax" "com" "org" ];
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
        "gD" = {
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
        "C-s" = {
          action = "signature_help";
          desc = "signature help";
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
        snippet.expand = "function(args) require('luasnip').lsp_expand(args.body) end";
        mapping = {
          "<C-n>" = "cmp.mapping.select_next_item()";
          "<C-p>" = "cmp.mapping.select_prev_item()";
          "<C-d>" = "cmp.mapping.scroll_docs(-4)";
          "<C-f>" = "cmp.mapping.scroll_docs(4)";
          "<C-Space>" = "cmp.mapping.complete()";
          "<C-e>" = "cmp.mapping.abort()";
          "<CR>" = "cmp.mapping.confirm({ select = true })";
          "<Tab>" = "cmp.mapping(function(fallback) if cmp.visible() then cmp.select_next_item() elseif require('luasnip').expand_or_jumpable() then require('luasnip').expand_or_jump() else fallback() end end, {'i', 's'})";
          "<S-Tab>" = "cmp.mapping(function(fallback) if cmp.visible() then cmp.select_prev_item() elseif require('luasnip').jumpable(-1) then require('luasnip').jump(-1) else fallback() end end, {'i', 's'})";
        };
        sources = [
          { name = "nvim_lsp"; }
          { name = "luasnip"; }
          { name = "path"; }
          { name = "buffer"; }
        ];
      };
    };

    plugins.cmp-nvim-lsp.enable = true;
    plugins.cmp-buffer.enable = true;
    plugins.cmp-path.enable = true;
    plugins.luasnip.enable = true;
    plugins.cmp_luasnip.enable = true;
    plugins.friendly-snippets.enable = true;

    extraPlugins = with pkgs.vimPlugins; [
      kanagawa-nvim
      neo-tree-nvim
      nvim-web-devicons
      lualine-nvim
      nvim-autopairs
      telescope-nvim
      nvim-treesitter
      plenary-nvim
      nui-nvim
    ];
    # === Kanagawa Colorscheme ===
    colorschemes.kanagawa.enable = true;
    colorschemes.kanagawa.settings = {
      theme = "wave";
      background = { dark = "wave"; light = "lotus"; };
      transparent = true;                          
      commentStyle = { italic = true; };
      keywordStyle = { italic = true; };
      statementStyle = { bold = true; };
      undercurl = true;
      terminalColors = true;
    };

	globals = {
      mapleader = " ";
      maplocalleader = "\\";
    };

	keymaps = [
      {
        mode = "n";
        key = "<leader>e";
        action = "<cmd>Neotree toggle<cr>";
        options = { desc = "Toggle Neo-tree"; silent = true; };
      }
	  { mode = "n"; key = "<C-h>"; action = "<C-w>h"; options = { desc = "Window left"; silent = true; }; }
      { mode = "n"; key = "<C-j>"; action = "<C-w>j"; options = { desc = "Window down"; silent = true; }; }
      { mode = "n"; key = "<C-k>"; action = "<C-w>k"; options = { desc = "Window up"; silent = true; }; }
      { mode = "n"; key = "<C-l>"; action = "<C-w>l"; options = { desc = "Window right"; silent = true; }; }

      # Scroll centering
      { mode = "n"; key = "<C-d>"; action = "<C-d>zz"; options = { desc = "Scroll half page down and center"; silent = true; }; }
      { mode = "n"; key = "<C-u>"; action = "<C-u>zz"; options = { desc = "Scroll half page up and center"; silent = true; }; }

      # Save all buffers
      { mode = "n"; key = "<leader>w"; action = ":wa<CR>"; options = { desc = "Save all buffers"; silent = true; }; }
      
      # LSP management keymaps
      { mode = "n"; key = "<leader>ls"; action = "<CMD>LspStart<CR>"; options = { desc = "Start LSP"; silent = true; }; }
      { mode = "n"; key = "<leader>lr"; action = "<CMD>LspRestart<CR>"; options = { desc = "Restart LSP"; silent = true; }; }
      { mode = "n"; key = "<leader>lx"; action = "<CMD>LspStop<CR>"; options = { desc = "Stop LSP"; silent = true; }; }
      
	  # Diagnostics
      { mode = "n"; key = "<leader>xx"; action = "<CMD>Telescope diagnostics<CR>"; options = { desc = "Show all diagnostics"; silent = true; }; }
      { mode = "n"; key = "<leader>xb"; action = "<CMD>Telescope diagnostics bufnr=0<CR>"; options = { desc = "Buffer diagnostics"; silent = true; }; } 
	  {
        mode = "n";
        key = "<leader>fd";
        action = lib.nixvim.mkRaw "require('telescope.builtin').lsp_definitions";
        options = { desc = "Find definitions (Telescope)"; silent = true; };
      }
      { mode = "n"; key = "<leader>ff"; action = "<cmd>Telescope find_files<cr>"; options.desc = "Find files"; }
      { mode = "n"; key = "<leader>fg"; action = "<cmd>Telescope live_grep<cr>"; options.desc = "Live grep"; }
       
      { mode = "n"; key = "<leader>q"; action = "<cmd>bd<cr>"; options.desc = "Close buffer"; }
      { mode = "n"; key = "<Tab>"; action = ":bnext<CR>"; options = { desc = "Next buffer"; silent = true; }; }
      { mode = "n"; key = "<S-Tab>"; action = ":bprevious<CR>"; options = { desc = "Previous buffer"; silent = true; }; }
    ];

	plugins.lualine.enable = true;
    plugins.lualine.settings = {
      options = {
        section_separators = "";
        component_separators = "";
        globalstatus = true;
        disabled_filetypes = [ "neo-tree" "neo-tree-popup" "notify" ];
        icons_enabled = true;
      };
      sections = {
        lualine_a = [ "mode" ];
        lualine_b = [ "branch" ];
        lualine_c = [ "filename" "diff" ];
        lualine_x = [
          "diagnostics"
          {
            __raw = ''
              function()
                local msg = ""
                local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
                local clients = vim.lsp.get_clients()
                if next(clients) == nil then return msg end
                for _, client in ipairs(clients) do
                  local filetypes = client.config.filetypes
                  if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                    return client.name
                  end
                end
                return msg
              end
            '';
            color = { fg = "#ffffff"; };
            icon = "";
          }
          "encoding"
          "filetype"
        ];
        lualine_y = [];
        lualine_z = [ "location" ];
      };
      inactive_sections = {
        lualine_a = [];
        lualine_b = [ "branch" ];
        lualine_c = [ "filename" ];
        lualine_x = [ "location" ];
        lualine_y = [];
        lualine_z = [];
      };
    };

	# === Treesitter ===
    plugins.treesitter = {
      enable = true;
      nixGrammars = true;
      nixvimInjections = true;
      settings = {
        auto_install = false;
        sync_install = false;
		parser_install_dir = "/home/skylark/.local/share/nvim/treesitter";
        ensure_installed = [ "lua" "python" "javascript" "typescript" "html" "css" "markdown" "java" "nix" "c" "rust" ];
        highlight = { enable = true; };
        indent = { enable = true; };
      };
    };

    extraConfigLua = ''

	  -- Configurar diagnósticos
      vim.diagnostic.config({
        virtual_text = {
          prefix = '●',
          spacing = 4,
        },
        signs = {
            text = {
                [vim.diagnostic.severity.ERROR] = " ",
                [vim.diagnostic.severity.WARN] = " ",
                [vim.diagnostic.severity.HINT] = "󰌵",
                [vim.diagnostic.severity.INFO] = "",
              },
        },
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      })

      vim.api.nvim_create_autocmd({"InsertLeave", "TextChanged"}, {
        pattern = "*",
        callback = function()
          if vim.bo.modified and not vim.bo.readonly and vim.fn.expand("%") ~= "" and vim.bo.buftype == "" then
            vim.cmd("silent! write")
          end
        end,
      })
	
      -- Neo-tree setup
      require("neo-tree").setup({
        close_if_last_window = true,
        enable_git_status = true,
        enable_diagnostics = true,
        sort_case_insensitive = true,
        default_component_configs = {
          icon = {
            folder_closed = "",
            folder_open = "",
            folder_empty = "ﰊ",
          },
          git_status = {
            symbols = { added = "+", modified = "~", deleted = "x" },
          },
        },
        window = {
          position = "right",
          width = 35,
          mappings = {
            ["o"] = "open",
            ["<CR>"] = "open",
            ["s"] = "split_with_window_picker",
            ["v"] = "vsplit_with_window_picker",
            ["t"] = "open_tabnew",
            ["h"] = "close_node",
            ["l"] = "open",
            ["R"] = "refresh",
            ["a"] = "add",
            ["d"] = "delete",
            ["r"] = "rename",
          },
        },
        filesystem = {
          filtered_items = {
            visible = true,
            hide_dotfiles = false,
            hide_gitignored = false,
          },
        },
      })

	  -- LuaSnip setup
      require("luasnip.loaders.from_vscode").lazy_load()
      
	  -- Highlight on yank
      vim.api.nvim_create_autocmd('TextYankPost', {
        desc = 'Highlight when yanking text',
        group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
        callback = function() vim.hl.on_yank() end,
      })

	  -- Nvim-autopairs setup
      require("nvim-autopairs").setup()

	  -- Integrar autopairs com cmp
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local cmp = require('cmp')
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

	  -- Telescope setup
      local telescope = require('telescope')
      telescope.setup({
        defaults = {
          prompt_prefix = " ",
          selection_caret = "➤ ",
          sorting_strategy = "ascending",
          layout_strategy = "flex",
          layout_config = { width = 0.8, preview_cutoff = 120 },
        },
      })


    '';
    # === Editor options ===
    opts = {
      linespace = 4;
      scrolloff = 8;
      sidescrolloff = 8;
      clipboard = "unnamedplus";

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
