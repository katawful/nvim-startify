local _2afile_2a = "fnl/nvim-startify/render/init.fnl"
local _2amodule_name_2a = "nvim-startify.render.init"
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
local a, buf, config, extmark, file, fortune, high, iter, loader, _, _0 = autoload("nvim-startify.aniseed.core"), autoload("nvim-startify.utils.buffer"), autoload("nvim-startify.utils.config"), autoload("nvim-startify.utils.extmark"), autoload("nvim-startify.utils.file"), autoload("nvim-startify.fortune.init"), autoload("nvim-startify.utils.highlight"), autoload("nvim-startify.render.iterator"), autoload("nvim-startify.session.loader"), nil, nil
_2amodule_locals_2a["a"] = a
_2amodule_locals_2a["buf"] = buf
_2amodule_locals_2a["config"] = config
_2amodule_locals_2a["extmark"] = extmark
_2amodule_locals_2a["file"] = file
_2amodule_locals_2a["fortune"] = fortune
_2amodule_locals_2a["high"] = high
_2amodule_locals_2a["iter"] = iter
_2amodule_locals_2a["loader"] = loader
_2amodule_locals_2a["_"] = _0
_2amodule_locals_2a["_"] = _0
local startify_opts = {bufhidden = "wipe", colorcolumn = "0", foldcolumn = "0", matchpairs = "", signcolumn = "no", list = false, cursorcolumn = false, cursorline = false, spell = false, buflisted = false, readonly = false, relativenumber = false, number = false, swapfile = false}
_2amodule_2a["startify-opts"] = startify_opts
local function set_options(buffer)
  for opt, val in pairs(startify_opts) do
    vim.opt_local[opt] = val
  end
  vim.api.nvim_buf_set_option(buffer, "synmaxcol", (vim.api.nvim_get_option_info("synmaxcol")).default)
  if not vim.api.nvim_win_get_option(0, "statusline") then
    vim.api.nvim_win_set_option(0, "statusline", "\\ startify")
  else
  end
  vim.bo[buffer]["filetype"] = "startify"
  return nil
end
_2amodule_2a["set-options"] = set_options
local function start_buffer(buffer)
  set_options(buffer)
  return file["insert-blankline"](buffer, 1000)
end
_2amodule_2a["start-buffer"] = start_buffer
local function unmodify(buffer)
  vim.api.nvim_buf_set_option(buffer, "modified", false)
  return vim.api.nvim_buf_set_option(buffer, "modifiable", false)
end
_2amodule_2a["unmodify"] = unmodify
local function init(on_vimenter)
  print("STARTIFY STARTED")
  if on_vimenter then
    extmark["create-namespace"]()
  else
  end
  local buffer = vim.api.nvim_create_buf(true, false)
  do end (file.startify)[buffer] = {}
  if (buf["modifiable?"](0) and not buf["visible-modified?"](0) and not config["server-skipped?"]() and buf["empty?"](0)) then
    print("STARTIFY  RUN")
    vim.api.nvim_win_set_buf(0, buffer)
    start_buffer(buffer)
    return unmodify(buffer)
  else
    vim.api.nvim_delete_buffer(buffer)
    do end (file.startify)[buffer] = nil
    return nil
  end
end
_2amodule_2a["init"] = init
return _2amodule_2a