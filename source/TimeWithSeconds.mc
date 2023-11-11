using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

class TimeWithSeconds extends Ui.Drawable {

    private var mx;
    private var my;

    function initialize(params) {
        Drawable.initialize(params);

        mx = params[:x];
        my = params[:y];
    }

    function draw(dc) {
        var clockTime = System.getClockTime();

        var timeString = Lang.format("$1$:$2$", [clockTime.hour, clockTime.min.format("%02d")]);
        var secondsString = Lang.format(":$1$", [clockTime.sec.format("%02d")]);

        dc.drawText(mx, my, Gfx.FONT_NUMBER_HOT, timeString, Gfx.TEXT_JUSTIFY_RIGHT);
        dc.drawText(mx, my+90, Gfx.FONT_XTINY, secondsString, Gfx.TEXT_JUSTIFY_LEFT);
    }

}