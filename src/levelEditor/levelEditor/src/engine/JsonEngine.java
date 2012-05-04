package engine;

import gui.ControlWindow;

import java.util.ArrayList;

import oiFactory.IoEngine;

public class JsonEngine {

	IoEngine ioEngine;
	ControlWindow controlWindow;
	
	ArrayList<LevelData> levels = new ArrayList<LevelData>();
	
	public JsonEngine(ControlWindow controlWindow, IoEngine ioEngine)
	{
		this.ioEngine = ioEngine;
		this.controlWindow = controlWindow;
		System.out.println("Json engine init complete");
	}
	
	public  void parseAndOutput(String location)
	{
		ArrayList<String> validFiles = ioEngine.getListOfValidfiles(location);
		//Now for each file parse
		for (String fileName : validFiles)
		{
			System.out.println("Processing file : " + fileName);
			controlWindow.updateAudit("Working :" + fileName);
			LevelData level = new LevelData(location + "\\"+ fileName);
			boolean worked = level.parseHeaderInfo();
			if (worked)
			{
				levels.add(level);
				controlWindow.updateAudit("OK :" + fileName);
			}else
			{
				controlWindow.updateAudit("FAILED :" + fileName);
			}
		}
	}
	
	
}
