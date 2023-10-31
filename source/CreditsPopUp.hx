package;

import sys.FileSystem;
import flixel.group.FlxSpriteGroup;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.FlxObject;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.math.FlxMath;

typedef SongHeading = 
{
	var path:String;
	var antiAliasing:Bool;
}
class CreditsPopUp extends FlxSpriteGroup
{
	public var bg:FlxSprite;
	public var bgHeading:FlxSprite;

	public var funnyText:FlxText;

	public function new(x:Float, y:Float)
	{
		super(x, y);

		bg = new FlxSprite().makeGraphic(450, 100, FlxColor.GRAY);
		bg.alpha = 0.7;
		add(bg);

		var songCreator:String = '';
		var songArtist:String = '';
		var songCharter:String = '';

		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'tutorial' | 'bopeebo' | 'fresh' | 'dadbattle' | 'spookeez' | 'south' | 'monster' | 'pico' | 'philly' | 'blammed' | 'satin-panties' | 'high' | 'milf':
				songCreator = 'FNF Team';
				songArtist = 'FNF Team';
				songCharter = 'FNF Team';
		}

		createHeadingText('Song by ' + songCreator + '\n\n' + 'Art by ' + songArtist + '\n\n' + 'Charting by ' + songCharter);

		rescaleBG();

		var yValues = CoolUtil.getMinAndMax(bg.height, funnyText.height);
		funnyText.y = funnyText.y + ((yValues[0] - yValues[1]) / 2);
	}

	public function switchHeading()
	{
		bg = new FlxSprite().makeGraphic(450, 100, FlxColor.GRAY);
		bg.alpha = 0.7;
		add(bg);

		rescaleBG();
	}

	public function changeText(newText:String, rescaleHeading:Bool = true)
	{
		createHeadingText(newText);

		if (rescaleHeading)
		{
			rescaleBG();
		}
	}

	function createHeadingText(text:String)
	{
		if (funnyText != null)
		{
			remove(funnyText);
		}
		funnyText = new FlxText(1, 0, 650, text, 30);
		funnyText.setFormat('VCR OSD Mono', 30, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		funnyText.borderSize = 1.1;
		add(funnyText);
	}

	function rescaleBG()
	{
		bg.setGraphicSize(Std.int((funnyText.textField.textWidth)), Std.int(funnyText.height));
		bg.updateHitbox();
	}
}