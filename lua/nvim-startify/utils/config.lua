local _2afile_2a = "fnl/nvim-startify/utils/config.fnl"
local _2amodule_name_2a = "nvim-startify.utils.config"
local _2amodule_2a
do
  package.loaded[_2amodule_name_2a] = {}
  _2amodule_2a = package.loaded[_2amodule_name_2a]
end
local _2amodule_locals_2a
do
  _2amodule_2a["aniseed/locals"] = {}
  _2amodule_locals_2a = (_2amodule_2a)["aniseed/locals"]
end
local autoload = (require("nvim-startify.aniseed.autoload")).autoload
local fortune, _, _0 = autoload("nvim-startify.fortune.init"), nil, nil
_2amodule_locals_2a["fortune"] = fortune
_2amodule_locals_2a["_"] = _0
_2amodule_locals_2a["_"] = _0
local function handle_vim_var(var_name, scope, truthy, falsy)
  if (vim[scope][var_name] == 0) then
    return falsy
  elseif (vim[scope][var_name] > 0) then
    return truthy
  else
    return nil
  end
end
_2amodule_2a["handle-vim-var"] = handle_vim_var
local value = {["relative-path"] = ":~:.", ["absolute-path"] = ":p:~"}
_2amodule_2a["value"] = value
local default
local function _2_(...)
  return vim.g.startify_transformations
end
local function _3_(...)
  return vim.g.startify_bookmarks
end
local function _4_(...)
  return vim.g.startify_lists
end
local function _5_(...)
  return vim.g.startify_commands
end
local function _6_(...)
  return vim.g.startify_custom_indices
end
local _7_
if vim.g.startify_custom_header then
  vim.notify("vim.g.startify_custom_header must be converted manually\nDefaulting to an empty value", vim.log.levels.WARN)
  _7_ = {""}
else
  _7_ = fortune.init()
end
local function _9_(...)
  return vim.g.startify_custom_header_quotes
end
local function _10_(...)
  return vim.g.startify_custom_footer
end
local function _11_(...)
  return vim.g.startify_session_dir
end
local _12_
if vim.g.startify_session_autoload then
  _12_ = handle_vim_var("startify_session_autoload", "g", true, false)
else
  _12_ = false
end
local function _14_(...)
  return vim.g.startify_session_remove_lines
end
local function _15_(...)
  return vim.g.startify_session_savevars
end
local function _16_(...)
  return vim.g.startify_session_savecmds
end
local function _17_(...)
  return vim.g.startify_session_number
end
local _18_
if vim.g.startify_session_persistence then
  _18_ = handle_vim_var("startify_session_persistence", "g", true, false)
else
  _18_ = false
end
local _20_
if vim.g.startify_session_sort then
  _20_ = handle_vim_var("startify_session_sort", "g", true, false)
else
  _20_ = false
end
local function _22_(...)
  return vim.g.startify_session_before_save
end
local _23_
if vim.g.startify_session_delete_buffers then
  _23_ = handle_vim_var("startify_session_delete_buffers", "g", true, false)
else
  _23_ = true
end
local _25_
if vim.g.startify_use_env then
  _25_ = handle_vim_var("startify_use_env", true, false)
else
  _25_ = false
end
local function _27_(...)
  return vim.g.startify_skiplist_server
end
local _28_
if vim.g.startify_relative_path then
  _28_ = handle_vim_var("startify_relative_path", "g", value["relative-path"], value["absolute-path"])
else
  _28_ = value["relative-path"]
end
local _30_
if vim.g.startify_change_to_dir then
  _30_ = handle_vim_var("startify_change_to_dir", "g", true, false)
else
  _30_ = true
end
local _32_
if vim.g.startify_change_to_vcs_dir then
  _32_ = handle_vim_var("startify_change_to_vcs_dir", "g", true, false)
else
  _32_ = false
end
local function _34_(...)
  return vim.g.startify_change_cmd
end
local _35_
if vim.g.startify_fortune_use_unicode then
  _35_ = handle_vim_var("startify_fortune_use_unicode", "g", true, false)
else
  _35_ = false
end
local _37_
do
  local list
  local function _38_(...)
    return vim.g.startify_skiplist
  end
  list = (_38_(...) or {})
  table.insert(list, "runtime/doc/.*\\.txt$")
  table.insert(list, "bundle/.*/doc/.*\\.txt$")
  table.insert(list, "plugged/.*/doc/.*\\.txt$")
  table.insert(list, "/\\.git/")
  table.insert(list, "fugitiveblame$")
  table.insert(list, (vim.fn.escape(vim.fn.fnamemodify(vim.fn.resolve(vim.fn.getenv("VIMRUNTIME")), ":p"), "\\") .. "doc/.*\\.txt$"))
  _37_ = list
end
local function _39_(...)
  return vim.g.startify_files_number
end
local _40_
if vim.g.startify_enable_special then
  _40_ = handle_vim_var("startify_relative_path", "g", true, false)
else
  _40_ = true
end
local _42_
if vim.g.startify_disable_at_vimenter then
  _42_ = handle_vim_var("startify_disable_at_vimenter", false, true)
else
  _42_ = true
end
local _44_
if vim.g.startify_update_old_files then
  _44_ = handle_vim_var("startify_update_old_files", "g", true, false)
else
  _44_ = false
end
local function _46_(...)
  return vim.g.startify_padding_left
end
default = {transformations = (_2_(...) or {}), bookmarks = (_3_(...) or {}), ["display-lists"] = (_4_(...) or {{type = "files", header = "   MRU"}, {type = "dir", header = ("   MRU " .. vim.fn.getcwd())}, {type = "sessions", header = "   Sessions"}, {type = "bookmarks", header = "   Bookmarks"}, {type = "commands", header = "   Commands"}}), commands = (_5_(...) or {}), ["custom-index"] = (_6_(...) or {}), ["custom-header"] = _7_, ["custom-header-quote"] = (_9_(...) or {}), ["custom-footer"] = (_10_(...) or ""), session = {dir = (_11_(...) or (vim.fn.stdpath("data") .. "/session")), autoload = _12_, ["remove-lines"] = (_14_(...) or {}), ["save-vars"] = (_15_(...) or {}), ["save-cmds"] = (_16_(...) or {}), number = (_17_(...) or 999), persistence = _18_, ["sort-time"] = _20_, ["pre-commands"] = (_22_(...) or {}), ["del-buf-on-session"] = _23_}, settings = {["show-env"] = _25_, ["server-skiplist"] = (_27_(...) or {}), ["use-relative-path"] = _28_, ["change-to-dir"] = _30_, ["change-to-vcs-root"] = _32_, ["chdir-cmd"] = (_34_(...) or "lcd"), ["fortune-unicode"] = _35_, skiplist = _37_, ["list-number"] = (_39_(...) or 10), ["show-special"] = _40_, ["on-vimenter"] = _42_, ["update-old-files"] = _44_}, format = {["top-padding"] = 1, alignment = "center", ["left-padding"] = (_46_(...) or 3), width = 80}, ["render-order"] = {"header", "special", "lists", "footer"}}
_2amodule_2a["default"] = default
local opts = {}
_2amodule_2a["opts"] = opts
_G.startify_value = function(value0, _3fnest)
  if _3fnest then
    return (opts[_3fnest])[value0]
  else
    return opts[value0]
  end
end
local function hotload(config)
  if config then
    local out = vim.tbl_deep_extend("force", default, config)
    for k, v in pairs(out) do
      opts[k] = v
    end
    return nil
  else
    for k, v in pairs(default) do
      opts[k] = v
    end
    return nil
  end
end
_2amodule_2a["hotload"] = hotload
local function server_skipped_3f()
  local found_3f = {}
  for _1, server in ipairs(opts.settings["server-skiplist"]) do
    if (#found_3f > 0) then break end
    if (server == vim.v.servername) then
      table.insert(found_3f, true)
    else
    end
  end
  if (#found_3f > 0) then
    return true
  else
    return false
  end
end
_2amodule_2a["server-skipped?"] = server_skipped_3f
return _2amodule_2a