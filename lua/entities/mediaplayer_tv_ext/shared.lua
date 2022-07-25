-- This file is used to design and test new props.

AddCSLuaFile()

DEFINE_BASECLASS( "mediaplayer_base" )

ENT.PrintName      = "Media player extended TV"
ENT.Author         = "Physics Dude"
ENT.Instructions   = "Right click on the TV to see available Media Player options. "
                       .." Alternatively, press E on the TV to turn it on."
ENT.Category       = "Media Player - Extended"
ENT.Type           = "anim"
ENT.Base           = "mediaplayer_base"
ENT.Contact        = "physicsdude@anywhere.com"
ENT.Editable       = true
ENT.Spawnable      = true
ENT.AdminSpawnable = true
ENT.RenderGroup    = RENDERGROUP_BOTH
ENT.Information    = ENT.PrintName

-- MAGIC sauce for testing new models rapidly

ENT.Model = Model( "models/props_lab/huladoll.mdl" )
list.Set( "MediaPlayerModelConfigs", ENT.Model, {
    angle  = Angle(-90, 90, 0),
    offset = Vector(0,8,15),
    width  = 16,
    height = 9
})

-- END MAGIC sauce for testing new models rapidly

function ENT:SetupDataTables()
  self:NetworkVar("String", 0, "MediaPlayerID", {
    KeyName = string.lower("MediaPlayerID"),
    Edit = {
      category     = "Internals",
      order        = 0,
      enabled      = false,
      waitforenter = true,
      type         = "Generic"
  }})

  self:NetworkVar("String", 1, "MediaThumbnail", {
    KeyName = string.lower("MediaThumbnail"),
    Edit = {
      category     = "Internals",
      order        = 1,
      enabled      = false,
      waitforenter = true,
      type         = "Generic"
  }})
end

if SERVER then

  function ENT:SetupMediaPlayer( mp )
    mp:on("mediaChanged", function(media) self:OnMediaChanged(media) end)
  end

  function ENT:OnMediaChanged( media )
    self:SetMediaThumbnail( media and media:Thumbnail() or "" )
  end

else -- CLIENT

  local DrawHTMLMaterial = DrawHTMLMaterial
  local varthumb = MediaPlayer.Cvars.DrawThumbnails
  local artstyle = 'htmlmat.style.artwork_blur'
  local matstatic = Material( "theater/STATIC" )
  local textscale, align = 700, TEXT_ALIGN_CENTER

  AddHTMLMaterialStyle( artstyle, {
    width = 720, height = 480
  }, HTMLMAT_STYLE_BLUR )

  function ENT:DrawMediaPlayerOff()
    local w, h, pos, ang = self:GetMediaPlayerPosition()
    local thumbnail, sca = self:GetMediaThumbnail(), (w / textscale)

    cam.Start3D2D( pos, ang, 1 )
      if varthumb:GetBool() and thumbnail != "" then
        DrawHTMLMaterial( thumbnail, artstyle, w, h )
      else
        surface.SetDrawColor( color_white )
        surface.SetMaterial( matstatic )
        surface.DrawTexturedRect( 0, 0, w, h )
      end
    cam.End3D2D()

    cam.Start3D2D( pos, ang, sca )
      local tw, th = (w / sca), (h / sca)
      draw.SimpleText( "Press E to begin watching", "MediaTitle",
        tw / 2, th / 2, color_white, align, align )
    cam.End3D2D()
  end

  function ENT:Draw()
    self:DrawModel()

    local mp = self:GetMediaPlayer()

    if mp then
      mp:Draw()
    else
      self:DrawMediaPlayerOff()
    end
  end

end
