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
local autoload = (require("nvim-startify.aniseed.autoload")).autoload
local config, file, s = autoload("nvim-startify.utils.config"), autoload("nvim-startify.utils.file"), autoload("nvim-startify.aniseed.string")
do end (_2amodule_locals_2a)["config"] = config
_2amodule_locals_2a["file"] = file
_2amodule_locals_2a["s"] = s
local groups = {header = {link = "Title", name = "StartifyHeader"}, special = {link = "Comment", name = "StartifySpecial"}, directory = {link = "Directory", name = "StartifyFile"}}
_2amodule_2a["groups"] = groups
local function get_group(table)
  local t_1_ = table
  if (nil ~= t_1_) then
    t_1_ = (t_1_).group
  else
  end
  return t_1_
end
_2amodule_2a["get-group"] = get_group
local function get_gui_fg(table)
  local t_3_ = table
  if (nil ~= t_3_) then
    t_3_ = (t_3_).fg
  else
  end
  return t_3_
end
_2amodule_2a["get-gui-fg"] = get_gui_fg
local function get_gui_bg(table)
  local t_5_ = table
  if (nil ~= t_5_) then
    t_5_ = (t_5_).bg
  else
  end
  return t_5_
end
_2amodule_2a["get-gui-bg"] = get_gui_bg
local function get_term_fg(table)
  local t_7_ = table
  if (nil ~= t_7_) then
    t_7_ = (t_7_).ctermfg
  else
  end
  return t_7_
end
_2amodule_2a["get-term-fg"] = get_term_fg
local function get_term_bg(table)
  local t_9_ = table
  if (nil ~= t_9_) then
    t_9_ = (t_9_).ctermbg
  else
  end
  return t_9_
end
_2amodule_2a["get-term-bg"] = get_term_bg
local function get_special(table)
  local t_11_ = table
  if (nil ~= t_11_) then
    t_11_ = (t_11_).sp
  else
  end
  return t_11_
end
_2amodule_2a["get-special"] = get_special
local function get_blend(table)
  local t_13_ = table
  if (nil ~= t_13_) then
    t_13_ = (t_13_).blend
  else
  end
  return t_13_
end
_2amodule_2a["get-blend"] = get_blend
local function get_link(table)
  local t_15_ = table
  if (nil ~= t_15_) then
    t_15_ = (t_15_).link
  else
  end
  return t_15_
end
_2amodule_2a["get-link"] = get_link
local function get_default(table)
  local t_17_ = table
  if (nil ~= t_17_) then
    t_17_ = (t_17_).default
  else
  end
  return t_17_
end
_2amodule_2a["get-default"] = get_default
local function get_all_attr__3etable(table_23)
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
_2amodule_2a["get-all-attr->table"] = get_all_attr__3etable
local function get_existing(group)
  local gui = vim.api.nvim_get_hl_by_name(group, true)
  local fg = utils["decimal-rgb->hex"](gui.foreground)
  local bg = utils["decimal-rgb->hex"](gui.background)
  local cterm = vim.api.nvim_get_hl_by_name(group, false)
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
  local blend
  do
    local t_45_ = gui
    if (nil ~= t_45_) then
      t_45_ = (t_45_).blend
    else
    end
    blend = t_45_
  end
  local special
  local function _48_()
    local t_47_ = gui
    if (nil ~= t_47_) then
      t_47_ = (t_47_).special
    else
    end
    return t_47_
  end
  special = utils["decimal-rgb->hex"](_48_())
  return {group = group, fg = fg, bg = bg, ctermbg = ctermbg, ctermfg = ctermfg, bold = bold, underline = underline, underlineline = underlineline, undercurl = undercurl, underdot = underdot, underdash = underdash, inverse = inverse, italic = italic, nocombine = nocombine, standout = standout, strikethrough = strikethrough, blend = blend, special = special}
end
_2amodule_2a["get-existing"] = get_existing
local function overwrite(opts)
  local group = get_group(opts)
  local current_hl = get_existing(group)
  local output = vim.tbl_extend("force", current_hl, opts)
  do end (output)["group"] = nil
  output["default"] = nil
  return output
end
_2amodule_2a["overwrite"] = overwrite
local function highlight(namespace, opts)
  if get_link(opts) then
    local group = get_group(opts)
    local link = get_link(opts)
    local args = {link = link}
    return vim.api.nvim_set_hl(namespace, group, args)
  elseif get_default(opts) then
    local group = get_group(opts)
    local args = overwrite(opts)
    return vim.api.nvim_set_hl(namespace, group, args)
  else
    local group = get_group(opts)
    local gui_fore
    if ((get_gui_fg(opts) ~= nil) and (opts.fg ~= "NONE") and (opts.fg ~= "SKIP")) then
      gui_fore = opts.fg
    else
      gui_fore = nil
    end
    local gui_back
    if ((get_gui_bg(opts) ~= nil) and (opts.bg ~= "NONE") and (opts.bg ~= "SKIP")) then
      gui_back = opts.bg
    else
      gui_back = nil
    end
    local c_fore
    if ((get_term_fg(opts) ~= nil) and (opts.ctermfg ~= "NONE") and (opts.ctermfg ~= "SKIP")) then
      c_fore = opts.ctermfg
    else
      c_fore = nil
    end
    local c_back
    if ((get_term_bg(opts) ~= nil) and (opts.ctermbg ~= "NONE") and (opts.ctermbg ~= "SKIP")) then
      c_back = opts.ctermbg
    else
      c_back = nil
    end
    local args = {fg = gui_fore, bg = gui_back, ctermfg = c_fore, ctermbg = c_back, special = get_special(opts), blend = get_blend(opts)}
    for k, v in pairs(get_all_attr__3etable(opts)) do
      args[k] = v
    end
    return vim.api.nvim_set_hl(namespace, group, args)
  end
end
_2amodule_2a["highlight"] = highlight
local function gen_hl_group(ify)
  if file.startify["hl-group"] then
    local out = string.format("Startify_%s_%s", ify, file.startify["hl-group"])
    do local _ = (file.startify["hl-group"] + 1) end
    return out
  else
    file.startify["hl-group"] = 1
    local out = string.format("Startify_%s_%s", ify, file.startify["hl-group"])
    do local _ = (file.startify["hl-group"] + 1) end
    return out
  end
end
_2amodule_2a["gen-hl-group"] = gen_hl_group
local function str(ify_string, ify)
  local out_string = {}
  if (type(ify_string) == "table") then
    for _, sub_string in ipairs(ify_string) do
      if (type(sub_string) == "table") then
        table.insert(out_string, sub_string[1])
        local hl_group = gen_hl_group(ify)
        local color_table = sub_string[2]
        color_table["group"] = hl_group
        highlight(file.startify.namespace, color_table)
      else
        table.insert(out_string, sub_string)
      end
    end
  else
    table.insert(out_string, ify_string)
  end
  return s.join(out_string)
end
_2amodule_2a["str"] = str
return _2amodule_2a