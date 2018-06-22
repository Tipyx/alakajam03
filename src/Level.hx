class Level extends h2d.Layers {

	static var num			= 0;
	
	static var DP_BG		= num++;
	static var DP_PLAYER	= num++;

	var fTime			: Float;
	
	var bg				: h2d.Graphics;
	var gr				: h2d.Graphics;

	var cd				: tipyx.Cooldown;

	public function new() {
		super();

		fTime = 0;

		cd = new tipyx.Cooldown(Const.FPS);

		bg = new h2d.Graphics();
		bg.beginFill(0x6098f7);
		bg.drawRect(0, 0, Const.STG_WIDTH, Const.STG_HEIGHT);
		bg.endFill();
		this.add(bg, DP_BG);

		gr = new h2d.Graphics();
		gr.beginFill(0);
		gr.drawCircle(0, 0, 20);
		gr.endFill();
		this.add(gr, DP_PLAYER);

		hxd.Res.music.test.play(true);
	}

	public function onResize() {
	}

	public function destroy() {

	}

	public function update(dt:Float) {
		fTime += dt;

		cd.update(dt);

		gr.setPos((Const.STG_WIDTH >> 1) + Math.cos(fTime / 10) * 50, ((Const.STG_HEIGHT >> 1) + Math.sin(fTime / 10) * 50));
	}

}