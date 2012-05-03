package gui;

import java.awt.EventQueue;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.io.IOException;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JTextField;
import javax.swing.UIManager;

import oiFactory.IoEngine;
import engine.JsonEngine;
import engine.Statics;

public class ControlWindow {

	private JFrame frmLevelEditor;
	private JTextField locationField;
	private JTextField levelNumberField;
	
	private JsonEngine jsonEngine = new JsonEngine();
	private IoEngine ioEngine = new IoEngine();
	


	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					try {
						  UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
						} catch(Exception e) {
						  System.out.println("Error setting native LAF: " + e);
						}
					ControlWindow window = new ControlWindow();
					window.frmLevelEditor.setVisible(true);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
	}

	/**
	 * Create the application.
	 */
	public ControlWindow() {
		initialize();
	}

	/**
	 * Initialize the contents of the frame.
	 */
	private void initialize() {
		frmLevelEditor = new JFrame();
		frmLevelEditor.setTitle("Level Editor");
		frmLevelEditor.setBounds(100, 100, 450, 182);
		frmLevelEditor.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frmLevelEditor.getContentPane().setLayout(null);
		
		locationField = new JTextField();
		locationField.setBounds(95, 6, 314, 20);
		frmLevelEditor.getContentPane().add(locationField);
		locationField.setColumns(10);
		locationField.setText(Statics.DEFAULT_LOCATION);
		
		JLabel lblLocation = new JLabel("Location:");
		lblLocation.setBounds(39, 9, 46, 14);
		frmLevelEditor.getContentPane().add(lblLocation);
		
		levelNumberField = new JTextField();
		levelNumberField.setBounds(276, 38, 132, 20);
		frmLevelEditor.getContentPane().add(levelNumberField);
		levelNumberField.setColumns(10);
		levelNumberField.setText(Statics.DEFAULT_LEVEL);
		
		JLabel lblLevelNumber = new JLabel("Level Number:");
		lblLevelNumber.setBounds(195, 41, 71, 14);
		frmLevelEditor.getContentPane().add(lblLevelNumber);
		
		JButton buildAllButton = new JButton("Build All");
		buildAllButton.setBounds(39, 71, 370, 62);
		frmLevelEditor.getContentPane().add(buildAllButton);
		
		JButton createTemplateButton = new JButton("Create Template");
		createTemplateButton.addMouseListener(new MouseAdapter() {
			@Override
			public void mouseClicked(MouseEvent arg0) {
				
				createNewFile();
			}
		});
		createTemplateButton.setBounds(39, 37, 146, 23);
		frmLevelEditor.getContentPane().add(createTemplateButton);
	}
	
	
	
	private void createNewFile()
	{
		System.out.println("new template");
		try {
			ioEngine.createTemplate(levelNumberField.getText(), locationField.getText());
		} catch (IOException e) {
			System.out.println("IO ERROR...");
			e.printStackTrace();
		}
	}
}
