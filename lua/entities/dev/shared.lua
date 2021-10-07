-- This file is used to design and test new props.

AddCSLuaFile()

DEFINE_BASECLASS( "mediaplayer_base" )
ENT.PrintName 		= "Test TV"
ENT.Author 			= "Physics Dude"
ENT.Instructions 	= "Right click on the TV to see available Media Player options. Alternatively, press E on the TV to turn it on."
ENT.Category 		= "Other"
ENT.Type = "anim"
ENT.Base = "mediaplayer_base"
ENT.Model = Model( "models/props_lab/huladoll.mdl" )
ENT.OBMin = Vector(-3,-9, -0.5)
ENT.OBMax = Vector( 3, 9, 15.5)
ENT.RenderGroup = RENDERGROUP_BOTH
ENT.Spawnable = true

--[[----------------------------------- MAGIC sauce for testing new models rapidly  -----------------------------------]]--

list.Set( "MediaPlayerModelConfigs", ENT.Model, {
		angle = Angle(-90, 90, 0),
		offset = Vector(0,8,15),-- Forward/Back | Left/Right | Up/Down 
		width = 16,
		height = 9
} )

--[[----------------------------------- END MAGIC sauce for testing new models rapidly -----------------------------------]]--

function ENT:GetAngleSpawn(ply)
  local yaw = (ply:GetAimVector():Angle().y + 180) % 360
  local ang = Angle(0, yaw, 0); ang:Normalize(); return ang
end

function ENT:GetPositionSpawn(tr)
	local pos = Vector(tr.HitNormal)
	      pos:Mul(math.abs(self:OBBMins().z))
	      pos:Add(tr.HitPos)
	return pos
end

function ENT:SetupDataTables()
	BaseClass.SetupDataTables( self )

	self:NetworkVar( "String", 1, "MediaThumbnail" )
end

if SERVER then

	function ENT:SetupMediaPlayer( mp )
		mp:on("mediaChanged", function(media) self:OnMediaChanged(media) end)
	end

	function ENT:OnMediaChanged( media )
		self:SetMediaThumbnail( media and media:Thumbnail() or "" )
	end

	function ENT:SpawnFunction(ply, tr)
	  if(not tr.Hit) then return end
	  local ent = ents.Create("gmod_custom_dev")
	  if(ent and ent:IsValid()) then
	    ent:EnableCustomCollisions(true)
	    ent:SetCustomCollisionCheck(true)
	    ent:SetCollisionGroup(COLLISION_GROUP_INTERACTIVE)
	    ent:SetCollisionBounds(self.OBMin, self.OBMax)
	  	ent:SetPos(ent:GetPositionSpawn(tr))
	    ent:SetAngles(ent:GetAngleSpawn(ply)) -- Appy angle after spawn
	    ent:SetSolid(SOLID_VPHYSICS)
	    ent:SetRenderMode(self.RenderGroup)
	    ent:SetMoveType(MOVETYPE_VPHYSICS)
	    ent:SetNotSolid(false)
	    ent:SetModel(self.Model)
	    ent:Spawn()
	    ent:SetCreator(ply)
	    ent:Activate()
	    return ent
	  end; return nil
	end

else -- CLIENT

	local draw = draw
	local surface = surface
	local Start3D2D = cam.Start3D2D
	local End3D2D = cam.End3D2D
	local DrawHTMLMaterial = DrawHTMLMaterial
	local drwthumb = MediaPlayer.Cvars.DrawThumbnails
	local TEXT_ALIGN_CENTER = TEXT_ALIGN_CENTER
	local color_white = color_white
	local style = 'htmlmat.style.artwork_blur'
	local matstatic = Material( "theater/STATIC" )
	local TextScale = 700

	AddHTMLMaterialStyle( style, {
		width = 720,
		height = 480
	}, HTMLMAT_STYLE_BLUR )

	function ENT:Draw()
		self:DrawModel()

		local mp = self:GetMediaPlayer()

		if not mp then
			self:DrawMediaPlayerOff()
		else
			mp:Draw(true, true)
		end
	end

	function ENT:DrawMediaPlayerOff()
		local w, h, pos, ang = self:GetMediaPlayerPosition()
		local thumbnail, sca = self:GetMediaThumbnail(), (w / TextScale)
		self:SetRenderBounds(self.OBMin, self.OBMax)

		Start3D2D( pos, ang, 1 )
			if drwthumb:GetBool() and thumbnail != "" then
				DrawHTMLMaterial( thumbnail, style, w, h )
			else
				surface.SetDrawColor( color_white )
				surface.SetMaterial( matstatic )
				surface.DrawTexturedRect( 0, 0, w, h )
			end
		End3D2D()

		Start3D2D( pos, ang, sca )
			local tw, th = w / sca, h / sca
			draw.SimpleText( "Press E to begin watching", "MediaTitle",
				tw / 2, th / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		End3D2D()
	end

end 
