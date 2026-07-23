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
tp = nil
mn = nil
bt = nil
is = nil
ss = nil
it = nil
mi = nil
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

for tr in pairs(component.list("transposer")) do
	for i=0, 5 do
		a = component.invoke(tr, "getInventoryName", i)
		if a == 'appliedenergistics2:interface' then
			mn = component.proxy(tr)
			it = i
		end
		if a == 'appliedenergistics2:inscriber' then
			if i == 0 then
				tp = component.proxy(tr)
			elseif i == 1 then
				bt = component.proxy(tr)
			else
				mi = i 
			end
		end
	end
end
ss=1
for i=0, 1 do
	dat = mn.getAllStacks(i).getAll()
	for j, k in pairs(dat) do
		a = typ(k.name, k.damage)
		if k.name == 'appliedenergistics2:material' and a >= 1 and a <= 4 then 
			is = i
			mn.transferItem(i, i, 64, j, #dat - (a - 1))
		end
	end
	if not is then
		ss = 0
	end
end

error(tp.address .. " " .. mn.address .. " " .. bt.address .. " " .. is .. " " .. ss .. " " .. it .. " " .. mi)




function tru(sl)


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