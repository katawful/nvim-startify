local _2afile_2a = "fnl/nvim-startify/utils/highlight.fnl"
local _2amodule_name_2a = "nvim-startify.utils.highlight"
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
local groups = {header = {link = "Title", name = "StartifyHeader"}, special = {link = "Comment", name = "StartifySpecial"}, directory = {link = "Directory", name = "StartifyFile"}}
_2amodule_2a["groups"] = groups
local function group(table)
  local t_1_ = table
  if (nil ~= t_1_) then
    t_1_ = (t_1_).group
  else
  end
  return t_1_
end
_2amodule_2a["group"] = group
local function gui_fg(table)
  local t_3_ = table
  if (nil ~= t_3_) then
    t_3_ = (t_3_).fg
  else
  end
  return t_3_
end
_2amodule_2a["gui-fg"] = gui_fg
local function gui_bg(table)
  local t_5_ = table
  if (nil ~= t_5_) then
    t_5_ = (t_5_).bg
  else
  end
  return t_5_
end
_2amodule_2a["gui-bg"] = gui_bg
local function term_fg(table)
  local t_7_ = table
  if (nil ~= t_7_) then
    t_7_ = (t_7_).ctermfg
  else
  end
  return t_7_
end
_2amodule_2a["term-fg"] = term_fg
local function term_bg(table)
  local t_9_ = table
  if (nil ~= t_9_) then
    t_9_ = (t_9_).ctermbg
  else
  end
  return t_9_
end
_2amodule_2a["term-bg"] = term_bg
local function special(table)
  local t_11_ = table
  if (nil ~= t_11_) then
    t_11_ = (t_11_).sp
  else
  end
  return t_11_
end
_2amodule_2a["special"] = special
local function blend(table)
  local t_13_ = table
  if (nil ~= t_13_) then
    t_13_ = (t_13_).blend
  else
  end
  return t_13_
end
_2amodule_2a["blend"] = blend
local function link(table)
  local t_15_ = table
  if (nil ~= t_15_) then
    t_15_ = (t_15_).link
  else
  end
  return t_15_
end
_2amodule_2a["link"] = link
local function default(table)
  local t_17_ = table
  if (nil ~= t_17_) then
    t_17_ = (t_17_).default
  else
  end
  return t_17_
end
_2amodule_2a["default"] = default
local function all_attr__3etable(table_23)
  local output = {}
  for k, v in pairs(table_23) do
    if ((v == true) or (v == false)) then
      if (vim.g.kat_nvim_max_version == "0.8") then
        local _19_ = k
        if (_19_ == "underlineline") then
          output["underdouble"] = v
        elseif (_19_ == "underdot") then
          output["underdotted"] = v
        elseif (_19_ == "underdash") then
          output["underdashed"] = v
        elseif true then
          local _ = _19_
          output[k] = v
        else
        end
      else
        output[k] = v
      end
    else
    end
  end
  return output
end
_2amodule_2a["all-attr->table"] = all_attr__3etable
local function get_existing(group0)
  local gui = vim.api.nvim_get_hl_by_name(group0, true)
  local fg = utils["decimal-rgb->hex"](gui.foreground)
  local bg = utils["decimal-rgb->hex"](gui.background)
  local cterm = vim.api.nvim_get_hl_by_name(group0, false)
  local ctermfg = cterm.foreground
  local ctermbg = cterm.background
  local bold
  do
    local t_23_ = gui
    if (nil ~= t_23_) then
      t_23_ = (t_23_).bold
    else
    end
    bold = t_23_
  end
  local underline
  do
    local t_25_ = gui
    if (nil ~= t_25_) then
      t_25_ = (t_25_).underline
    else
    end
    underline = t_25_
  end
  local underlineline
  do
    local t_27_ = gui
    if (nil ~= t_27_) then
      t_27_ = (t_27_).underlineline
    else
    end
    underlineline = t_27_
  end
  local undercurl
  do
    local t_29_ = gui
    if (nil ~= t_29_) then
      t_29_ = (t_29_).undercurl
    else
    end
    undercurl = t_29_
  end
  local underdot
  do
    local t_31_ = gui
    if (nil ~= t_31_) then
      t_31_ = (t_31_).underdot
    else
    end
    underdot = t_31_
  end
  local underdash
  do
    local t_33_ = gui
    if (nil ~= t_33_) then
      t_33_ = (t_33_).underdash
    else
    end
    underdash = t_33_
  end
  local inverse
  do
    local t_35_ = gui
    if (nil ~= t_35_) then
      t_35_ = (t_35_).inverse
    else
    end
    inverse = t_35_
  end
  local italic
  do
    local t_37_ = gui
    if (nil ~= t_37_) then
      t_37_ = (t_37_).italic
    else
    end
    italic = t_37_
  end
  local standout
  do
    local t_39_ = gui
    if (nil ~= t_39_) then
      t_39_ = (t_39_).standout
    else
    end
    standout = t_39_
  end
  local nocombine
  do
    local t_41_ = gui
    if (nil ~= t_41_) then
      t_41_ = (t_41_).nocombine
    else
    end
    nocombine = t_41_
  end
  local strikethrough
  do
    local t_43_ = gui
    if (nil ~= t_43_) then
      t_43_ = (t_43_).strikethrough
    else
    end
    strikethrough = t_43_
  end
  local blend0
  do
    local t_45_ = gui
    if (nil ~= t_45_) then
      t_45_ = (t_45_).blend
    else
    end
    blend0 = t_45_
  end
  local special0
  local function _48_()
    local t_47_ = gui
    if (nil ~= t_47_) then
      t_47_ = (t_47_).special
    else
    end
    return t_47_
  end
  special0 = utils["decimal-rgb->hex"](_48_())
  return {group = group0, fg = fg, bg = bg, ctermbg = ctermbg, ctermfg = ctermfg, bold = bold, underline = underline, underlineline = underlineline, undercurl = undercurl, underdot = underdot, underdash = underdash, inverse = inverse, italic = italic, nocombine = nocombine, standout = standout, strikethrough = strikethrough, blend = blend0, special = special0}
end
_2amodule_2a["get-existing"] = get_existing
local function overwrite(opts)
  local group0 = get.group(opts)
  local current_hl = get_existing(group0)
  local output = vim.tbl_extend("force", current_hl, opts)
  do end (output)["group"] = nil
  output["default"] = nil
  return output
end
_2amodule_2a["overwrite"] = overwrite
local function highlight(namespace, opts)
  if get.link(opts) then
    local group0 = get.group(opts)
    local link0 = get.link(opts)
    local args = {link = link0}
    return vim.api.nvim_set_hl(namespace, group0, args)
  elseif get.default(opts) then
    local group0 = get.group(opts)
    local args = overwrite(opts)
    return vim.api.nvim_set_hl(namespace, group0, args)
  else
    local group0 = get.group(opts)
    local gui_fore
    if ((get["gui-fg"](opts) ~= nil) and (opts.fg ~= "NONE") and (opts.fg ~= "SKIP")) then
      gui_fore = opts.fg
    else
      gui_fore = nil
    end
    local gui_back
    if ((get["gui-bg"](opts) ~= nil) and (opts.bg ~= "NONE") and (opts.bg ~= "SKIP")) then
      gui_back = opts.bg
    else
      gui_back = nil
    end
    local c_fore
    if ((get["term-fg"](opts) ~= nil) and (opts.ctermfg ~= "NONE") and (opts.ctermfg ~= "SKIP")) then
      c_fore = opts.ctermfg
    else
      c_fore = nil
    end
    local c_back
    if ((get["term-bg"](opts) ~= nil) and (opts.ctermbg ~= "NONE") and (opts.ctermbg ~= "SKIP")) then
      c_back = opts.ctermbg
    else
      c_back = nil
    end
    local args = {fg = gui_fore, bg = gui_back, ctermfg = c_fore, ctermbg = c_back, special = get.special(opts), blend = get.blend(opts)}
    for k, v in pairs(get["all-attr->table"](opts)) do
      args[k] = v
    end
    return vim.api.nvim_set_hl(namespace, group0, args)
  end
end
_2amodule_2a["highlight"] = highlight
return _2amodule_2a