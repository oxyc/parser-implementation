require './ParseLua'
require 'socket'
samples=100

function getMean(res)
  local total, count = 0, 0
  for key,value in pairs(res) do
    total = total + value
    count = count + 1
  end
  return total / count
end
function getVariance(res, mean)
  local total, count = 0, 0
  for key,value in pairs(res) do
    total = total + (value - mean)^2
    count = count + 1
  end
  return total / (count - 1)
end
function getDeviation(variance)
  return (math.sqrt(variance))
end

do
  local inf = io.open('ParseLua.lua', 'r');
  local text = inf:read('*all');
  inf:close();
  local results = {}
  for i=0,samples do
    local start = socket.gettime()
    ParseLua(text)
    local time = (( socket.gettime() - start )) * 1000
    results[i] = time
  end
  local mean = getMean(results)
  local variance = getVariance(results, mean)
  local sd = getDeviation(variance)
  print (mean..'\t'..sd..'\t'..variance)
end
