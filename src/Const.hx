class Const {

	public static var STG_WIDTH			: Int;
	public static var STG_HEIGHT		: Int;

	public static var FPS				: Int;

	public static function INIT() {
		RESIZE();

		FPS = Std.int(getDataValue0(DCDB.DataKind.FPS));
		// FPS = 60;
	}

	public static function getDataValue0(id:DCDB.DataKind) {
		return DCDB.data.get(id).v0;
	}
	
	public static function RESIZE() {
		STG_WIDTH = Main.ME.engine.width;
		STG_HEIGHT = Main.ME.engine.height;
	}
}
