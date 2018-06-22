@:allow(DebugInfo)
class Main extends hxd.App {

	static var num					= 0;
	public static var DP_MAIN		= num++;
	public static var DP_DEBUG		= num++;
	public static var DP_CONSOLE	= num++;

	public static var ME		: Main;

	var dbgInfo			: DebugInfo;
	var slowMo			: Bool;
	var megaSlowMo		: Bool;
	var speedMo			: Bool;

	#if debug
	public var console	: h2d.Console;
	#end

	var title			: ui.Title;
	var game			: Game;

	override function init() {
		super.init();
		
		ME = this;

		Const.INIT();

		this.wantedFPS = Const.FPS;

		#if debug
		console = new h2d.Console(hxd.res.DefaultFont.get());
		s2d.add(console, DP_CONSOLE);
		haxe.Log.trace = function(v, ?i) console.log(i.className + "@" + i.lineNumber + " : " + v);
		#end

		dbgInfo = new DebugInfo();
		#if debug
		s2d.add(dbgInfo, DP_DEBUG);
		#end

		#if hl
			#if debug
			hxd.Res.data.watch(function() {
				DCDB.load(hxd.Res.data.entry.getBytes().toString());
				console.log("Cdb reloaded!");

				newGame();
			});
			
			hxd.res.Resource.LIVE_UPDATE = true;
			trace("hl + debug");
			#else
			trace("hl + release");
			#end
		#end

		#if debug
		newGame();
		#else
		showTitle();
		#end
		// showTitle();
	}

	public function newGame() {
		if (title != null) {
			title.destroy();
			title = null;
		}

		if (game != null)
			game.destroy();

		game = new Game();
		s2d.add(game, DP_MAIN);
	}

	inline function showTitle() {
		if (game != null) {
			game.destroy();
			game = null;
		}

		title = new ui.Title();
		s2d.add(title, DP_MAIN);
	}

	override function onResize() {
		super.onResize();

		if (game != null)
			game.onResize();

		if (title != null)
			title.onResize();
	}

	override public function update(dt:Float) {
		super.update(dt);

		#if debug
		if (hxd.Key.isPressed(hxd.Key.NUMPAD_SUB))
			slowMo = !slowMo;
		if (hxd.Key.isPressed(hxd.Key.NUMPAD_MULT))
			megaSlowMo = !megaSlowMo;
		speedMo = hxd.Key.isDown(hxd.Key.NUMPAD_ADD);
		
		if (hxd.Key.isPressed(hxd.Key.ESCAPE))
			newGame();
		#end

		if (game != null)
			game.update(dt * (speedMo ? 5 : megaSlowMo ? 0.1 : slowMo ? 0.5 : 1));

		if (title != null)
			title.update(dt);

		dbgInfo.update(dt);
		dbgInfo.x = Const.STG_WIDTH - dbgInfo.outerWidth;
	}

	static function main() {
		#if (hl && debug)
		hxd.Res.initLocal();
		#else
		hxd.Res.initEmbed();
		#end

		DCDB.load(hxd.Res.data.entry.getBytes().toString());	

		new Main();
	}
}
