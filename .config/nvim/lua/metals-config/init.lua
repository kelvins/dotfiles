vim.opt_global.shortmess:remove("F")

metals_config = require("metals").bare_config()
metals_config.init_options.statusBarProvider = "on"

metals_config.settings = {
  showImplicitArguments = true,
  excludedPackages = {
    "akka.actor.typed.javadsl",
    "com.github.swagger.akka.javadsl"
  },
  ammoniteJvmProperties = {
    "-Xmx12G"
  },
}

require("metals").initialize_or_attach(metals_config)
