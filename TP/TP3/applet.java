/*
	Draw Dots at Random Locations in an Applet Example
	This Java example shows draw dots at random locations at specified interval
	using Java Thread and Applet classes.
*/
 
import java.applet.Applet;
import java.awt.Dimension;
import java.awt.Graphics;
/* 
	<applet code = "DrawDotsAtRandomLocationsExample" width = 500 height = 300>
	</applet>
*/
public class DrawDotsAtRandomLocationsExample extends Applet implements Runnable{
	
	Thread t;
	
	public void init(){
		//start new Thread
		t = new Thread(this);
		t.start();
	}
	
	public void run(){
		
		try{
			
			while(true){
				// Request repaint
				repaint();
				Thread.sleep(200);
			}
		}
		catch(Exception e){
		}
		
	}
	public void update(Graphics g){
		paint(g);
	}
	
	public void paint(Graphics g){
		
		Dimension d = getSize();
		int x = (int)(Math.random() * d.width);
		int y = (int)(Math.random() * d.height);
		g.fillRect(x,y,2,2);
		
	}
}