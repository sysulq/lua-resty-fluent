local tcp = ngx.socket.tcp
local log = ngx.log
local ERR = ngx.ERR
local INFO = ngx.INFO
local WARN = ngx.WARN
local DEBUG = ngx.DEBUG
local os = require "os"
local cjson = require "cjson"
local _M = {}

local mt = { __index = _M }

function _M.new(self)
	local sock, err = tcp()
	if not sock then
		return nil, err
	end
	return setmetatable({ sock = sock }, mt)
end

function _M.set_timeout(self, timeout)
	local sock = self.sock
	if not sock then
		return nil, "not initialized"
	end
	return sock:settimeout(timeout)
end

function _M.connect(self, ...)
	local sock = self.sock
	if not sock then
		return nil, "not initialized"
	end

	return sock:connect(...)
end

function _M.post(self, tag, data)
	local sock = self.sock
	if not sock then
		return nil, "not initialized"
	end
	local msg = cjson.encode({tag, os.time(), data})
	return sock:send(msg)
end

function _M.close()
	if not sock then
		return nil, "not initialized"
	end
	return sock:close()
end

return _M