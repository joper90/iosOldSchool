package engine;

public class Statics {

	//All the statics
	

	public static String FILENAME = "level_X.lvl";
	public static String FILENAME_PREFIX = "level_";
	public static String OUTPUT_FILENAME = "levelData.json";
	
	
	public static String DEFAULT_LOCATION_PC  = "c:\\levels";
	public static String DEFAULT_LOCATION_MAC = "/Users/joeh/levels";
	public static String DEFAULT_LEVEL = "0";
	
	
	public static String HEADER = "levelId:X\nlevelName:\nlevelInfo:\nbasespeed:\nlinetime:\nbg:\nmusic:\n"
								+ "RED, YELLOW, BLUE, GREEN, PINK, PURPLE, WHITE\n"
								+ "STRAIGHT, FAST_IN_OUT, SLOW_IN_OUT, BEZIER_ONE, ZOOM\n"
								+ "======================================================\n\n"
								+ "======================================================\n";
	
	public static String OUTPUT_HEADER= "{\r\n" + 
			"\"__Colour\":\"RED, YELLOW, BLUE, GREEN, PINK, PURPLE, WHITE\",\r\n" + 
			"\"__flight\":\"STRAIGHT, FAST_IN_OUT, SLOW_IN_OUT, BEZIER_ONE, ZOOM\",\r\n" + 
			"  \"levels\": [\r\n";
	
	public static String OUTPUT_FOOTER="]\r\n}";
}




/*
"levelId": "1",
"levelName": "simple one",
"levelInfo": "normal",
"baseSpeed": "10",
"lineTime": "3",
"bg": "0",
"music": "test.mp3",
*/