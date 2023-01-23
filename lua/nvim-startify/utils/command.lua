local _2afile_2a = "fnl/nvim-startify/utils/command.fnl"
local _2amodule_name_2a = "nvim-startify.utils.command"
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
local session_load, session_write, _ = autoload("nvim-startify.utils.session.loader"), autoload("nvim-startify.utils.session.write"), nil
_2amodule_locals_2a["session-load"] = session_load
_2amodule_locals_2a["session-write"] = session_write
_2amodule_locals_2a["_"] = _
local function completion_sload()
  return {}
end
_2amodule_2a["completion-sload"] = completion_sload
local function completion_ssave()
  return {}
end
_2amodule_2a["completion-ssave"] = completion_ssave
local function completion_sdelete()
  return {}
end
_2amodule_2a["completion-sdelete"] = completion_sdelete
local function init()
  local function _1_(args)
    return session_load.init(args.bang, args.fargs)
  end
  vim.api.nvim_create_user_command("SLoad", _1_, {nargs = "?", bang = true, bar = true, complete = completion_sload})
  local function _2_(args)
    return session_write.save(args.bang, args.fargs)
  end
  vim.api.nvim_create_user_command("SSave", _2_, {nargs = "?", bang = true, bar = true, complete = completion_ssave})
  local function _3_(args)
    return __fnl_global__session_2ddelete.init(args.bang, args.fargs)
  end
  return vim.api.nvim_create_user_command("SDelete", _3_, {nargs = "?", bang = true, bar = true, complete = completion_sdelete})
end
_2amodule_2a["init"] = init
return _2amodule_2a