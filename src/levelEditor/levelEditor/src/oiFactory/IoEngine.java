package oiFactory;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;

import engine.Statics;
import gui.ControlWindow;

public class IoEngine {

	ControlWindow controlWindow;
	
	public IoEngine(ControlWindow controlWindow) {
		this.controlWindow = controlWindow;
		System.out.println("IoEngine engine init complete");
	}

	public void createTemplate(String numberToCreate, String location) throws IOException {
		System.out.println("Creating template number.. " + numberToCreate
				+ " at location " + location);

		String lvlToCreate = Statics.FILENAME;
		lvlToCreate = lvlToCreate.replace("X", numberToCreate);

		lvlToCreate = location + "\\" + lvlToCreate;
		String outputString = Statics.HEADER.replace("X", numberToCreate);
		
		File file = new File(lvlToCreate);
		boolean exist = file.createNewFile();
		if (!exist) {
			System.out.println("File already exists.");
			controlWindow.updateAudit("File already Exists..");
		} else {
			FileWriter fstream = new FileWriter(lvlToCreate);
			BufferedWriter out = new BufferedWriter(fstream);
			out.write(outputString);
			out.close();
			System.out.println("File created successfully.");
			controlWindow.updateAudit("Created: " + lvlToCreate);
		}

	}

	public ArrayList<String> getListOfValidfiles(String location)
	{
		File folder = new File(location);
		File[] listOfFiles = folder.listFiles();
		
		ArrayList<String> listOfValidFiles = new ArrayList<String>();
		
		for (File f : listOfFiles)
		{
			if (f.isFile())
			{
				String name = f.getName();
				if (name.contains(Statics.FILENAME_PREFIX))
				{
					listOfValidFiles.add(name);
				}
			}
		}
		
		return listOfValidFiles;
	}
}
