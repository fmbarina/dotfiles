-- Thanks TJ :^)
P = function(v)
  print(vim.inspect(v))
  return v
end

R = function(name)
  package.loaded[name] = nil
end

T = function(cond, a, b)
  if cond then
    return a
  else
    return b
  end
end

