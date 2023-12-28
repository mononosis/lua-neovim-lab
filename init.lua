local utils = require("nvim-utils-config")
-- Function to get the directory of the current script

-- Get the current directory of the script
local current_dir = utils.this_file_path()
utils.set_packages_paths(current_dir)

require('lua-theme').setup()
require('lua-options').setup()
require('lua-editor').setup()
