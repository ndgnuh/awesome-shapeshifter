# Awesome Shape Shifter

This is the base directory for a multiple-setup AwesomeWM.

> Why?

Because I can and I didn't think if I should.

Notice:
- `/awesomedir/` will be refered to as awesome's config directory
- Please read the [gotchas](#gotchas)

# Usage

## Installation

Fork and clone or just download this repo as a `zip`, anything suit you. Optionally, port your current setup.

## Create a new setup

1. Create a new directory inside `/awesomedir/Rice/` with your setup name (e.g. `/awesomedir/Rice/Fancy Rice/`)
2. Create `init.lua` inside that folder (i.e. `/awesomedir/Rice/Fancy Rice/`)
3. Start writing stuffs

## Porting an already existing setup

If the setup is not very complicated, copy the whole setup folder into `/awesomedir/Rice/` and change `rc.lua` to `init.lua` would work.

However, there are setups which use external resources (like icons) and use something like `os.getenv("HOME") .. "/.config/awesome/"` to get the path of the icons. In that case, you can:
- Move the resources (icons) to `/awesomedir/`
- Patch the setup, replace all the
```lua
os.getenv("HOME") .. "/.config/awesome"
```
with
```lua
gears.filesystem.get_configuration_dir()
```

Currently, one must do it manually, using `grep -rl . -e HOME` to see which file need to be patched. If someone came up with a script, I'd happily merge it.

## Switching between setups

Manually
```lua
local Rice = require("Rice")
Rice:set_current_rice("MyAwesomeSetup")
```

Using menu:
```lua
local Rice = require("Rice")
mymainmenu = awful.menu{
	items = {
		{ "awesome", myawesomemenu, beautiful.awesome_icon },
		Rice.menu,
		{ "open terminal", terminal }
	}
}
```

The setup is saved in `gears.filesystem.get_cache_dir() .. /rice.conf`

# Misc

## Changing `/awesomedir/Rice` to something else

Just rename the whole directory. `/awesomedir/Rice/init.lua` use lua debug libary to get the current directory so it won't broke, unless your lua version doesn't support it. In that case, simply go to the `/awesomedir/Rice/init.lua` and replace the path (search for `thisdir` and you will see it)

## The `helper` directory

This one contain some of the module that `/awesomedir/Rice/init.lua`:
- `thisdir.lua` is a handy function to get the directory which the `lua` file is in, thus, calling `thisdir()` inside `/awesomedir/Rice/init.lua` gives `/awesomedir/Rice/` without explicitly stating the folder name. Lua5.2 debug is required (I think?).
- `partial.lua` is a partial application function, which is written to handle most cases of function call without using recursion. To demonstrate what it does:
```lua
local modshift_key = partial(awful.key, modkey)
local mykey = modshift_key("j", partial(awful.client.swap.byidx, 1))
```
Note that `partial` *always* return a function.

## Gotchas

After loading a "rice", `gears.filesystem.get_configuration_dir` does *NOT* return `/awesomedir/`. It returns `/awesomedir/Rice/WhateverRiceYouAreUsing/`. This is to reduce the amount of path patchings that have to be done.

To get `/awesomedir/`, use `gears.filesystem.get_real_configuration_dir` in stead.

This behaviour can be modified in `/awesomedir/Rice/init.lua`.

