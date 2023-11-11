import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.Weather;
import Toybox.Time;
using Toybox.ActivityMonitor as ActMon;

// https://github.com/Makin-Things/weather-icons
const WEATHER_CONDITION_MAPPING = {
    Weather.CONDITION_CLEAR => Rez.Drawables.ClearDay,
    Weather.CONDITION_PARTLY_CLOUDY => Rez.Drawables.Cloudy,
    Weather.CONDITION_MOSTLY_CLOUDY => Rez.Drawables.Cloudy,
    Weather.CONDITION_RAIN => Rez.Drawables.Rain,
    Weather.CONDITION_SNOW => Rez.Drawables.Snow,
    Weather.CONDITION_WINDY => Rez.Drawables.Wind,
    Weather.CONDITION_THUNDERSTORMS => Rez.Drawables.Thunderstorms,
    Weather.CONDITION_WINTRY_MIX => Rez.Drawables.ClearDay,
    Weather.CONDITION_FOG => Rez.Drawables.Fog,
    Weather.CONDITION_HAZY => Rez.Drawables.Fog,
    Weather.CONDITION_HAIL => Rez.Drawables.Hail,
    Weather.CONDITION_SCATTERED_SHOWERS => Rez.Drawables.Rain,
    Weather.CONDITION_SCATTERED_THUNDERSTORMS => Rez.Drawables.Thunderstorms,
    Weather.CONDITION_UNKNOWN_PRECIPITATION=> Rez.Drawables.Rain,
    Weather.CONDITION_LIGHT_RAIN => Rez.Drawables.Rain,
    Weather.CONDITION_HEAVY_RAIN => Rez.Drawables.Rain,
    Weather.CONDITION_LIGHT_SNOW => Rez.Drawables.Snow,
    Weather.CONDITION_HEAVY_SNOW => Rez.Drawables.Snow,
    Weather.CONDITION_LIGHT_RAIN_SNOW => Rez.Drawables.RainSnow,
    Weather.CONDITION_HEAVY_RAIN_SNOW => Rez.Drawables.RainSnow,
    Weather.CONDITION_CLOUDY => Rez.Drawables.Cloudy,
    Weather.CONDITION_RAIN_SNOW => Rez.Drawables.RainSnow,
    Weather.CONDITION_PARTLY_CLEAR => Rez.Drawables.ClearDay,
    Weather.CONDITION_MOSTLY_CLEAR => Rez.Drawables.ClearDay,
    Weather.CONDITION_LIGHT_SHOWERS => Rez.Drawables.Rain,
    Weather.CONDITION_SHOWERS => Rez.Drawables.Rain,
    Weather.CONDITION_HEAVY_SHOWERS => Rez.Drawables.Rain,
    Weather.CONDITION_CHANCE_OF_SHOWERS => Rez.Drawables.ClearDay,
    Weather.CONDITION_CHANCE_OF_THUNDERSTORMS => Rez.Drawables.ClearDay,
    Weather.CONDITION_MIST => Rez.Drawables.Fog,
    Weather.CONDITION_DUST => Rez.Drawables.Fog,
    Weather.CONDITION_DRIZZLE => Rez.Drawables.Fog,
    Weather.CONDITION_TORNADO => Rez.Drawables.Thunderstorms,
    Weather.CONDITION_SMOKE => Rez.Drawables.Fog,
    Weather.CONDITION_ICE => Rez.Drawables.Frost,
    Weather.CONDITION_SAND => Rez.Drawables.Fog,
    Weather.CONDITION_SQUALL => Rez.Drawables.Wind,
    Weather.CONDITION_SANDSTORM => Rez.Drawables.Dust,
    Weather.CONDITION_VOLCANIC_ASH => Rez.Drawables.Fog,
    Weather.CONDITION_HAZE => Rez.Drawables.Fog,
    Weather.CONDITION_FAIR => Rez.Drawables.ClearDay,
    Weather.CONDITION_HURRICANE => Rez.Drawables.ClearDay,
    Weather.CONDITION_TROPICAL_STORM => Rez.Drawables.ClearDay,
    Weather.CONDITION_CHANCE_OF_SNOW => Rez.Drawables.ClearDay,
    Weather.CONDITION_CHANCE_OF_RAIN_SNOW => Rez.Drawables.ClearDay,
    Weather.CONDITION_CLOUDY_CHANCE_OF_RAIN => Rez.Drawables.Cloudy,
    Weather.CONDITION_CLOUDY_CHANCE_OF_SNOW => Rez.Drawables.Cloudy,
    Weather.CONDITION_CLOUDY_CHANCE_OF_RAIN_SNOW => Rez.Drawables.Cloudy,
    Weather.CONDITION_FLURRIES => Rez.Drawables.Rain,
    Weather.CONDITION_FREEZING_RAIN => Rez.Drawables.Rain,
    Weather.CONDITION_SLEET => Rez.Drawables.RainSnow,
    Weather.CONDITION_ICE_SNOW => Rez.Drawables.Snow,
    Weather.CONDITION_THIN_CLOUDS => Rez.Drawables.Cloudy,
    Weather.CONDITION_UNKNOWN => null,
};


class WatchFace1View extends WatchUi.WatchFace {

    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Get and show the current time
        var hr = "--";

        var hrh = ActMon.getHeartRateHistory(1, true);
        if (hrh != null) {
            var hrs = hrh.next();
            if (hrs != null) {
                hr = hrs.heartRate.toString();
            }
        }

        var heartRateView = View.findDrawableById("HeartRateLabel") as Text;
        heartRateView.setText(hr);
        
        var battery = Math.round(System.getSystemStats().battery).toNumber();
        var batteryView = View.findDrawableById("BatteryLabel") as Text;
        batteryView.setText(Lang.format("$1$%", [battery]));

        var batteryImg_0 = View.findDrawableById("BatteryImg0") as Bitmap;
        var batteryImg_25 = View.findDrawableById("BatteryImg25") as Bitmap;
        var batteryImg_50 = View.findDrawableById("BatteryImg50") as Bitmap;
        var batteryImg_75 = View.findDrawableById("BatteryImg75") as Bitmap;
        var batteryImg_100 = View.findDrawableById("BatteryImg100") as Bitmap;

        batteryImg_0.setVisible(false);
        batteryImg_25.setVisible(false);
        batteryImg_50.setVisible(false);
        batteryImg_75.setVisible(false);
        batteryImg_100.setVisible(false);

        if (battery < 20) {
            batteryImg_0.setVisible(true);
        } else if (battery < 40) {
            batteryImg_25.setVisible(true);
        } else if (battery < 60) {
            batteryImg_50.setVisible(true);
        } else if (battery < 80) {
            batteryImg_75.setVisible(true);
        } else {
            batteryImg_100.setVisible(true);
        }

        var date = Time.Gregorian.info(Time.now(), Time.FORMAT_LONG);
        var dateStr = Lang.format("$1$ $2$, $3$", [date.month, date.day, date.day_of_week]);
        var dateView = View.findDrawableById("DateLabel") as Text;
        dateView.setText(dateStr);

        var temperature = Weather.getCurrentConditions().temperature;
        var temperatureStr = Lang.format("$1$°", [temperature]);
        var temperatureLabel = View.findDrawableById("TemperatureLabel") as Text;
        temperatureLabel.setText(temperatureStr);

        var weatherImg = View.findDrawableById("WeatherImg") as Bitmap;
        var condition = Weather.getCurrentConditions().condition;
        var weatherRez = WEATHER_CONDITION_MAPPING[condition];
        weatherImg.setBitmap(weatherRez);


        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() as Void {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() as Void {
    }

}
