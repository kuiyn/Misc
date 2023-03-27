local w,h = draw.GetScreenSize()

local IN_SCOREBOARD = false

local ranks = {
"白银 1",
"白银 2",
"白银 3",
"白银 4",
"白银 精英",
"白银 精英大师",

"黄金 1",
"黄金 2",
"黄金 3",
"黄金 4",

"单AK",
"麦穗",
"双AK",
"菊花",

"小老鹰",
"大老鹰",
"小地球",
"大地球"
}

local font = draw.CreateFont("Tahoma", 20, 450)

callbacks.Register("CreateMove", function(cmd)
local IN_SCORE = bit.lshift(1, 16)
IN_SCOREBOARD = bit.band(cmd.buttons, IN_SCORE) == IN_SCORE
end)

callbacks.Register("Draw", function()
if not engine.GetServerIP() then return end

if not engine.GetServerIP():gmatch("=[A:") then return end

if not gui.Reference("menu"):IsActive() and not IN_SCOREBOARD then return end

local y = h/2

for i, v in next, entities.FindByClass("CCSPlayer") do
if v:GetName() ~= "GOTV" and entities.GetPlayerResources():GetPropInt("m_iPing", v:GetIndex()) ~= 0 then
local index = v:GetIndex()
local rank_index = entities.GetPlayerResources():GetPropInt("m_iCompetitiveRanking", index)
local wins = entities.GetPlayerResources():GetPropInt("m_iCompetitiveWins", index)
local rank = ranks[rank_index] or "没有段位"
draw.SetFont(font)
draw.Color(210,210,210,255)
draw.Text(5, y, v:GetName().." - 段位: "..rank.." 胜利数: "..wins)
y = y + 30
end
end
end)
