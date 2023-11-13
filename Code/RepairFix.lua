  local priority_slots = {
    "Handheld A",
    "Handheld B",
    "Head",
    "Torso",
    "Legs"
  }

  function SectorOperationFillItemsToRepair(sector_id, mercs, check_only)
    local queue = gv_Sectors[sector_id].sector_repair_items_queued
    if not check_only then
      gv_Sectors[sector_id].sector_repair_items = {}
    end
    local all_to_repair = gv_Sectors[sector_id].sector_repair_items or {}
    local chek_only_var = {var_bool = false}
    local act_mercs = {}
    for _, slot in ipairs(priority_slots) do
      for _, merc in ipairs(mercs) do
        act_mercs[merc.session_id] = true
        merc:ForEachItemInSlot(slot, "ItemWithCondition", function(item, slot_name, left, top, all_to_repair, chek_only_var)
          if item and not IsKindOfClasses(item, "Mag", "LBE", "Backpack", "ArmorPlate") and not item:IsMaxCondition() and item.Repairable then
            if check_only then
              chek_only_var.var_bool = true
              return "break"
            end
            if not table.find(all_to_repair, "id", item.id) and not table.find(queue, "id", item.id) then
              table.insert(all_to_repair, {
                unit = merc.session_id,
                id = item.id,
                slot = slot,
                pos_left = left,
                pos_top = top
              })
            end
          end
        end, all_to_repair, chek_only_var)
      end
    end
    if chek_only_var.var_bool then
      return true
    end
    local all_sector_mercs = GetPlayerSectorUnits(sector_id)
    for _, slot in ipairs(priority_slots) do
      for _, merc in ipairs(mercs) do
        table.remove_value(all_sector_mercs, "session_id", merc.session_id)
        local squad = merc.Squad
        local units = gv_Squads[squad].units
        for _, unit_id in ipairs(units) do
          if not act_mercs[unit_id] then
            table.remove_value(all_sector_mercs, "session_id", unit_id)
            local unit = gv_UnitData[unit_id]
            unit:ForEachItemInSlot(slot, "ItemWithCondition", function(item, slot_name, left, top, all_to_repair, chek_only_var)
              if item and not IsKindOfClasses(item, "Mag", "LBE", "Backpack", "ArmorPlate") and not item:IsMaxCondition() and item.Repairable then
                if check_only then
                  chek_only_var.var_bool = true
                  return "break"
                end
                if not table.find(all_to_repair, "id", item.id) and not table.find(queue, "id", item.id) then
                  table.insert(all_to_repair, {
                    unit = unit_id,
                    id = item.id,
                    slot = slot,
                    pos_left = left,
                    pos_top = top
                  })
                end
              end
            end, all_to_repair, chek_only_var)
          end
        end
      end
    end
    if chek_only_var.var_bool then
      return true
    end
    for _, merc in ipairs(mercs) do
      local squad = merc.Squad
      local units = gv_Squads[squad].units
      for _, unit_id in ipairs(units) do
        local unit = gv_UnitData[unit_id]
        local slot = GetContainerInventorySlotName(unit)
        unit:ForEachItemInSlot(slot, "ItemWithCondition", function(item, slot_name, left, top, all_to_repair, chek_only_var)
          if not IsKindOfClasses(item, "Mag", "LBE", "Backpack", "ArmorPlate") and not item:IsMaxCondition() and item.Repairable and item:IsWeapon() then
            if check_only then
              chek_only_var.var_bool = true
              return "break"
            end
            if not table.find(all_to_repair, "id", item.id) and not table.find(queue, "id", item.id) then
              table.insert(all_to_repair, {
                unit = unit_id,
                id = item.id,
                slot = slot,
                pos_left = left,
                pos_top = top
              })
            end
          end
        end, all_to_repair, chek_only_var)
      end
    end
    if chek_only_var.var_bool then
      return true
    end
    for _, merc in ipairs(mercs) do
      local squad = merc.Squad
      local units = gv_Squads[squad].units
      for _, unit_id in ipairs(units) do
        local unit = gv_UnitData[unit_id]
        local slot = GetContainerInventorySlotName(unit)
        unit:ForEachItemInSlot(slot, "ItemWithCondition", function(item, slot_name, left, top, all_to_repair, chek_only_var)
          if not IsKindOfClasses(item, "Mag", "LBE", "Backpack", "ArmorPlate") and not item:IsMaxCondition() and item.Repairable and not item:IsWeapon() then
            if check_only then
              chek_only_var.var_bool = true
              return "break"
            end
            if not table.find(all_to_repair, "id", item.id) and not table.find(queue, "id", item.id) then
              table.insert(all_to_repair, {
                unit = unit_id,
                id = item.id,
                slot = slot,
                pos_left = left,
                pos_top = top
              })
            end
          end
        end, all_to_repair, chek_only_var)
      end
    end
    if chek_only_var.var_bool then
      return true
    end
    for _, slot in ipairs(priority_slots) do
      for _, merc in ipairs(all_sector_mercs) do
        merc:ForEachItemInSlot(slot, "ItemWithCondition", function(item, slot_name, left, top, all_to_repair, chek_only_var)
          if item and not IsKindOfClasses(item, "Mag", "LBE", "Backpack", "ArmorPlate") and not item:IsMaxCondition() and item.Repairable then
            if check_only then
              chek_only_var.var_bool = true
              return "break"
            end
            if not table.find(all_to_repair, "id", item.id) and not table.find(queue, "id", item.id) then
              table.insert(all_to_repair, {
                unit = merc.session_id,
                id = item.id,
                slot = slot,
                pos_left = left,
                pos_top = top
              })
            end
          end
        end, all_to_repair, chek_only_var)
      end
    end
    if chek_only_var.var_bool then
      return true
    end
    for _, unit in ipairs(all_sector_mercs) do
      local slot = GetContainerInventorySlotName(unit)
      unit:ForEachItemInSlot(slot, "ItemWithCondition", function(item, slot_name, left, top, all_to_repair, chek_only_var)
        if not IsKindOfClasses(item, "Mag", "LBE", "Backpack", "ArmorPlate") and not item:IsMaxCondition() and item.Repairable and not item:IsWeapon() then
          if check_only then
            chek_only_var.var_bool = true
            return "break"
          end
          if not table.find(all_to_repair, "id", item.id) and not table.find(queue, "id", item.id) then
            table.insert(all_to_repair, {
              unit = unit.session_id,
              id = item.id,
              slot = slot,
              pos_left = left,
              pos_top = top
            })
          end
        end
      end, all_to_repair, chek_only_var)
    end
    if chek_only_var.var_bool then
      return true
    end
    local stash = gv_Sectors[sector_id].sector_inventory or empty_table
    for cidx, container in ipairs(stash) do
      if container[2] then
        local items = container[3] or empty_table
        for idx, item in ipairs(items) do
          if not IsKindOfClasses(item, "Mag", "LBE", "Backpack", "ArmorPlate") and not item:IsMaxCondition() and item.Repairable then
            if check_only then
              chek_only_var.var_bool = true
              break
            end
            if not table.find(all_to_repair, "id", item.id) and not table.find(queue, "id", item.id) then
              table.insert(all_to_repair, {
                unit = "stash",
                id = item.id
              })
            end
          end
        end
      end
    end
    if chek_only_var.var_bool then
      return true
    end
    if check_only then
      return false
    end
    gv_Sectors[sector_id].sector_repair_items = all_to_repair
    return all_to_repair
  end