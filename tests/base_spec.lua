describe("some basics", function()
  local bello = function(boo) return "bello " .. boo end

  local bounter

  before_each(function() bounter = 0 end)

  it("some test", function()
    bounter = 100
    assert.equals("bello Brian", bello("Brian"))
    assert.equals(0, bounter)
  end)

  it("some other test", function() assert.equals(0, bounter) end)
end)
