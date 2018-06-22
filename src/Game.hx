class Game extends h2d.Layers {

	static var num			= 0;
	static var DP_LEVEL		= num++;

	var fTime			: Float;

	var level			: Level;

	var cd				: tipyx.Cooldown;

	public function new() {
		super();

		fTime = 0;

		cd = new tipyx.Cooldown(Const.FPS);

		level = new Level();
		this.add(level, DP_LEVEL);
	}

	public function onResize() {
		if (level != null)
			level.onResize();
	}

	public function destroy() {
		if (level != null)
			level.destroy();
	}

	public function update(dt:Float) {
		fTime += dt;

		cd.update(dt);

		if (level != null)
			level.update(dt);
	}
}
