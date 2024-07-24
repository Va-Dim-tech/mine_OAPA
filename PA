a = component.list('transposer')
if a == nil or pairs(a)(a) == nil then 
	error('нет транспозера')
end
tr = component.proxy(pairs(a)(a))
inside = 6 -- выход с пресса и интерфейса
ouside = 6 -- интерфейс
fbside = 6 -- низ пресса
ffside = 6 -- перед пресса
ee = component.proxy(component.list('eeprom')())
text = ee.getLabel()
if string.sub(text, 1, 3) == 'PAS' and #text >= 7 then
--reading
inside = tonumber(string.sub(text, 4, 4))
ouside = tonumber(string.sub(text, 5, 5))
fbside = tonumber(string.sub(text, 6, 6))
ffside = tonumber(string.sub(text, 7, 7))
else
-- colibration
-- redstone factory front
-- press factory out
for i=2, 5 do
	nam = tr.getInventoryName(i)
	if nam ~= nil then
		if nam == 'appliedenergistics2:interface' then
			ouside = i
		else
			siz = tr.getInventorySize(i)
			flag = false
			for j=1, siz do
				a = tr.getStackInSlot(i, j)
				if a ~= nil then
					if a.name == 'appliedenergistics2:material' then
						flag = true
						inside = i
						break
					elseif a.name == 'minecraft:redstone' then 
						ffside = i
						flag = true
						break
					end
				end
			end
			if flag == false then
				fbside = i
			end
		
		end
	end
end
if inside == 6 or ouside == 6 or fbside == 6 or ffside == 6 then
	computer.beep('-..')
	error('cant colibrate')
end
ee.setLabel(string.format('PAS%s%s%s%s', inside, ouside, fbside, ffside))

end
function typ(nm, dm)
	for i, j in pairs(items) do
		if i.name == nm and i.damage == dm then
			return j
		end
	end
	return 0
end

items = {[{['damage'] = 19, ['name'] = 'appliedenergistics2:material'}] = 1, -- кремневый
[{['damage'] = 15, ['name'] = 'appliedenergistics2:material'}] = 2, -- логический
[{['damage'] = 13, ['name'] = 'appliedenergistics2:material'}] = 3, -- вычислительный
[{['damage'] = 14, ['name'] = 'appliedenergistics2:material'}] = 4, -- инженерный

[{['damage'] = 5, ['name'] = 'appliedenergistics2:material'}] = 5,
[{['damage'] = 2, ['name'] = 'galacticraftcore:basic_item'}] = 5,
[{['damage'] = 0, ['name'] = 'minecraft:gold_ingot'}] = 6,
[{['damage'] = 10, ['name'] = 'appliedenergistics2:material'}] = 7,
[{['damage'] = 0, ['name'] = 'minecraft:diamond'}] = 8,
[{['damage'] = 19, ['name'] = 'ic2:crafting'}] = 8,
[{['damage'] = 0, ['name'] = 'minecraft:redstone'}] = 9,
[{['damage'] = 20, ['name'] = 'appliedenergistics2:material'}] = 10,  --кремневый 
[{['damage'] = 18, ['name'] = 'appliedenergistics2:material'}] = 11,  -- логический
[{['damage'] = 17, ['name'] = 'appliedenergistics2:material'}] = 12,  -- инженерный
[{['damage'] = 16, ['name'] = 'appliedenergistics2:material'}] = 13,  -- вычислительный
[{['damage'] = 24, ['name'] = 'appliedenergistics2:material'}] = 14,
[{['damage'] = 22, ['name'] = 'appliedenergistics2:material'}] = 15,
[{['damage'] = 23, ['name'] = 'appliedenergistics2:material'}] = 16
}

rec = { -- what 
{1, 5, nil, 10},
{2, 6, nil, 11},
{3, 10, nil, 13},
{4, 8, nil, 12},
{12, 9, 10, 14},
{11, 9, 10, 15},
{13, 9, 10, 16}
}
dat = tr.getAllStacks(inside).getAll()
for i=1, #dat do
	if dat[i].name ~= 'minecraft:air' then
		a = typ(dat[i].name, dat[i].damage)
		if a >= 1 and a <= 4 then
			tr.transferItem(inside, inside, 64, i, #dat - (a - 1))
		end
		if a == 0 then 
			tr.transferItem(inside, ouside, 64, i)
		end
	end
end
dat = nil
state = 1


while true do
computer.pullSignal(0)
if state == 1 then 
	
	
	
	
elseif state == 2 then


end













end


