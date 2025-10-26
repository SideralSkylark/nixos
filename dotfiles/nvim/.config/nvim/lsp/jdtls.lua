-- Workspace dir (um por projecto)
local workspace_dir = vim.fn.stdpath("cache") .. "/jdtls-workspace/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

-- Garantir que workspace existe
vim.fn.mkdir(workspace_dir, "p")

-- Função genérica para encontrar JARs
local function find_jar(artifact_id, group_path)
  local possible_paths = {
    -- Maven local repository
    vim.fn.expand("~/.m2/repository/" .. (group_path or "")),
    -- Gradle cache
    vim.fn.expand("~/.gradle/caches/modules-2/files-2.1/" .. (group_path or "")),
    -- Sistema (NixOS, etc)
    "/usr/share/java",
    "/run/current-system/sw/share/java",
  }
  
  for _, base_path in ipairs(possible_paths) do
    if vim.fn.isdirectory(base_path) == 1 then
      local pattern = string.format("**/%s*.jar", artifact_id)
      local jars = vim.fn.globpath(base_path, pattern, true, true)
      if #jars > 0 then
        -- Retorna o JAR mais recente (último alfabeticamente geralmente é mais novo)
        table.sort(jars)
        return jars[#jars]
      end
    end
  end
  return nil
end

-- Encontrar JARs necessários
local lombok_jar = find_jar("lombok", "org/projectlombok/lombok")

-- Lista de JARs para adicionar como javaagent (processamento em compile-time)
local javaagents = {}
if lombok_jar then
  table.insert(javaagents, lombok_jar)
end

-- Adicionar outros javaagents aqui se necessário
-- Exemplo: MapStruct, QueryDSL, etc
-- local mapstruct_jar = find_jar("mapstruct-processor", "org/mapstruct/mapstruct-processor")
-- if mapstruct_jar then
--   table.insert(javaagents, mapstruct_jar)
-- end

-- Construir argumentos JVM
local jvm_args = {}
for _, jar in ipairs(javaagents) do
  table.insert(jvm_args, "--jvm-arg=-javaagent:" .. jar)
end

-- Comando base
local cmd = { "jdtls", "-data", workspace_dir }

-- Adicionar javaagents
for _, arg in ipairs(jvm_args) do
  table.insert(cmd, arg)
end

return {
  cmd = cmd,
  root_markers = {
    ".git",
    "mvnw",
    "gradlew",
    "pom.xml",
    "build.gradle",
    "settings.gradle",
  },
  filetypes = { "java" },
  settings = {
    java = {
      eclipse = {
        downloadSources = true,
      },
      configuration = {
        updateBuildConfiguration = "interactive",
      },
      maven = {
        downloadSources = true,
      },
      implementationsCodeLens = {
        enabled = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      references = {
        includeDecompiledSources = true,
      },
      format = {
        enabled = true,
      },
    },
    signatureHelp = { enabled = true },
    completion = {
      favoriteStaticMembers = {
        "org.hamcrest.MatcherAssert.assertThat",
        "org.hamcrest.Matchers.*",
        "org.hamcrest.CoreMatchers.*",
        "org.junit.jupiter.api.Assertions.*",
        "java.util.Objects.requireNonNull",
        "java.util.Objects.requireNonNullElse",
        "org.mockito.Mockito.*",
      },
      importOrder = {
        "java",
        "javax",
        "com",
        "org"
      },
    },
    extendedClientCapabilities = {
      progressReportProvider = false,
    },
    sources = {
      organizeImports = {
        starThreshold = 9999,
        staticStarThreshold = 9999,
      },
    },
    codeGeneration = {
      toString = {
        template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
      },
      useBlocks = true,
    },
  },
  init_options = {
    -- Bundles são JARs que estendem funcionalidades do jdtls
    -- Exemplos: java-debug, vscode-java-test, etc
    bundles = {},
    
    -- Adicionar bundles aqui se necessário:
    -- local debug_jar = find_jar("java-debug", "com/microsoft/java")
    -- if debug_jar then
    --   table.insert(bundles, debug_jar)
    -- end
  },
}
