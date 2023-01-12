package ${ info.groupId }.util;

import java.text.DecimalFormat;
import java.util.Calendar;

public class CalendarUtil {

	public static Integer yyyymmdd() {

		Calendar c = Calendar.getInstance();

		int year   = c.get(Calendar.YEAR);
		int month  = c.get(Calendar.MONTH) + 1;
		int date   = c.get(Calendar.DAY_OF_MONTH);
		int hour   = c.get(Calendar.HOUR_OF_DAY);
		int minute = c.get(Calendar.MINUTE);
		int second = c.get(Calendar.SECOND);

		return year * 10_000 + month * 100 + date;

	}

	public static Long yyyymmdd000000() {
		return CalendarUtil.yyyymmdd() * 1_000_000L;

	}


	public static Long yyyymmddhhmmss() {
		return CalendarUtil.yyyymmddhhmmss(0);
	}

	public static Long yyyymmddhhmmss(Integer addDays) {
		Calendar c = Calendar.getInstance();
		c.add(Calendar.DAY_OF_MONTH, addDays);

		long year   = c.get(Calendar.YEAR);
		long month  = c.get(Calendar.MONTH) + 1;
		long date   = c.get(Calendar.DAY_OF_MONTH);
		long hour   = c.get(Calendar.HOUR_OF_DAY);
		long minute = c.get(Calendar.MINUTE);
		long second = c.get(Calendar.SECOND);

		// 20 180 516 152 107
		//    000 000 000 000
		return year * 10_000_000_000L + month * 100_000_000L + date * 1_000_000L + hour * 10_000L + minute * 100L + second;
	}

	public static String ggaayyyy(Integer date) {
		// 20180912
		int yil = date / 10_000;
		int ay  = (date / 100) % 100;
		int gun = date % 100;

		return new StringBuilder()
				.append(gun < 10 ? "0" + gun : gun)
				.append(".")
				.append(ay < 10 ? "0" + ay : ay)
				.append(".")
				.append(yil)
				.toString();
	}

	public static String now() {
		Calendar c = Calendar.getInstance();

		int yil    = c.get(Calendar.YEAR);
		int ay     = c.get(Calendar.MONTH) + 1;
		int gun    = c.get(Calendar.DAY_OF_MONTH);
		int saat   = c.get(Calendar.HOUR_OF_DAY);
		int dakika = c.get(Calendar.MINUTE);
		int saniye = c.get(Calendar.SECOND);

		return new StringBuilder()
				.append(gun < 10 ? "0" + gun : gun)
				.append(".")
				.append(ay < 10 ? "0" + ay : ay)
				.append(".")
				.append(yil)
				.append(" ")
				.append(saat < 10 ? "0" + saat : saat)
				.append(":")
				.append(dakika < 10 ? "0" + dakika : dakika)
				.append(":")
				.append(saniye < 10 ? "0" + saniye : saniye)
				.toString();
	}

	public static String now4Filename() {
		Calendar c = Calendar.getInstance();

		int yil    = c.get(Calendar.YEAR);
		int ay     = c.get(Calendar.MONTH) + 1;
		int gun    = c.get(Calendar.DAY_OF_MONTH);
		int saat   = c.get(Calendar.HOUR_OF_DAY);
		int dakika = c.get(Calendar.MINUTE);
		int saniye = c.get(Calendar.SECOND);

		return new StringBuilder()
				.append(yil < 10 ? "0" + yil : yil)
				.append(ay < 10 ? "0" + ay : ay)
				.append(gun < 10 ? "0" + gun : gun)
				.append("_")
				.append(saat < 10 ? "0" + saat : saat)
				.append(dakika < 10 ? "0" + dakika : dakika)
				.append(saniye < 10 ? "0" + saniye : saniye)
				.toString();
	}

	public static Integer yyyy() {
		return Calendar.getInstance().get(Calendar.YEAR);
	}

	public static Integer hhmm() {
		Calendar c      = Calendar.getInstance();
		int      hour   = c.get(Calendar.HOUR_OF_DAY);
		int      minute = c.get(Calendar.MINUTE);

		return hour * 100 + minute;
	}

	public static String formatSure(Integer sure) {
		if (sure == null)
			return "0 dk";

		int saat   = sure / 60;
		int dakika = sure % 60;

		return ((saat == 0 ? "" : saat + (dakika == 0 ? " saat " : " s ")) + (dakika == 0 ? "" : dakika + " dk")).trim();
	}

}
