local function apply_energy_source(loader)

  -- Items per second, according to docs
  local items_per_second = loader.speed * 480
  -- Speed level 1 is 15 items per second, higher tiers are multiples
  local speed_level = items_per_second / 15
  -- Tiers below base are expressed as negative ones, i.e. 7.5 ips is level 0.5, becomes -1
  -- While levels above 1 are shifted, so that 15 ips becomes level 0, with no adjustments to power per item
  if speed_level < 1 then
      speed_level = - (1 / speed_level)
  else
      speed_level = speed_level - 1
  end

  local item_cost = 6000 - 600 * speed_level
  -- buffer for exactly 1 second. Do we need buffer for loader?
  local buffer_cap = items_per_second * item_cost + 2000

  loader.energy_source = {
      type = "electric",
      buffer_capacity = tostring(buffer_cap) .. "J",
      usage_priority = "secondary-input",
      drain = "2KW",
  }
  loader.energy_per_item = tostring(item_cost) .. "J"
end

local loader = data.raw["loader-1x1"]["ei_loader"]

apply_energy_source(loader)

loader = data.raw["loader-1x1"]["ei_fast-loader"]

apply_energy_source(loader)

loader = data.raw["loader-1x1"]["ei_express-loader"]

apply_energy_source(loader)

