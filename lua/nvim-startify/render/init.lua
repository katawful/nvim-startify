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
local buf, config, extmark, file, index, _, _0 = autoload("nvim-startify.utils.buffer"), autoload("nvim-startify.utils.config"), autoload("nvim-startify.utils.extmark"), autoload("nvim-startify.utils.file"), autoload("nvim-startify.utils.index"), nil, nil
_2amodule_locals_2a["buf"] = buf
_2amodule_locals_2a["config"] = config
_2amodule_locals_2a["extmark"] = extmark
_2amodule_locals_2a["file"] = file
_2amodule_locals_2a["index"] = index
_2amodule_locals_2a["_"] = _0
_2amodule_locals_2a["_"] = _0
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
    buf.start(buffer)
    return buf.unmodify(buffer)
  else
    vim.api.nvim_delete_buffer(buffer)
    do end (file.startify)[buffer] = nil
    return nil
  end
end
_2amodule_2a["init"] = init
return _2amodule_2a