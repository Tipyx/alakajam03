package ui;

class Title extends h2d.Layers {

	var pressText				: h2d.Text;

	public function new() {
		super();

		pressText = new h2d.Text(hxd.res.DefaultFont.get(), this);
		pressText.text = "Press [SPACE] to play!";

		onResize();
	}

	public function onResize() {
		pressText.x = Std.int(Const.STG_WIDTH - pressText.textWidth) >> 1;
		pressText.y = Std.int(Const.STG_HEIGHT - pressText.textHeight) >> 1;
	}

	public function destroy() {
		pressText.remove();
	}

	public function update(dt:Float) {
		if (hxd.Key.isPressed(hxd.Key.SPACE))
			Main.ME.newGame();
	}
}