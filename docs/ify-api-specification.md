



# Version

The IFY API specification will be at 1.0, using semantic versioning (x.y). "x" releases are major
changes, and require breaking changes to the API for this to increase. "y" releases are updates to
the specification that do not require breaking changes.

A breaking change is any change that requires a rewrite of the usage of the API. This does not
mean that the implementation of the API cannot change, as that can change how it needs to. For
example, if an API specified the following table:
```lua
local table = {key1 = {"string", "string"}}
```
Then a breaking change would be:
```lua
local table = {strings = {key1 = {"string", "string"}}}
```
The specification has changed here, so a new "x" version would release.


# Language

###### IFY
A specified table that is used by nvim-startify to render to a buffer
###### nvim-startify
A Neovim startup page plugin to access commonly used features

An IFY is a structured table that contains specified keys and is passed to nvim-startify to render
to a buffer. The idea of this table is to remove the user calculation needs when rendering, and
instead rely on behaviors people are familiar with in languages such as CSS.

An IFY is a series of nested tables and arrays. As nvim-startify is written in Fennel, which
compiles to Lua, the descriptive language from Lua as well as own language will be used here:

###### table
an array or associative array that can store any valid type


###### key/value table
A key/value table is stored as an associative array by the Lua interpreter. It is a table whose
keys are some valid primitive type and whose value is any valid type.key/value table

Written in Lua: `key_value = {key = value}`
Written in Fennel: `(set key-value {\:key value})`


###### sequential table
A sequential table is stored as a 0-indexed array, and presented as a 1-indexed array. It is
functionally a [key/value table](#keyvalue-table) where each key is the index value.sequential table

Written in Lua: `sequential_table = {value}`
Written in Fennel: `(set sequential-table [value])`


## Startify Pages

In nvim-startify, the rendering is done to a "page" inside the current Neovim window. The page is
like the body of website, while the window is like the entire window size of the browser. The
page width can be set. The page height does not exist, it is as long as it needs to be. The
window height is used for calculations pertaining to height needs.


# Unique Data Structures

Throughout this API there are [tables](#table) that are used in a number of places.


## Color-Highlight Table

A color-highlight table (CHT) is a key/value table that uses keys that corresponds to the
arguments used for Neovim's API highlight function. The behavior of this is specific. 

Hexadecimal colors are stored as strings (e.g. `"#112233"`)


### Behavior

- Keys that aren't listed are skipped over by nvim-startify 
- If the skipped key item being highlighted already had a highlight group attached to it, then
  that skipped key that corresponds to the highlight group will be used still
- The boolean value of "false" for any key will explicitly disable this group in the highlight
  function


### Keys

- fg: GUI foreground color, in string hexadecimal format
- bg: GUI background color, in string hexadecimal format
- cterm_fg: Terminal foreground color, a number 0-255 corresponding to terminal color codes
- cterm_bg: Terminal background color, a number 0-255 corresponding to terminal color codes
- sp: The GUI color for the following text attributes: underline, undercurl, underdouble,
  underdotted, and underdashed
- Text attributes: these are a list of keys that just take boolean values to set text attributes
    - bold: **bold text**
    - italic: _italics text_
    - strikethrough: ~~strikethrough~~ text
    - underline: underlined text
    - undercurl: undercurled text
    - underdouble: double underlined text
    - underdotted: dotted underlined text
    - underdashed: dashed underlined text

The following key has the highest priority and nvim-startify will ignore all other keys:
- link: A highlight group to link


### Examples

```lua
local colors = {
  fg = "#123432",
  bg = false,
  bold = true
}
```

```fennel
(local colors {:fg :#231471
               :cterm_fg 2
               :sp :#998811
               :underline true})
(local linked-color {:link :Title})
```



## Conjoined Color-String Table

A conjoined color-string table (CCST) is a key/value table that allows for a one-line string to
be colored by a color-highlight table (CHT). This table allows for arbitrary coloring of strings
within a IFY without care to the generalized highlighting of nvim-startify.


### Behavior

For any valid string key in a IFY, a CCST can be used. nvim-startify will take the CHT, create
an arbitrary highlight group for it, then during rendering of the string within the CCST will
apply a extmark highlight using the highlight group.


### Format

A CCST is a 2 element sequential table. The first element in the table is a string of any
length. The second element is a [color-highlight table](#color-highlight-table).


### Examples

```lua
local strings = {
  "Hello everyone!",
  {
    fg = "#224411",
    bold = true,
  }
}
```

```fennel
(local strings ["This is a string"
                {:bg :#000000}])
```

```fennel
(local multi-strings 
       [["Hello" {:fg :#220000}]
        " "
        ["World" {:fg :#002200}]])
```


## Text Format Tables

To eliminate the need for users to calculate text formatting options such as padding and
alignment, this table can be applied to any IFY with the key `"format"`.


### Behavior

This table will be parsed for each key during the rendering pass of nvim-startify. For each
key found, nvim-startify will use the values found in the key instead of the default values (set
globally by the user). If a key is not found, nvim-startify will use the default values.


### Keys

- padding: a number of whitespace to add to the needed side of the IFY's string. The direction
  of the IFY depends on the value of the key `"align"`
- align: one of a set of predefined strings to determine the point at which this IFY renders
  from. This point affects where the padding is applied e.g. `"right-window"` will add x padding
  to the right of the IFY's string. See below for the valid values
- above-spacing: a number of empty lines to add above this IFY
- below-spacing: a number of empty lines to add below this IFY


### Values

Note: see [Startify page information](#startify-pages) for language on pages vs windows.

#### `align`

- right-window: align to right of the Neovim window
- right-page: align to right of Startify page
- left-window: align to left of Neovim window
- left-page: align to left of Startify page
- center-window: align to center of Neovim window
- center-page: align to center of Startify page


### Examples

```lua
local title = {
  string = "title",
  format = {
    align = "right-window"
  }
}
```

```fennel
(local title {:string :title
              :format {:padding 10
                       :align :center-window}})
```


# IFY Specification

A IFY is a [key/value table](#keyvalue-table) that contains items to be rendered by
nvim-startify. The table itself is what get passed to nvim-startify, in the order desired for
rendering, to render. Inside each table contains specific keys that are grouped in for each pass.
This grouping allows for tighter control of where the user wants to place something. For example,
instead of having to create at title IFY then a list IFY, then order those properly for
nvim-startify, you can simply create a title and list IFY. As well, each item in the IFY can take
the same customization tables where appropriate.


## Items

Items are the key/value tables that contain the information to be rendered. There are currently 3
items available to the specification. More is acceptable to be added to the specification.


### `art`

The `art` key is designed to render "ASCII art". ASCII art is a bit of a misnomer as most modern
examples are now made with Unicode characters rather than the limited set of ASCII characters.
This item takes 2 required keys and the optional [color-highlight table](#color-highlight-table) and 
[text format table](#text-format-tables).


#### `size`

This is a 2 element sequential table where the first element corresponds to the art's width and
the second element corresponds the art's height. This is expressed in exact character integers.


#### `string`

This key is the art data itself. It is a sequential table of strings, 
[conjoined color-string tables](#conjoined-color-string-table), and/or a sequential table that
is a combination of the two. The string type **must** not exceed the art's width, and the number
of elements in this table **must** equal the art's height. If dynamic strings are used, the
`size` table must be updated dynamically as well to reflect this.

For conjoined color-string table strings, you can still combine them within the same main
element of the string table:
```lua
-- each ccst
ccst_1 = {"Hel", {fg = "#222222"}} 
ccst_2 = {"lo", {fg = "#113344"}} 
-- the strings table
art = {string = {
  {ccst_1, ccst_2, ", how are you today?"},
  "                       :-)"
}}
```

If left padding is required within the art itself, this must be inserted into the string.

nvim-startify will render each element of the `string` table as its own line. This is why the
sequential table element that contains CCST and string elements is used. For these tables, they
act as concatenated strings, but explicitly groups them as one element for clarity. You do not
need to do string concatenation within the `string` table.


#### `format`

This IFY can optionally take the [text format table](#text-format-table).


#### `color`

This IFY can optionally take the [color-highlight table](#color-highlight-table). This table
will be underridden by conjoined-color-string tables.


### `title`

This `title` key is designed to render titles for IFY's. The title is only a single line. This
item takes 1 required key and the optional [color-highlight table](#color-highlight-table) and
[text format table](#text-format-tables).


#### `string`

A string or sequential table of strings and 
[conjoined color-string tables](#conjoined-color-string-table). This is what is rendered by
nvim-startify. This string must only be one line (i.e. cannot contain `\\n` or `\\r`).

For the sequential table of strings and CCSTs, you can nest them as needed:
```lua
-- each ccst
ccst_1 = {"Hel", {fg = "#222222"}} 
ccst_2 = {"lo", {fg = "#113344"}} 
-- the strings table
title = {string = {
  {ccst_1, ccst_2, ", how are you today?"},
}}
```
These tables act as concatenated strings. You do not need to do string concatenation yourself.


#### `format`

This IFY can optionally take the [text format table](#text-format-table).


#### `color`

This IFY can optionally take the [color-highlight table](#color-highlight-table). This table
will be underridden by conjoined-color-string tables


### `list`

This key will render a series of items. The series of items in this IFY are called "entries",
which each individual item being called an "entry". Generally, this is the main point of
interaction with the user and is the most expansive IFY key.


#### `entries`

A sequential table of objects that correspond to the entry desired. The entries themselves will
typically be strings or functions. nvim-startify will render the entries to strings if a
`names` table is not used.


#### `names`

An optional key that is a sequential table follows the same order as the `entries` table in
which each element in the `names` table matches the element found in `entries`. This is
designed to present something that is different from what is process. When this is not passed,
nvim-startify will use the `entries` table for rendering.

For example, if the user wants to have an entry for `~/.config/nvim/init.lua` but named
something more clearly, then they can set the corresponding entry name to `Neovim Init` and
nvim-startify will render that instead.

To skip a name in the entry, there are 2 options:
1. Use the boolean value "false" for the index values one does not want
2. convert to a key/value table, where the key is the index desired

nvim-startify will skip over all false boolean values, and only process the specific keys of a
key/value `names` table.


#### `keys`

An optional key that is a sequential table of normal mode key mapping keys to use for each
entry in this IFY list. When this is not passed, nvim-startify will use the next keys in the
global keymapping index from top to bottom.

While there is no limit to the length of keys that can be used, they should be left to a
maximum of 2 for visual clarity.

nvim-startify will produce errors when the same keys are used in rendering.


#### `type`

This describes how each entry should be run by nvim-startify when the user activates the entry
- file: A string; the entries are parsed as files, using the local working directory if
  absolute file paths aren't used
- dir: A string; the entries are parsed as file system directories, using the local working
  directory if absolute paths aren't used
- callback: A function with arg `entry`. Any valid function. The arg `entry` is the entry that
  was picked by the user. nvim-startify will pass this when running this function


#### `after`

An optional table that runs a function after the entry is processed. Works for any list type.
The function is passed the argument `entry` much like the `callback` key in the `type` table.
This can be used to automatically change directory for "file" type lists.


#### `format`

This IFY can optionally take the [text format table](#text-format-table).


## `opts`

This optional sequential table contains options for the IFY, such as rendering order for the
items inside this IFY.


### `order`

A sequential table that contains the strings corresponding to the IFY item types ('art',
'title', 'list'). Put these in the order desired. nvim-startify will default to the order:
'title', 'art', 'list'. If not all keys are present compared to what is in the IFY table then
nvim-startify will go to the default order


# IFY Rendering

The IFY format is designed to be easily rendered. nvim-startify renders IFY by checking it's
sequential table of IFY's to render. Then, inside the startify buffer, a line parser is started
that starts with the 0th line of the buffer (1 less than the first line). It will check settings,
such as header spacing, before moving to the first IFY on it's list. nvim-startify will then do a
few things:
1. Check the keys present in the IFY. This is then cross checked against the `opts.order` table, if
   it exists, to verify the order can work.
2. Start rendering the first item:
    - For 'art':
        1. Using the value of 'above-spacing' inside the table `art.format`, going to default if needed,
           advance the line parser by that amount
        2. Grab the height value from `art.size` and cross check with the number of tables within
           `art.string`
        3. Using the padding and alignment values inside `art.format`, create the whitespace padding
           string needed
        4. Place string values with padding string, creating extmarks for each unique string in table as
           well as entire art string
        5. For conjoined-color-string tables, set extmark priority higher than base value, and apply
           highlights
        6. Apply `art.color` to extmark, if present, to entire title string (lower priority)
        7. Using the value of 'below-spacing' inside the table `art.format`, going to default if needed,
           advance the line parser by that amount
    - For 'title':
        8. Using the value of 'above-spacing' inside the table `title.format`, going to default if needed,
           advance the line parser by that amount
        9. Using the padding and alignment values inside `title.format`, create the whitespace padding
           string needed
        10. Place string values with padding string, creating extmarks for each unique string in table as
            well as entire title string
        11. For conjoined-color-string tables, set extmark priority higher than base value, and apply
            highlights
        12. Apply `title.color` to extmark, if present, to entire title string (lower priority)
        13. Using the value of 'below-spacing' inside the table `title.format`, going to default if needed,
            advance the line parser by that amount
    - For 'list'
        14. Using the value of 'above-spacing' inside the table `list.format`, going to default if needed,
            advance the line parser by that amount
        15. Using the padding and alignment values inside `list.format`, create the whitespace padding
            string needed
        16. Check if `list.names` exists
        17. Loop over indices:
            1. Create mapping string for current key index using `list.keys` or global index
            2. See if `list.names` has a key at this index if `list.names` exists
            3. Concatenate mapping string with `list.names` or `list.entries` if the former has no value at
               this index or `list.names` doesn't exist
            4. Add key map, entry value, entry name (if exists, else entry value), entry type, and entry
               after function (if exist) to global handler
        18. Using the value of 'below-spacing' inside the table `list.format`, going to default if needed,
            advance the line parser by that amount
3. Continue with each item in the IFY, or go to next IFY if empty
4. When IFY list has been exhausted, truncate startify buffer and run post render hooks


# Why Are IFYs Multifaceted?

IFYs in the current version of the specification can contain 3 items to be rendered by
nvim-startify. This seems quite obtuse, but its the only way to allow grouping of the IFYs
properly. If each IFY item were separate, i.e. you could only have a title IFY, not a title+list
IFY, then you would be unable to know what each IFY goes to. This would limit nvim-startify from
having future features, like inserting IFYs into a preexisting buffer, having folds, or other
generic types besides lists from having titles. For simplicity sake, do not think of IFYs as
"everything needed to be rendered" but as things needed to be grouped together. Ask yourself, "Do
I need a title for this art?" and so on.
