local home = os.getenv("HOME")
local capabilities = require("cmp_nvim_lsp").default_capabilities()
-- figure out the workspace name
local root_markers = {"gradlew", "mvnw", ".git", ".processing", "pom.xml"}
local root_dir = require("jdtls.setup").find_root(root_markers)
local workspace_dir = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

local bundles = {
    vim.fn.glob(home .. "/.local/java/java-lsp/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar", true)
}

for _, bundle in ipairs(vim.split(vim.fn.glob(home .. "/.local/java/java-lsp/vscode-java-test/server/*.jar"), '\n')) do
    table.insert(bundles, bundle)
end

local opts = {
    capabilites = capabilities,
    cmd = {
        "/usr/bin/java",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-Xmx1g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens", "java.base/java.util=ALL-UNNAMED",
        "--add-opens", "java.base/java.lang=ALL-UNNAMED",
        "-jar", home .. "/.local/java/java-lsp/plugins/org.eclipse.equinox.launcher_1.6.600.v20231012-1237.jar",
        "-configuration", home .. "/.local/java/java-lsp/config_linux",
        "-data", workspace_dir,
    },
    root_dir = root_dir,
}
opts["init_options"] = {
    bundles = bundles
}

require("jdtls").start_or_attach(opts)

vim.keymap.set("n", "<space>tm", require("jdtls").test_nearest_method, nil)
vim.keymap.set("n", "<space>tc", require("jdtls").test_class, nil)
