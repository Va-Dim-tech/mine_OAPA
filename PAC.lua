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
	if nm == 'minecraft:air' then
	return 17
	end
	for t1, t2 in pairs(items) do
		if t1.name == nm and t1.damage == dm then
			return t2
		end
	end
	return 0
end
a = 'appliedenergistics2:material'
b = 'damage'
c = 'name'
items = {[{[b] = 19, [c] = a}] = 1, --крем
[{[b] = 15, [c] = a}] = 2, -- лог
[{[b] = 13, [c] = a}] = 3, -- выч
[{[b] = 14, [c] = a}] = 4, -- инж
[{[b] = 5, [c] = a}] = 5,
[{[b] = 2, [c] = 'galacticraftcore:basic_item'}] = 5,
[{[b] = 0, [c] = 'minecraft:gold_ingot'}] = 6,
[{[b] = 10, [c] = a}] = 7,
[{[b] = 0, [c] = 'minecraft:diamond'}] = 8,
[{[b] = 19, [c] = 'ic2:crafting'}] = 8,
[{[b] = 0, [c] = 'minecraft:redstone'}] = 9,
[{[b] = 20, [c] = a}] = 10, -- крем
[{[b] = 18, [c] = a}] = 11, -- лог
[{[b] = 17, [c] = a}] = 12, -- инж
[{[b] = 16, [c] = a}] = 13, -- выч
[{[b] = 24, [c] = a}] = 14,
[{[b] = 22, [c] = a}] = 15,
[{[b] = 23, [c] = a}] = 16
}
rec = {
{1, 5, 17, 10},
{2, 6, 17, 11},
{3, 7, 17, 13},
{4, 8, 17, 12},
{12, 9, 10, 14},
{11, 9, 10, 15},
{13, 9, 10, 16}
}
dat = tr.getAllStacks(inside).getAll()
for i=1, #dat do
	a = typ(dat[i].name, dat[i].damage)
	if a >= 1 and a <= 4 then
		tr.transferItem(inside, inside, 64, i, #dat - (a - 1))
	elseif a == 0 then 
		tr.transferItem(inside, ouside, 64, i)
	end
end
dat = nil
state = 1
tecrec = 0
pdat = nil
c = false

function st1()
	dat = tr.getAllStacks(inside).getAll()
	ms = {[17]=true}
	b = false
	it = false
	for i=1, #dat do
		a = typ(dat[i].name, dat[i].damage)
		if a ~= 17 then
			if a == 0 or (c and a > 4)then
				tr.transferItem(inside, ouside, 64, i)
			else
				if a > 4 then
					it = true
				end
				ms[a]=true
				if pdat ~= nil then
					if pdat[i].name ~= dat[i].name or pdat[i].damage ~= dat[i].damage then
						b = true
					end
				else 
					b = true
				end
			end
		end
	end
	if c then
		c = false
		return
	end
	if it == false then 
		return
	end
	pdat = dat
	for i=1, #rec do
		if ms[rec[i][1]] and ms[rec[i][2]] and ms[rec[i][3]] then
			tecrec = i
			if b then
				computer.pullSignal(0.5)
			else
				state = 2
			end
			return
		end
	end
	if b then
		computer.pullSignal(3)
	else
		c = true
	end
end

while true do
computer.pullSignal(0)
if state == 1 then 
	st1()
elseif state == 2 then
	a1 = true
	a2 = true
	a3 = true
	r = 5
	e = -1
	e1 = -1
	while e1 == e do
		e = 0
		dat = tr.getAllStacks(inside).getAll()
		for i=1, #dat do
			a = typ(dat[i].name, dat[i].damage)
			if rec[tecrec][1] == a and a1 then
				a1 = false
				b = tr.getStackInSlot(0, 1)
				if b ~= nil then
					c = typ(b.name, b.damage)
					if c ~= a then
						if c ~= 0 and c <= 4 then
							tr.transferItem(0, inside, 64, 1, #dat - (c - 1))
						else
							tr.transferItem(0, inside, 64, 1)
						end
					end
				end
				tr.transferItem(inside, 0, 1, i)
				r = a
			elseif rec[tecrec][2] == a and a2 then
				a2 = false
				tr.transferItem(inside, ffside, 1, i)
			elseif rec[tecrec][3] == a and a3 then
				a3 = false
				tr.transferItem(inside, fbside, 1, i)
			elseif rec[tecrec][4] == a then
				e = e + tr.getSlotStackSize(inside, i)
				s = i
			end
		end
		if e1 == -1 then
			e1 = e
		end
	end
	tr.transferItem(inside, ouside, 1, s)
	if r < 5 then 
		tr.transferItem(0, inside, 1, 1, #dat - (r - 1))
	else
		r.transferItem(0, inside, 1, 1)
	end
	state = 1
end
end