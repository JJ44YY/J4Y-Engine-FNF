import flixel.FlxSprite;

class HealthIcon extends FlxSprite
{
	public var sprTracker:FlxSprite;

	public function new(char:String = 'bf', isPlayer:Bool = false)
	{
		super();
		loadGraphic(AssetPaths.iconGrid__png, true, 150, 150);

		antialiasing = true;
		animation.add('bf', [0, 1], 0, false, isPlayer);
		animation.add('bf-old', [2, 3], 0, false, isPlayer);
		animation.add('dad', [4, 5], 0, false, isPlayer);
		animation.add('spooky', [6, 7], 0, false, isPlayer);
		animation.add('monster', [8, 9], 0, false, isPlayer);
		animation.add('pico', [10, 11], 0, false, isPlayer);
		animation.add('mom', [12, 13], 0, false, isPlayer);
		animation.add('face', [57, 58], 0, false, isPlayer);
		animation.add('gf', [59], 0, false, isPlayer);
		animation.play(char);
		scrollFactor.set();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (sprTracker != null)
			setPosition(sprTracker.x + sprTracker.width + 10, sprTracker.y - 30);
	}
}