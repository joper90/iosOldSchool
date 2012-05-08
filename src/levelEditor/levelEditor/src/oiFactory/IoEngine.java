package oiFactory;

import engine.LevelData;
import engine.Statics;
import gui.ControlWindow;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

public class IoEngine {

	ControlWindow controlWindow;
	
	public IoEngine(ControlWindow controlWindow) {
		this.controlWindow = controlWindow;
		System.out.println("IoEngine engine init complete");
	}

	public void createFinalFile(ArrayList<LevelData> levelDataArray, String location) throws IOException
	{
		System.out.println("Creating final json File.. " + location);
		
		String finalName = Statics.OUTPUT_FILENAME;
		finalName = location = "\\" + finalName;
		
		File file = new File(finalName);
		boolean exist = file.createNewFile();
		if (!exist)
		{
			if (controlWindow.isOverRide())
			{
				//remove and retry
				exist = true;
			}else  
			{
				System.out.println("Outputfile exists, no override set");
			}
		}
		
		if (exist) // inital or now set
		{
			FileWriter fstream = new FileWriter(finalName);
			BufferedWriter out = new BufferedWriter(fstream);
			
			out.write(Statics.OUTPUT_HEADER);
			boolean firstElement= true;                                                                                                                              
			for (LevelData lData : levelDataArray)
			{
				HashMap<String,String> headerInformation = lData.getHeaderInformation();
				if (firstElement)
				{
					firstElement = false;
				}else
				{
					out.write(",");
				}
				out.write("{");
				out.write("\"levelId\": \""+ headerInformation.get("levelId") + "\",");
				out.write("\"levelName\": \""+ headerInformation.get("levelName") + "\",");
				out.write("\"levelInfo\": \""+ headerInformation.get("levelInfo") + "\",");
				out.write("\"basespeed\": \""+ headerInformation.get("basespeed") + "\",");
				out.write("\"linetime\": \""+ headerInformation.get("linetime") + "\",");
				out.write("\"bg\": \""+ headerInformation.get("bg") + "\",");
				out.write("\"music\": \""+ headerInformation.get("music") + "\",");
				
				//Now do rows ofdata
				
				//Get teh array of both colours and move
				ArrayList<String> colours = lData.getEndColourMap();
				ArrayList<String> flight = lData.getEndFlightMap();
				boolean arrayFirstElement = true;
				
				out.write("\"rowData\": [");
				for (int a=0;a<colours.size();a++)
				{
					if (arrayFirstElement)
					{
						arrayFirstElement = false;
					}else
					{
						out.write(",");
					}
					out.write("{ \"row\":\"" + colours.get(a) + "\",\"pattern\":\"" + flight.get(a) + "\"}");
				}
				
				out.write("]}");
				
			}
			out.write("]}");
			out.close();
		}
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
