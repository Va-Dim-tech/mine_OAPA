a='appliedenergistics2:material'
b='damage'
c='name'
items={[{[b]=19,[c]=a}]=1,
[{[b]=15,[c]=a}]=2,
[{[b]=13,[c]=a}]=3,
[{[b]=14,[c]=a}]=4,
[{[b]=5,[c]=a}]=5,
[{[b]=2,[c]='galacticraftcore:basic_item'}]=5,
[{[b]=0,[c]='minecraft:gold_ingot'}]=6,
[{[b]=10,[c]=a}]=7,
[{[b]=0,[c]='minecraft:diamond'}]=8,
[{[b]=19,[c]='ic2:crafting'}]=8,
[{[b]=0,[c]='minecraft:redstone'}]=9,
[{[b]=20,[c]=a}]=10,
[{[b]=18,[c]=a}]=11,
[{[b]=17,[c]=a}]=12,
[{[b]=16,[c]=a}]=13,
[{[b]=24,[c]=a}]=14,
[{[b]=22,[c]=a}]=15,
[{[b]=23,[c]=a}]=16
}
rec={
{1,5,17,10},
{2,6,17,11},
{3,7,17,13},
{4,8,17,12},
{12,9,10,14},
{11,9,10,15},
{13,9,10,16}
}
tp=nil
mn=nil
bt=nil
is=nil
ss=nil
its=nil
mi=nil
to=nil
bo=nil
function typ(it)
if it==nil or it.name=='minecraft:air' then
return 17
end
for l1,l2 in pairs(items) do
if l1.name==it.name and l1.damage==it.damage then
return l2
end
end
return 0
end
for tr in pairs(component.list("transposer")) do
for i=0,5 do
t=component.proxy(tr)
a=t.getInventoryName(i)
if a=='appliedenergistics2:interface' then
mn=t
its=i
end
if a=='appliedenergistics2:inscriber' then
if i==0 then
tp=t
elseif i==1 then
bt=t
else
mi=i 
end
end
a=t.getInventorySize(i)
if a and a > 0 then 
if tp==t then 
to=i
elseif bt==t then
bo=i
end
end
end
end
function tra(s1,t1,s2,s3,t2,s4,i1,i2)
f=1
if s1==s2 then
f=i1
else
if s3==s4 then
f=i2
end
if f then 
t1.transferItem(s1,s2,1,i1,f)
else
t1.transferItem(s1,s2,1,i1)
end 
end
if s3 ~=s4 then
if i2 then 
t2.transferItem(s3,s4,1,f,i2)
else
t2.transferItem(s3,s4,1,f)
end
end
end
ss=1
for i=0,1 do
dat=mn.getAllStacks(i).getAll()
for j,k in pairs(dat) do
a=typ(k)
if a >=1 and a <=4 then 
is=i
mn.transferItem(i,i,64,j,#dat -(a -1))
elseif a==0 then
mn.transferItem(i,its,64,j,1)
end
end
if not is then
ss=0
end
end
tra(0,tp,to,1,mn,is,1,nil)
tra(1,bt,bo,0,mn,is,1,nil)
mn.transferItem(mi,is,nil,1)
if not (tp and mn and bt and its and mi and ss ~=is) then 
error('no press ' .. mi .. " " .. is .. " " .. its .. " " .. ss)
end
computer.beep(900,0.1)
prcd=-1
tcprs=17
tecrec=0
ppres=0
prms={}
function proc()
dat=mn.getAllStacks(is).getAll()
ms={[17]=1,[ppres]=1}
chg=false
for i,j in pairs(dat) do
a=typ(j)
if a ~=17 then
if a==0 then
mn.transferItem(is,its,64,i)
elseif a >=1 and a <=4 then
if #dat -(a -1) ~=i then
mn.transferItem(is,is,64,i,#dat -(a -1))
end
ms[a]=#dat -(a -1) 
else 
ms[a]=i
if (prms[a]==nil) ~=(ms[a]==nil) then
chg=true
end
end
end
end
prms=ms
for i,j in pairs(rec) do
if ms[j[1]] and ms[j[2]] and ms[j[3]] then
if tecrec==i or prcd==0 then
if prcd==0 then
a=typ(tp.getStackInSlot(0,1))
if a ~=17 and a ~=j[1] then
tra(0,tp,to,1,mn,is,1,nil)
ppres=0
end
a=typ(bt.getStackInSlot(1,1))
if a ~=17 and a ~=j[1] then
tra(1,bt,bo,0,mn,is,1,nil)
end
end
if j[1] ~=17 then
tra(is,mn,1,to,tp,0,ms[j[1]],nil)
if j[1] > 0 and j[1] < 5 then
ppres=j[1]
end
end
if j[3] ~=17 then
tra(is,mn,0,bo,bt,1,ms[j[3]],nil)
end
if j[2] ~=17 then
mn.transferItem(is,mi,1,ms[j[2]],1)
end
prcd=prcd+1
tecrec=i
return
end
end
end
if not chg then
computer.pullSignal(1)
end
end
while true do 
computer.pullSignal(0.7)
if prcd ~=0 then
a=typ(mn.getStackInSlot(mi,2))
if a ~=17 then
prcd=prcd -mn.transferItem(mi,its,nil,2)
end
if prcd < 0 then 
prcd=0
end
end
proc()
end 