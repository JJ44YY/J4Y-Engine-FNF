package;

import Controls.KeyboardScheme;
import Controls.Control;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;

class OptionsMenu extends MusicBeatState
{
	var selector:FlxText;
	var curSelected:Int = 0;

	var controlsStrings:Array<String> = [];

	private var grpControls:FlxTypedGroup<Alphabet>;

	var inputStr:Array<String> = ["WASD", "DFJK", "ASKL", "ZX COMMA PERIOD"];

	override function create()
	{
		var menuBG:FlxSprite = new FlxSprite().loadGraphic(AssetPaths.menuDesat__png);
		controlsStrings = CoolUtil.coolStringFile(inputStr[FlxG.save.data.dfjk] + "\n" + (FlxG.save.data.newInput ? "Ghost Tapping" : "No Ghost Tapping") + "\n" + (FlxG.save.data.downscroll ? 'Downscroll' : 'Upscroll') + "\n" + (FlxG.save.data.scoreText ? 'Score Text Complex' : 'Score Text OG') + "\n" + (FlxG.save.data.songPosition ? 'Song Position Bar On' : 'Song Position Bar Off'));
		
		trace(controlsStrings);

		menuBG.color = 0xFFea71fd;
		menuBG.setGraphicSize(Std.int(menuBG.width * 1.1));
		menuBG.updateHitbox();
		menuBG.screenCenter();
		menuBG.antialiasing = true;
		add(menuBG);

		grpControls = new FlxTypedGroup<Alphabet>();
		add(grpControls);

		for (i in 0...controlsStrings.length)
		{
			var controlLabel:Alphabet = new Alphabet(0, (70 * i) + 30, controlsStrings[i], true, false);
			controlLabel.isMenuItem = true;
			controlLabel.targetY = i;
			grpControls.add(controlLabel);
		}

		super.create();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (controls.BACK)
			FlxG.switchState(new MainMenuState());
		if (controls.UP_P)
			changeSelection(-1);
		if (controls.DOWN_P)
			changeSelection(1);
			
		if (controls.ACCEPT)
		{
			if (curSelected != 5)
				grpControls.remove(grpControls.members[curSelected]);

			switch(curSelected)
			{
				case 0:
					FlxG.save.data.dfjk++;
					if (FlxG.save.data.dfjk > 3)
					{
						FlxG.save.data.dfjk = 0;
					}
						
					if (FlxG.save.data.dfjk == 1)
						controls.setKeyboardScheme(KeyboardScheme.Solo, true);
					else if (FlxG.save.data.dfjk == 2)
						controls.setKeyboardScheme(KeyboardScheme.The, true);
					else if (FlxG.save.data.dfjk == 3)
						controls.setKeyboardScheme(KeyboardScheme.Poop, true);
					else
						controls.setKeyboardScheme(KeyboardScheme.Duo(true), true);

					var inTxt:String = inputStr[FlxG.save.data.dfjk];

					var ctrl:Alphabet = new Alphabet(0, (70 * curSelected) + 30, inTxt, true, false);
					ctrl.isMenuItem = true;
					ctrl.targetY = curSelected;
					grpControls.add(ctrl);
				case 1:
					FlxG.save.data.newInput = !FlxG.save.data.newInput;
					var ctrl:Alphabet = new Alphabet(0, (70 * curSelected) + 30, (FlxG.save.data.newInput ? "Ghost Tapping" : "No Ghost Tapping"), true, false);
					ctrl.isMenuItem = true;
					ctrl.targetY = curSelected - 1;
					grpControls.add(ctrl);
				case 2:
					FlxG.save.data.downscroll = !FlxG.save.data.downscroll;
					var ctrl:Alphabet = new Alphabet(0, (70 * curSelected) + 30, (FlxG.save.data.downscroll ? 'Downscroll' : 'Upscroll'), true, false);
					ctrl.isMenuItem = true;
					ctrl.targetY = curSelected - 2;
					grpControls.add(ctrl);
				case 3:
					FlxG.save.data.scoreText = !FlxG.save.data.scoreText;
					var ctrl:Alphabet = new Alphabet(0, (70 * curSelected) + 30, (FlxG.save.data.scoreText ? 'Score Text Complex' : 'Score Text OG'), true, false);
					ctrl.isMenuItem = true;
					ctrl.targetY = curSelected - 3;
					grpControls.add(ctrl);
				case 4:
					FlxG.save.data.songPosition = !FlxG.save.data.songPosition;
					var ctrl:Alphabet = new Alphabet(0, (70 * curSelected) + 30, (FlxG.save.data.songPosition ? 'Song Position Bar On' : 'Song Position Bar Off'), true, false);
					ctrl.isMenuItem = true;
					ctrl.targetY = curSelected - 4;
					grpControls.add(ctrl);
			}
		}
	}

	var isSettingControl:Bool = false;

	function changeSelection(change:Int = 0)
	{
		FlxG.sound.play('assets/sounds/scrollMenu' + TitleState.soundExt, 0.4);

		curSelected += change;

		if (curSelected < 0)
			curSelected = grpControls.length - 1;
		if (curSelected >= grpControls.length)
			curSelected = 0;

		var bullShit:Int = 0;

		for (item in grpControls.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;

			if (item.targetY == 0)
			{
				item.alpha = 1;
			}
		}
	}
}