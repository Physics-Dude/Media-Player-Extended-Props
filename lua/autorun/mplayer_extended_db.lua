AddCSLuaFile()

if(not MediaPlayer) then
  ErrorNoHalt( "MP-Extended [DBA]: Base media player not loaded!\n" )
  ErrorNoHalt( "MP-Extended [DBA]: https://github.com/samuelmaddock/gm-mediaplayer\n" )
  return
end

local function SetFacePosition(ent, anc, nrm, pos, ang)
  if(not (ent and ent:IsValid())) then return end
  local norm, epos = Vector(nrm), ent:GetPos()
  local vobb = ent:OBBCenter(); norm:Normalize()
  local cang = (ang and Angle(ang) or Angle(0,0,0))
  local vpos = (pos and Vector(pos) or Vector())
  local righ = (vpos - anc):Cross(norm)
  local rang = norm:Cross(righ):AngleEx(norm)
  local tang = ent:AlignAngles(ent:LocalToWorldAngles(cang), rang)
  tang:Normalize(); tang:RotateAroundAxis(norm, 180)
  ent:SetAngles(tang); vobb:Negate() -- Reverse OBB
  -- Apply the angle as long as it is ready and point to position
  local drbb = ent:OBBMaxs(); drbb:Sub(ent:OBBMins()) -- Diagonal vector
  local drdt = ent:WorldToLocal(norm + epos) -- Make the normal vector local
  local marg = math.abs(drbb:Dot(drdt) / 2) -- Grab half of entity width
  vobb:Rotate(tang); vobb:Add(norm * marg) -- Convert to world-space
  local tpos = Vector(vobb); tpos:Add(pos) -- Use OBB offset
  ent:SetPos(tpos) -- Apply the calculated position on the screen
end

local function AddMediaPlayerModel( name, model, config)
  if util.IsValidModel( model ) then
    list.Set( "SpawnableEntities", model, {
      PrintName      = name,
      Information    = name,
      Spawnable      = true,
      AdminSpawnable = true,
      DropToFloor    = true,
      Editable       = true,
      Type           = "anim",
      Contact        = "physicsdude@anywhere.com",
      IconOverride   = "materials/spawnicons/"..model:sub(1, -5)..".png",
      Author         = "Physics Dude",
      KeyValues      = { model = model },
      ClassName      = "mediaplayer_tv_ext",
      Base           = "mediaplayer_base",
      Category       = "Media Player - Extended",
      Instructions   = "Right click on the TV to see available Media Player options."
                         .." Alternatively, press E on the TV to turn it on."
    } )

    -- Make a difference between regular models and extended models
    config.extended = true

    list.Set( "MediaPlayerModelConfigs", model, config )
  end
end

-- TV-esque models from Garry's Mod "Bulder" props
AddMediaPlayerModel(
  "Plate TV (05x075)",
  "models/hunter/plates/plate05x075.mdl",
  {
    angle  = Angle(0, 90, 0), -- Screen offset angle according to the base prop
    offset = Vector(-12.11, 23.98, 1.75), -- Forward/Back | Left/Right | Up/Down
    width  = 36.09, -- Screen width size for aspect ratio
    height = 24.22, -- Screen height size for aspect ratio
    aface  = Angle(-90,0,0) -- Model custom angle for facing the player when spawned
  }
)
          
AddMediaPlayerModel(
  "Plate TV (075x1)",
  "models/hunter/plates/plate075x1.mdl",
  {
    angle  = Angle(0, 90, 0),
    offset = Vector(-23.98, 23.97, 1.75),
    width  = 47.95,
    height = 36.09,
    aface  = Angle(-90,0,0)
  }
)

AddMediaPlayerModel(
  "Plate TV (1x2)",
  "models/hunter/plates/plate1x2.mdl",
  {
    angle  = Angle(0, 90, 0),
    offset = Vector(-23.98, 47.7, 1.75),
    width  = 95.4,
    height = 47.95,
    aface  = Angle(-90,0,0)
  }
)

AddMediaPlayerModel(
  "Plate TV (2x3)",
  "models/hunter/plates/plate2x3.mdl",
  {
    angle  = Angle(0, 90, 0),
    offset = Vector(-47.7, 71.42, 1.75),
    width  = 142.85,
    height = 95.4,
    aface  = Angle(-90,0,0)
  }
)

AddMediaPlayerModel(
  "Plate TV (2x4)",
  "models/hunter/plates/plate2x4.mdl",
  {
    angle  = Angle(0, 90, 0),
    offset = Vector(-47.7, 95.15, 1.75),
    width  = 190.3,
    height = 95.4,
    aface  = Angle(-90,0,0)
  }
)

AddMediaPlayerModel(
  "Plate TV (3x4)",
  "models/hunter/plates/plate3x4.mdl",
  {
    angle  = Angle(0, 90, 0),
    offset = Vector(-71.43, 95.15, 1.75),
    width  = 190.3,
    height = 142.85,
    aface  = Angle(-90,0,0)
  }
)

AddMediaPlayerModel(
  "Plate TV (3x5)",
  "models/hunter/plates/plate3x5.mdl",
  {
    angle  = Angle(0, 90, 0),
    offset = Vector(-71.43, 118.87, 1.75),
    width  = 237.75,
    height = 142.85,
    aface  = Angle(-90,0,0)
  }
)

AddMediaPlayerModel(
  "Plate TV (4x7)",
  "models/hunter/plates/plate4x7.mdl",
  {
    angle  = Angle(0, 90, 0),
    offset = Vector(-95.15, 166.32, 1.75),
    width  = 332.65,
    height = 190.3,
    aface  = Angle(-90,0,0)
  }
)

AddMediaPlayerModel(
  "Plate TV (4x8)",
  "models/hunter/plates/plate4x8.mdl",
  {
    angle  = Angle(0, 90, 0),
    offset = Vector(-95.15, 190.05, 1.75),
    width  = 380.1,
    height = 190.3,
    aface  = Angle(-90,0,0)
  }
)
--[[
-- default mediaplayer dont overwrite!!!
AddMediaPlayerModel(
  "Plate TV (5x8)",
  "models/hunter/plates/plate5x8.mdl",
  {
    angle  = Angle(0, 90, 0),
    offset = Vector(-118.8, 189.8, 2.5),
    width  = 380,
    height = 238
  }
)
]]--
AddMediaPlayerModel(
  "Plate TV (8x16)",
  "models/hunter/plates/plate8x16.mdl",
  {
    angle  = Angle(0, 90, 0),
    offset = Vector(-190.05, 379.85, 2.5),
    width  = 759.7,
    height = 380.1,
    aface  = Angle(-90,0,0)
  }
)

AddMediaPlayerModel(
  "Plate XL (16x24)",
  "models/hunter/plates/plate16x24.mdl",
  {
    angle  = Angle(0, 90, 0),
    offset = Vector(-379.85, 569.65, 3),
    width  = 1139.3,
    height = 769.7,
    aface  = Angle(-90,0,0)
  }
)

AddMediaPlayerModel(
  "Plate XL (24x32)",
  "models/hunter/plates/plate24x32.mdl",
  {
    angle  = Angle(0, 90, 0),
    offset = Vector(-569.95, 759.45, 3),
    aface  = Angle(-90,0,0),
    width  = 1518.9,
    height = 1139.3,
    aface  = Angle(-90,0,0)
  }
)
--[[
-- Useless builder prop sizes
AddMediaPlayerModel(
  "Plate TV (025x025)",
  "models/hunter/plates/plate025x025.mdl",
  {
    angle  = Angle(0, 90, 0),
    offset = Vector(-6.18, 6.18, 1.75),
    width  = 12.36,
    height = 12.36
  }
)

AddMediaPlayerModel(
  "Plate TV (025x05)",
  "models/hunter/plates/plate025x05.mdl",
  {
    angle  = Angle(0, 90, 0),
    offset = Vector(-6.18, 12.11, 1.75),
    width  = 24.22,
    height = 12.36
  }
)

AddMediaPlayerModel(
  "Plate TV (05x05)",
  "models/hunter/plates/plate05x05.mdl",
  {
    angle  = Angle(0, 90, 0),
    offset = Vector(-12.11, 12.11, 1.75),
    width  = 24.23,
    height = 24.23
  }
)

AddMediaPlayerModel(
  "Plate TV (5x7)",
  "models/hunter/plates/plate5x7.mdl",
  {
    angle  = Angle(0, 90, 0),
    offset = Vector(-118.88, 166.32, 1.75),
    width  = 332.65,
    height = 237.75
  }
)

AddMediaPlayerModel(
  "Plate TV (3x6)",
  "models/hunter/plates/plate3x6.mdl",
  {
    angle  = Angle(0, 90, 0),
    offset = Vector(-71.43, 142.6, 1.75),
    width  = 285.20,
    height = 142.85
  }
)

AddMediaPlayerModel(
  "Plate TV (4x6)",
  "models/hunter/plates/plate4x6.mdl",
  {
    angle  = Angle(0, 90, 0),
    offset = Vector(-95.15, 142.6, 1.75),
    width  = 285.20,
    height = 190.3
  }
)

AddMediaPlayerModel(
  "Plate TV (2x2)",
  "models/hunter/plates/plate2x2.mdl",
  {
    angle  = Angle(0, 90, 0),
    offset = Vector(-47.7, 47.7, 1.75),
    width  = 95.4,
    height = 95.4
  }
)

AddMediaPlayerModel(
  "Plate TV (1x1)",
  "models/hunter/plates/plate1x1.mdl",
  {
    angle  = Angle(0, 90, 0),
    offset = Vector(-23.98, 23.98, 1.75),
    width  = 47.95,
    height = 47.95
  }
)

AddMediaPlayerModel(
  "Plate TV (6x8)",
  "models/hunter/plates/plate6x8.mdl",
  {
    angle  = Angle(0, 90, 0),
    offset = Vector(-142.6, 190.05, 1.75),
    width  = 380.10,
    height = 285.20
  }
)]]--

--[[TV-esque models from Garry's Mod and Mounted Source Games]]--
AddMediaPlayerModel(
  "(Gmod) TV Standard",
  "models/props_c17/tv_monitor01.mdl",
  {
    angle  = Angle(-90, 90, 0),
    offset = Vector(7.28-1.75, 11.21-1.75, 8.28-2.25),
    width  = 15,
    height = 11
  }
)

AddMediaPlayerModel( --some other source game
  "(Gmod) TV Large",
  "models/props_debris/tv_monitor01.mdl",
  {
    angle  = Angle(-90, 90, 0),
    offset = Vector(10.76-0.3, 17.60-4, 12.87-4),
    width  = 22,
    height = 17
  }
)

AddMediaPlayerModel(
  "(Gmod) Citizen Radio",
  "models/props_lab/citizenradio.mdl",
  {
    angle  = Angle(-90, 90, 0),
    offset = Vector(9.41-0.9, 14.28-8.25, 17.36-1.75),
    width  = 17.5,
    height = 4
  }
)

AddMediaPlayerModel(
  "(Gmod) CRT Monitor",
  "models/props_lab/monitor01a.mdl",
  {
    angle  = Angle(-86, 90, 0),
    offset = Vector(13.69-1.88,11.78-2.3,13.62-2.3),
    width  = 19,
    height = 15.3
  }
)

AddMediaPlayerModel(
  "(Gmod) CRT Monitor 2",
  "models/props_lab/monitor02.mdl",
  {
    angle  = Angle(-82, 90, 0),
    offset = Vector(10.1,11.78-2.3,24.8-2.2),
    width  = 19,
    height = 15
  }
)

AddMediaPlayerModel(
  "(Gmod) Mini TV",
  "models/props_lab/monitor01b.mdl",
  {
    angle  = Angle(-89, 90, 0),
    offset = Vector(6.86-0.6,7.45-2,6.8-1.85),
    width  = 9,
    height = 9
  }
)

AddMediaPlayerModel(
  "(Gmod) PC Monitor TV",
  "models/props_interiors/computer_monitor.mdl",
  {
    angle  = Angle(-90, 90, 0),
    offset = Vector(3.3,13-2.5,27-2.2),
    width  = 21,
    height = 16
  }
)

AddMediaPlayerModel( --other
  "(Gmod) Microwave",
  "models/props/cs_office/microwave.mdl",
  {
    angle  = Angle(0, 180, 90),
    offset = Vector(16-2.4,-11+0.5,17-3),
    width  = 18,
    height = 11
  }
)

AddMediaPlayerModel( --other
  "(GMod) TV Console",
  "models/props/cs_militia/tv_console.mdl",
  {
    angle  = Angle(-90, 90, 0),
    offset = Vector(21.5,43-17,48-4),
    width  = 52,
    height = 36
  }
)

AddMediaPlayerModel( --other
  "(GMod) Big TV Console",
  "models/props/cs_militia/television_console01.mdl",
  {
    angle  = Angle(-90, 90, 0),
    offset = Vector(13.5,22,55.5),
    width  = 44,
    height = 33
  }
)

AddMediaPlayerModel( --gmod
  "(GMod) PC Monitor",
  "models/props_office/computer_monitor_01.mdl",
  {
    angle  = Angle(-90, 90, 0),
    offset = Vector(3.4,14.11-2.5,25.50-2.5),
    width  = 23,
    height = 17
  }
)

AddMediaPlayerModel( --gmod
  "(GMod) Portal Radio",
  "models/props/radio_reference.mdl",
  {
    angle  = Angle(-90, 90, 0),
    offset = Vector(3.6,2,5),
    width  = 4,
    height = 3
  }
)

--[[TV-esque models from "Wiremod"]]--
AddMediaPlayerModel( --wiremod
  "(Wire) 4:3 TV",
  "models/blacknecro/tv_plasma_4_3.mdl",
  {
    angle  = Angle(-90, 90, 0),
    offset = Vector(0.13,30.10-2,25.5-4),
    width  = 56,
    height = 43
  }
)

AddMediaPlayerModel( --wiremod
  "(Wire) Monitor Big",
  "models/kobilica/wiremonitorbig.mdl",
  {
    angle  = Angle(-90, 90, 0),
    offset = Vector(0.13,13.5-2,26.43-2),
    width  = 23,
    height = 23
  }
)

AddMediaPlayerModel( --wiremod
  "(Wire) Monitor Small",
  "models/kobilica/wiremonitorsmall.mdl",
  {
    angle  = Angle(-90, 90, 0),
    offset = Vector(0.13,5.25-0.75,10.26-0.75),
    width  = 9,
    height = 9
  }
)
--[[TV-esque models from "[Final] Steventechno's Electronics Pack!"]]--
AddMediaPlayerModel( --stevventechno
  "(Steventechno) Monitor",
  "models/computerpack/monitor.mdl",
  {
    angle  = Angle(-90, 90, 0),
    offset = Vector(-7.2,16.42-1,20.63-0.9),
    width  = 31,
    height = 16
  }
)

AddMediaPlayerModel( --stevventechno
  "(Steventechno) TV 2a",
  "models/electronicspack/bigscreen.mdl",
  {
    angle  = Angle(-90, 90, 0),
    offset = Vector(-9.55,40.25-2.75,46.38-2.3),
    width  = 78.7,
    height = 39
  }
)

AddMediaPlayerModel( --stevventechno
  "(Steventechno) TV 2b",
  "models/electronicspack/bigscreennomount.mdl",
  {
    angle  = Angle(-90, 90, 0),
    offset = Vector(-9.55,40.25-2.75,46.38-2.3),
    width  = 78.7,
    height = 39
  }
)

AddMediaPlayerModel( --stevventechno
  "(Steventechno) TV",
  "models/electronicspack/general_electronics/tv/crt/0_1tvlarge1.mdl",
  {
    angle  = Angle(-90, 90, 0),
    offset = Vector(-0.1,46.33-3,78.59-3),
    width  = 87,
    height = 44
  }
)

AddMediaPlayerModel( --stevventechno
  "(Steventechno) TV 3a",
  "models/electronicspack/general_electronics/tv/lcd/1_0tvlarge1.mdl",
  {
    angle  = Angle(-90, 90, 0),
    offset = Vector(-12,47.61-2.7,55.01-2.7),
    width  = 90,
    height = 40
  }
)

AddMediaPlayerModel( --stevventechno
  "(Steventechno) TV 3b",
  "models/electronicspack/general_electronics/tv/lcd/1_1tvlarge1_nomnt.mdl",
  {
    angle  = Angle(-90, 90, 0),
    offset = Vector(-0.5,47.61-2.5,46.6-1.3),
    width  = 90,
    height = 40
  }
)

AddMediaPlayerModel( --stevventechno
  "(Steventechno) TV 4a",
  "models/electronicspack/general_electronics/tv/lcd/1_2tvlarge2.mdl",
  {
    angle  = Angle(-90, 90, 0),
    offset = Vector(-16.5,72.18-2.6,81.85-2.6),
    width  = 139,
    height = 66
  }
)

AddMediaPlayerModel( --stevventechno
  "(Steventechno) TV 4b",
  "models/electronicspack/general_electronics/tv/lcd/1_3tvlarge2_nomnt.mdl",
  {
    angle  = Angle(-90, 90, 0),
    offset = Vector(-0.2,72.18-2.6,73.85-2.6),
    width  = 139,
    height = 66
  }
)

AddMediaPlayerModel( --stevventechno
  "(Steventechno) TV 1a",
  "models/electronicspack/general_electronics/tv/lcd/1_4tv_small.mdl",
  {
    angle  = Angle(-90, 90, 0),
    offset = Vector(-8,25-2,33-1),
    width  = 47,
    height = 25
  }
)

AddMediaPlayerModel( --stevventechno
  "(Steventechno) TV 1b",
  "models/electronicspack/general_electronics/tv/lcd/1_5tv_small_nomnt.mdl",
  {
    angle  = Angle(-90, 90, 0),
    offset = Vector(0,25-1.5,27-0.9),
    width  = 47,
    height = 25
  }
)

AddMediaPlayerModel( --stevventechno
  "(Steventechno) Laptop",
  "models/laptop/laptop.mdl",
  {
    angle  = Angle(-75, 90, 0),
    offset = Vector(-9.6,10-1,15-0.9),
    width  = 19,
    height = 12
  }
)

AddMediaPlayerModel( --stevventechno
  "(Steventechno) Retro",
  "models/electronicspack/general_electronics/tv/crt/0_2_tv_small.mdl",
  {
    angle  = Angle(-90, 90, 0),
    offset = Vector(-1,15,26),
    width  = 30,
    height = 21.5
  }
)

--[[TV-esque models from "RolePlay Props Extended"]]--
AddMediaPlayerModel( --other
  "(RP) Macbook",
  "models/testmodels/macbook_pro.mdl",
  {
    angle  = Angle(-76.5, 90, 0),
    offset = Vector(-10.6,13-0.1,18-0.3),
    width  = 26,
    height = 17
  }
)

AddMediaPlayerModel( --other
  "(RP) iMac",
  "models/testmodels/apple_display.mdl",
  {
    angle  = Angle(-85, 90, 0),
    offset = Vector(1,21-0.25,25-1),
    width  = 41,
    height = 23
  }
)

AddMediaPlayerModel( --other
  "(RP) Suite TV",
  "models/gmod_tower/suitetv.mdl",
  {
    angle  = Angle(-90, 90, 0),
    offset = Vector(1,28-2,37-2),
    width  = 52,
    height = 28
  }
)

AddMediaPlayerModel( --other
  "(RP) Plasma TV",
  "models/u4lab/tv_monitor_plasma.mdl",
  {
    angle  = Angle(-90, 90, 0),
    offset = Vector(5,59-14,67-5),
    width  = 90,
    height = 58
  }
)

--[[TV-esque models from "SProps"]]--
AddMediaPlayerModel( --sprops
  "[SProps] Micro 6x6",
  "models/sprops/rectangles/size_1_5/rect_6x6x3.mdl",
  {
    angle  = Angle(0, 90, 0),
    offset = Vector(-3, 3, 1.75),
    aface  = Angle(-90,0,0),
    width  = 6,
    height = 6
  }
)

AddMediaPlayerModel( --sprops
  "[SProps] Mini 6x12",
  "models/sprops/rectangles/size_1_5/rect_6x12x3.mdl",
  {
    angle  = Angle(0, 180, 0),
    offset = Vector(6, 3, 1.75),
    aface  = Angle(-90,90,0),
    width  = 12,
    height = 6
  }
)

AddMediaPlayerModel( --sprops
  "[SProps] Small 12x18",
  "models/sprops/rectangles/size_2/rect_12x18x3.mdl",
  {
    angle  = Angle(0, -180, 0),
    offset = Vector(9, 6, 1.75),
    aface  = Angle(-90,90,0),
    width  = 18,
    height = 12
  }
)

AddMediaPlayerModel( --sprops
  "[SProps] Small 24x36",
  "models/sprops/rectangles/size_3/rect_24x36x3.mdl",
  {
    angle  = Angle(0, -180, 0),
    offset = Vector(18, 12, 1.75),
    aface  = Angle(-90,90,0),
    width  = 36,
    height = 24
  }
)

AddMediaPlayerModel( --sprops
  "[SProps] Small 36x60",
  "models/sprops/rectangles/size_4/rect_36x60x3.mdl",
  {
    angle  = Angle(0, 180, 0),
    offset = Vector(30, 18, 1.75),
    aface  = Angle(-90,90,0),
    width  = 60,
    height = 36
  }
)

AddMediaPlayerModel( --sprops
  "[SProps] Small 60x96",
  "models/sprops/rectangles/size_60/rect_60x96x3.mdl",
  {
    angle  = Angle(0, 180, 0),
    offset = Vector(48, 30, 1.75),
    aface  = Angle(-90,90,0),
    width  = 96,
    height = 60
  }
)

AddMediaPlayerModel( --sprops
  "[SProps] Small 96x144",
  "models/sprops/rectangles/size_6/rect_96x144x3.mdl",
  {
    angle  = Angle(0, 180, 0),
    offset = Vector(72, 48, 1.75),
    aface  = Angle(-90,90,0),
    width  = 144,
    height = 96
  }
)

AddMediaPlayerModel( --sprops
  "[SProps] XL 144x240",
  "models/sprops/rectangles/size_7/rect_144x240x3.mdl",
  {
    angle  = Angle(0, 180, 0),
    offset = Vector(120, 72, 2),
    aface  = Angle(-90,90,0),
    width  = 240,
    height = 144
  }
)

AddMediaPlayerModel( --sprops
  "[SProps] XL 192x288",
  "models/sprops/rectangles/size_8/rect_192x288x3.mdl",
  {
    angle  = Angle(0, 180, 0),
    offset = Vector(144, 96, 2),
    aface  = Angle(-90,90,0),
    width  = 288,
    height = 192
  }
)

AddMediaPlayerModel( --sprops
  "[SProps] XL 240x384",
  "models/sprops/rectangles/size_9/rect_240x384x3.mdl",
  {
    angle  = Angle(0, 180, 0),
    offset = Vector(192, 120, 2),
    aface  = Angle(-90,90,0),
    width  = 384,
    height = 240
  }
)

AddMediaPlayerModel( --sprops
  "[SProps] XL 480x288",
  "models/sprops/rectangles/size_10/rect_480x288x3.mdl",
  {
    angle  = Angle(0, 90, 0),
    offset = Vector(-144, 240, 2),
    aface  = Angle(-90,0,0),
    width  = 480,
    height = 288
  }
)

--[[TV-esque models from "1950s Pack" and "1950s Pack 2"]]--
AddMediaPlayerModel( --1950s 2
  "(1950s Pack) Small TV",
  "models/polievka/televisionsmall.mdl",
  {
    angle  = Angle(-90, 90, 0),
    offset = Vector(12,11,22),
    width  = 22,
    height = 18
  }
)

AddMediaPlayerModel( --1950s
  "(1950s Pack) Big TV",
  "models/polievka/televisionpolievka.mdl",
  {
    angle  = Angle(90, -90, 0),
    offset = Vector(-20.5,11,41.5),
    width  = 20,
    height = 20
  }
)

AddMediaPlayerModel( --1950s
  "(1950s Pack) HiFi",
  "models/polievka/1950shifi.mdl",
  {
    angle  = Angle(0, 90, 0),
    offset = Vector(-8,19,15.5),
    width  = 16,
    height = 9
  }
)

AddMediaPlayerModel( --1950s
  "(1950s Pack) Radio",
  "models/polievka/radiopolievka.mdl",
  {
    angle  = Angle(180, 0, -90),
    offset = Vector(3,-7.25,-1.5),
    width  = 6,
    height = 3
  }
)

AddMediaPlayerModel( --1950s
  "(1950s Pack) Radio 2",
  "models/polievka/radiosquare.mdl",
  {
    angle  = Angle(-90, 90, 0),
    offset = Vector(4.1,3.2,-1.5),
    width  = 6.4,
    height = 3.5
  }
)

--[[TV-esque models from "Fallout 4: Devices pack"]]--
AddMediaPlayerModel( --Fallout 4: Devices pack
  "(Fallout 4) Round TV",
  "models/props/hightechtv01.mdl",
  {
    angle  = Angle(-90, 90, 0),
    offset = Vector(10,10.5,48),
    width  = 21,
    height = 16.5
  }
)

AddMediaPlayerModel( --Fallout 4: Devices pack
  "(Fallout 4) Terminal",
  "models/props/insterminal01.mdl",
  {
    angle  = Angle(-90, 90, -8),
    offset = Vector(4.8,4.3-0.5,21-0.5),
    width  = 8,
    height = 8
  }
)

AddMediaPlayerModel( --Fallout 4: Devices pack
  "(Fallout 4) Terminal2",
  "models/props/insterminalonwall.mdl",
  {
    angle  = Angle(-90, 90, -8),
    offset = Vector(10.8,4.3-0.5,33.5-0.5),
    width  = 8,
    height = 8
  }
)

AddMediaPlayerModel( --Fallout 4: Devices pack
  "(Fallout 4) Radio",
  "models/props/prewarradio.mdl",
  {
    angle  = Angle(-90, 90, 0),
    offset = Vector(7.5,1.5,9.5),
    width  = 3,
    height = 2
  }
)

AddMediaPlayerModel( --Fallout 4: Devices pack
  "(Fallout 4) TV",
  "models/props/prewartv01.mdl",
  {
    angle  = Angle(-90, 89, 0),
    offset = Vector(6,8,53),
    width  = 16,
    height = 12
  }
)

AddMediaPlayerModel( --Fallout 4: Devices pack
  "(Fallout 4) TV 2",
  "models/props/prewartv02.mdl",
  {
    angle  = Angle(-90, 89, 0),
    offset = Vector(6,8,29),
    width  = 16,
    height = 12
  }
)

AddMediaPlayerModel( --Fallout 4: Devices pack
  "(Fallout 4) Flatscreen",
  "models/props/insflatscreen01.mdl",
  {
    angle  = Angle(-90, 90, 0),
    offset = Vector(0.5,24.5,27.5),
    width  = 49,
    height = 26
  }
)

AddMediaPlayerModel( --Fallout 4: Devices pack
  "(Fallout 4) Flatscreen2",
  "models/props/insflatscreen02.mdl",
  {
    angle  = Angle(-90, 90, 0),
    offset = Vector(0.5,24.5,52),
    width  = 49,
    height = 50
  }
)

--[[TV-esque models from "Retro Television" pack]]--
AddMediaPlayerModel( --Retro
  "(Retro TV) Small TV",
  "models/retrotelevision/retromonitor.mdl",
  {
    angle  = Angle(-90, 90, 0),
    offset = Vector(5.5,7.25,23.5),
    width  = 15,
    height = 10
  }
)

AddMediaPlayerModel( --Retro
  "(Retro TV) Big TV",
  "models/retrotelevision/retrostandingmonitor.mdl",
  {
    angle  = Angle(-90, 90, 0),
    offset = Vector(5.5,7.25,49),
    width  = 15,
    height = 10
  }
)

--[[TV-esque models from "[HALF-LIFE: ALYX] HL:A Computer Prop pack." pack]]--
AddMediaPlayerModel( --ALYX
  "(HL:A) Monitor",
  "models/hlaofficeprops/server_08.mdl",
  {
    angle  = Angle(0, 180, 84.5),
    offset = Vector(6.5,-8,14.2),
    width  = 13,
    height = 9,
    aface  = Angle(0,90,0)
  }
)

AddMediaPlayerModel( --ALYX
  "(HL:A) Monitor Dirty",
  "models/hlaofficeprops/server_08_dirty.mdl",
  {
    angle  = Angle(0, 180, 84.5),
    offset = Vector(6.5,-8,14.2),
    width  = 13,
    height = 9,
    aface  = Angle(0,90,0)
  }
)


-- Models from Snowdrop Escape --
AddMediaPlayerModel( --Soviet Lab
  "(Soviet Lab) Monitor 7",
  "models/props_se/propper/power_monitor_7.mdl",
  {
    angle  = Angle(0, 90, 82.5),
    offset = Vector(9.8,9,22.5),
    width  = 18,
    height = 15,
    aface  = Angle(0,90,0)
  }
)
AddMediaPlayerModel( --Soviet Lab
  "(Soviet Lab) Monitor 5",
  "models/props_se/propper/power_monitor_5.mdl",
  {
    angle  = Angle(0, 90, 85),
    offset = Vector(4.5,9.5,11.3),
    width  = 24,
    height = 15,
    aface  = Angle(0,90,0)
  }
)
AddMediaPlayerModel( --Soviet Lab
  "(Soviet Lab) Monitor 4",
  "models/props_se/propper/power_monitor_4.mdl",
  {
    angle  = Angle(0, 0, 90),
    offset = Vector(-9,6.5,9),
    width  = 18.5,
    height = 18,
    aface  = Angle(0,90,0)
  }
)

-- Models from Mobile Computing Pack --
AddMediaPlayerModel( --Mobile Computing Pack
  "(Mobile Computing) Cellphone",
  "models/lt_c/tech/cellphone.mdl",
  {
    angle  = Angle(0, 180, 0),
    offset = Vector(2.4,1.3,0.5),
    width  = 5,
    height = 2.7,
    aface  = Angle(0,90,0)
  }
)
AddMediaPlayerModel( --Mobile Computing Pack
  "(Mobile Computing) Tablet",
  "models/lt_c/tech/tablet_civ.mdl",
  {
    angle  = Angle(0, 90, 0),
    offset = Vector(-3.5,5.3,0.3),
    width  = 10,
    height = 7,
    aface  = Angle(0,90,0)
  }
)
AddMediaPlayerModel( --Mobile Computing Pack
  "(Mobile Computing) Tablet2",
  "models/nirrti/tablet/tablet_sfm.mdl",
  {
    angle  = Angle(0, 180, 0),
    offset = Vector(4.7,3.5,1.3),
    width  = 10,
    height = 7,
    aface  = Angle(0,90,0)
  }
)

if SERVER then
  -- Place mediaplayer toward player. This also fixes base mediaplayer behavior. Requested by Cyan.
  hook.Remove( "PlayerSpawnedSENT", "MediaPlayer.Extended.Setup" ) -- Remove hook and set a new one
  hook.Add( "PlayerSpawnedSENT", "MediaPlayer.Extended.Setup", function(ply, ent)
    if(not ent) then return end -- Skip missing entities from triggering spawns
    if(not ent:IsValid()) then return end -- Skip also invalid entities
    if(not ent.IsMediaPlayerEntity) then return end -- Not MP complaint
    local mod = ent:GetModel() -- Model is the list index hash
    local cnf = list.GetForEdit("MediaPlayerModelConfigs")[mod]

    -- Model does not persist in the list. Nothing to do
    if(not cnf) then return end

    -- Do nothing for other models and setup only ours
    if(not cnf.extended) then return end

    -- Fix for media player owner not getting set on alternate model spawn
    ent:SetCreator(ply)

    local mp = ent:GetMediaPlayer()
    if(mp) then mp:SetOwner(ply) end

    if(ply.AdvDupe2) then -- Do not rotate when pasting dupe
      if(ply.AdvDupe2.Pasting or ply.AdvDupe2.Downloading) then return end
    end

    -- Make sure we ignore the player and spawned entity for trace
    local dt = util.GetPlayerTrace(ply) -- Create trace data filtered
    dt.filter = {ply, ent} -- Otherwise we hit the player being spawned

    -- Run the trace with this filter and find real spawn position
    local tr = util.TraceLine(dt) -- Does not belong on the spawn entity

    if(not tr) then return end -- Trace does not exist
    if(not tr.Hit) then return end -- Trace did not hit anything

    SetFacePosition(ent, ply:EyePos(), tr.HitNormal, tr.HitPos, cnf.aface)
  end)
end

print("LOAD: Media Player - Extended")
