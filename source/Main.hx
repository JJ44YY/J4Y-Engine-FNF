package;

import flixel.FlxGame;
import openfl.display.FPS;
import openfl.display.Sprite;

class Main extends Sprite
{
	public static var fpsVar:FPS;

	public static var the:Bool = false;
	public static var poop:Bool = false;

	public function new()
	{
		super();
		addChild(new FlxGame(0, 0, TitleState, true));

		#if !mobile
		fpsVar = new FPS(10, 3, 0xFFFFFF);
		addChild(fpsVar);
		#end
	}
}