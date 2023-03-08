so_create_hud_item(line, xoffset, message, alwaysdraw)
{
    if (isdefined(level.lua["so_create_hud_item"]))
    {
        func = level.lua["so_create_hud_item"];
        [[ func ]](line, xoffset, message, alwaysdraw);
        return level.luaret;
    }

    return newhudelem();
}

xp_score_init() {
	self.hud_rankscroreupdate = newclientHudElem( self );
	self.hud_rankscroreupdate.horzAlign = "center";
	self.hud_rankscroreupdate.vertAlign = "middle";
	self.hud_rankscroreupdate.alignX = "center";
	self.hud_rankscroreupdate.alignY = "middle";
	self.hud_rankscroreupdate.x = 0;
	self.hud_rankscroreupdate.y = -60;
	//self.hud_rankscroreupdate.font = "hudbig";
	self.hud_rankscroreupdate.font = "objective";
	self.hud_rankscroreupdate.fontscale = 1;
	self.hud_rankscroreupdate.archived = false;
	self.hud_rankscroreupdate.color = ( 1, 1, 0.65 );
	self.hud_rankscroreupdate fontPulseInit(3.0);

	self.rankUpdateTotal = 0;
}

add_xp(value) {
    self.rankUpdateTotal += value;
    self.hud_rankscroreupdate.label = "+";

	self.hud_rankscroreupdate setValue( self.rankUpdateTotal );
	self.hud_rankscroreupdate.alpha = 1;
	self.hud_rankscroreupdate thread fontPulse( self );

    wait 1;
	self.hud_rankscroreupdate fadeOverTime( 0.75 );
	self.hud_rankscroreupdate.alpha = 0;

	self.rankUpdateTotal = 0;
}

fontPulseInit(maxFontScale)
{
	self.baseFontScale = self.fontScale;
	if ( isDefined( maxFontScale ) )
		self.maxFontScale = min( maxFontScale, 6.3 );
	else
		self.maxFontScale = min( self.fontScale * 2, 6.3 );
	self.inFrames = 2;
	self.outFrames = 4;
}


fontPulse( player )
{
	self notify( "fontPulse" );
	self endon( "fontPulse" );
	self endon( "death" );
	
	player endon("disconnect");
	
	self ChangeFontScaleOverTime( self.inFrames * 0.05 );
	self.fontScale = self.maxFontScale;	
	wait self.inFrames * 0.05;
	
	self ChangeFontScaleOverTime( self.outFrames * 0.05 );
	self.fontScale = self.baseFontScale;
}