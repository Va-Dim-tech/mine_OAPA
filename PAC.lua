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
tp = nil -- транспосер верх
mn = nil -- транспосер центр
bt = nil -- транспосер низ
is = nil -- сторона сундука глав
ss = nil -- сторона не глав сундука
its = nil -- сторона интерфейса
mi = nil -- сторона выхода пресса
to = nil -- транспосер верх сундук
bo = nil -- транспосер низ сундук
function typ(it)
	if it == nil or it.name == 'minecraft:air' then
		return 17
	end
	for t1, t2 in pairs(items) do
		if t1.name == it.name and t1.damage == it.damage then
			return t2
		end
	end
	return 0
end


for tr in pairs(component.list("transposer")) do
	for i=0, 5 do
		t = component.proxy(tr)
		a = t.getInventoryName(i)
		if a == 'appliedenergistics2:interface' then
			mn = t
			its = i
		end
		if a == 'appliedenergistics2:inscriber' then
			if i == 0 then
				tp = t
			elseif i == 1 then
				bt = t
			else
				mi = i 
			end
		end
		a = t.getInventorySize(i)
		if a and a > 0 then 
			if tp == t then 
				to = i
			elseif bt == t then
				bo = i
			end
		end
	end
end

function tra(s1, t1, s2, t2, s3, i1, i2)
    f=1
	computer.beep(600, 1)
    if s1 == s2 then
        f=i1
    else
        if s2 == s3 then
            f = i2
        end
		if f then 
			t1.transferItem(s1, s2, 1, i1, f)
		else
			t1.transferItem(s1, s2, 1, i1)
		end
        
    end
	computer.beep(1000, 1)
	computer.pullSignal(1)
	
    if s2 ~= s3 then
		if i2 then 
			t2.transferItem(s2, s3, 1, f, i2)
		else
			t2.transferItem(s2, s3, 1, f)
		end
    end

end

ss=1
for i=0, 1 do
	dat = mn.getAllStacks(i).getAll()
	for j, k in pairs(dat) do
		a = typ(k)
		if a >= 1 and a <= 4 then 
			is = i
			mn.transferItem(i, i, 64, j, #dat - (a - 1))
		elseif a == 0 then
		    mn.transferItem(i, ita, 64, j, 1)
		end
	end
	if not is then
		ss = 0
	end
end
tra(0, tp, to, mn, is, 1, nil)
tra(1, bt, bo, mn, is, 1, nil)



if not (tp and mn and bt and its and mi and ss ~= is) then 
	error('no press ' .. mi .. " " .. is .. " " .. its .. " " .. ss)
end








prcd=0 -- кол-во в процессе
tcprs = 17 --текущий пресс
tecrec = 0 -- текущий рецепт
prms = {} -- предыдущий состав предметов
function rec()
	dat = mn.getAllStacks(is).getAll()
	ms = {[17]=64}
	chg = false -- изменилось ли
    for i, j in pairs(dat) do
        a = typ(j)
        if a ~= 17 then
            if a == 0 then
                mn.transferItem(is, its, 64, i)
            else 
                mn[a] = (mn[a] or 0) + j.size
                if prms[a] ~= mn[a] then
                    chg = true
                end
            end
		end
    end
    for i, j in pairs(rec) do
        if ms[j[1]] and ms[j[2]] and ms[j[3]] then
            if tecrec == i or prcd == 0 then
                if prcd == 0 then
                    for i=1, 3 do
                        if i == 1 then
                            t = tp
                            s = 0
                        elseif i == 2 then
                            t = bt
                        elseif i == 3 then
                            
                        end
                    end
                    
                end
            end
        end
    end
    if chg then
        -- timet
    else
        
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