package = "__gc"
version = "scm-2"
source = {
  url = "git://github.com/katlogic/__gc.git";
  branch = "master";
}
description = {
	summary = "__gc for tables in Lua 5.1 and LuaJIT";
	detailed = "This is a dead-simple setmetatable() wrapper. "..
	           "It injects a newproxy() key directly into objects. "..
		   "So be careful if you use pairs().";
	homepage = "http://github.com/katlogic/__gc";
	license = "MIT";
}

dependencies = {
   "lua >= 5.1"
}

build = {
	type = "builtin";
	modules = {
		["__gc"] = "__gc.lua";
	}
}
