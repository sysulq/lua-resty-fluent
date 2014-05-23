Name
================

This is a simple fluent client based on openresty.

Synopsis
================

```
location / {
  content_by_lua '
    local fluent = require "fluent"
    f = fluent:new()
    local ok ,err = f:connect("127.0.0.1", 8888)
    if not ok then
      ngx.say("failed to connect: ", err)
      return
    end
  
    local ok, err = f:post("test","This is a test data")
    if not ok then
      ngx.say("failed to connect: ", err)
      return
    end
  
    f:close()
 ';
```
