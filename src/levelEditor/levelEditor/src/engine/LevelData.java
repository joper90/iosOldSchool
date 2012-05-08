package engine;

import java.io.BufferedReader;
import java.io.DataInputStream;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.HashMap;

public class LevelData 
{
	String fileToWorkOn;
	ArrayList<String> endColourMap;
	ArrayList<String> endFlightMap;	
	HashMap<String, String> headerInformation;
	
	ArrayList<String> rawRowData;
	ArrayList<String> rawMoveData;
	
	enum STATE {NORMAL, GAMELAYER, MOVEMENT};
	
	STATE currentState = STATE.NORMAL;
	
	public LevelData(String fileName)	{
		this.fileToWorkOn = fileName;
		headerInformation = new HashMap<String,String>();
		rawRowData = new ArrayList<String>();
		rawMoveData = new ArrayList<String>();
		endColourMap = new ArrayList<String>();
		endFlightMap = new ArrayList<String>();
	}
	
	public HashMap<String, String> getHeaderInformation()
	{
		return this.headerInformation;
	}
	
	public ArrayList<String> getEndColourMap() {
		return endColourMap;
	}

	public ArrayList<String> getEndFlightMap() {
		return endFlightMap;
	}

	public boolean parseHeaderInfo()
	{
		try
		{
			FileInputStream fstream = new FileInputStream(fileToWorkOn);
			DataInputStream in = new DataInputStream(fstream);
			BufferedReader br = new BufferedReader(new InputStreamReader(in));
			String strLine;
			
			while ((strLine = br.readLine()) != null)   
			{
				  parseLine(strLine);		  
			}
			
			buildCorrectArrays();
			
		}catch (Exception e){
			  System.err.println("Error: " + e.getMessage());
			  return false;
			  
		}
		return true;
	}
	
	public void parseLine(String lineToParse)
	{
		switch (currentState)
		{
		case NORMAL:
			System.out.println("Parsing :" + lineToParse);
			if (lineToParse.startsWith("levelId:"))
			{
				headerInformation.put("levelId", lineToParse.substring(8));
			}
			else if (lineToParse.startsWith("levelName:"))
			{
				headerInformation.put("levelName", lineToParse.substring(10));
			}
			else if (lineToParse.startsWith("levelInfo:"))
			{
				headerInformation.put("levelInfo", lineToParse.substring(10));
			}
			else if (lineToParse.startsWith("basespeed:"))
			{
				headerInformation.put("basespeed", lineToParse.substring(10));
			}
			else if (lineToParse.startsWith("linetime:"))
			{
				headerInformation.put("linetime", lineToParse.substring(9));
			}
			else if (lineToParse.startsWith("bg:"))
			{
				headerInformation.put("bg", lineToParse.substring(3));
			}
			else if (lineToParse.startsWith("music:"))
			{
				headerInformation.put("music", lineToParse.substring(6));
			}
			else if (lineToParse.startsWith("=============="))
			{
				currentState = STATE.GAMELAYER;
			}
			break;
		case GAMELAYER:
			if (lineToParse.startsWith("==============="))
			{
				currentState = STATE.MOVEMENT;
			}else
			{
				rawRowData.add(lineToParse);
			}
			
			break;
		case MOVEMENT:
			rawMoveData.add(lineToParse);
			break;
		}
	}
	
	private void buildCorrectArrays()
	{
		//work out the longest array element.
		int largestElement = 0;
		int rowCount = rawRowData.size();
		for (String s : rawRowData)
		{
			if (s.length() > largestElement) largestElement = s.length();
		}
		
		//Now process
		for (int a = 0; a < largestElement; a++)
		{
			String singleFlowRow = "";
			String singleMoveRow = "";
			for (int b = 0; b < rowCount;b++)
			{
				String singleRow = rawRowData.get(b);
				String singleMove = rawMoveData.get(b);
				singleFlowRow = singleFlowRow + singleRow.substring(a,a+1);
				singleMoveRow = singleMoveRow + singleMove.substring(a,a+1);
			}
			System.out.println(singleFlowRow + " | " + singleMoveRow);
			endColourMap.add(singleFlowRow);
			endFlightMap.add(singleMoveRow);
		}
	}

}
/*
levelId:0
levelName:
levelInfo:
basespeed:
linetime:
bg:
music:
	*/
