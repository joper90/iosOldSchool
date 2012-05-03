package oiFactory;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

import engine.Statics;

public class IoEngine {

	public IoEngine() {

	}

	public void createTemplate(String numberToCreate, String location) throws IOException {
		System.out.println("Creating template number.. " + numberToCreate
				+ " at location " + location);

		String lvlToCreate = Statics.FILENAME;
		lvlToCreate = lvlToCreate.replace("X", numberToCreate);

		lvlToCreate = location + "\\" + lvlToCreate;
		
		File file = new File(lvlToCreate);
		boolean exist = file.createNewFile();
		if (!exist) {
			System.out.println("File already exists.");
			System.exit(0);
		} else {
			FileWriter fstream = new FileWriter(lvlToCreate);
			BufferedWriter out = new BufferedWriter(fstream);
			out.write("test");
			out.close();
			System.out.println("File created successfully.");
		}

	}

}
