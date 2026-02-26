local bit = require("bit")

local M = {}

local function read_bytes(n)
  local f = assert(io.open("/dev/urandom", "rb"))
  local bytes = f:read(n)
  f:close()
  return bytes
end

local function to_hex(str)
  return (str:gsub('.', function(c)
    return string.format('%02x', string.byte(c))
  end))
end

local function encode_uint32_be(n)
  return string.char(
    bit.band(bit.rshift(n, 24), 0xFF),
    bit.band(bit.rshift(n, 16), 0xFF),
    bit.band(bit.rshift(n, 8), 0xFF),
    bit.band(n, 0xFF)
  )
end

function M.generate_object_id()
  local ts = encode_uint32_be(os.time())
  local rand = read_bytes(5)
  local counter = read_bytes(3)
  return to_hex(ts .. rand .. counter)
end

return M
