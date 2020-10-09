package edu.illinois.storm;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.Map;
import org.apache.storm.spout.SpoutOutputCollector;
import org.apache.storm.task.TopologyContext;
import org.apache.storm.topology.IRichSpout;
import org.apache.storm.topology.OutputFieldsDeclarer;
import org.apache.storm.tuple.Fields;
import org.apache.storm.tuple.Values;

/** a spout that generate sentences from a file */
public class FileReaderSpout implements IRichSpout {
  private SpoutOutputCollector _collector;
  private TopologyContext _context;
  private String inputFile;

  // Hint: Add necessary instance variables if needed
  private FileReader fileReader;
  private BufferedReader reader;
  private boolean isReadComplete = false;
  //private long count = 0;

  @Override
  public void open(Map conf, TopologyContext context, SpoutOutputCollector collector) {
    this._context = context;
    this._collector = collector;

    /* ----------------------TODO-----------------------
    Task: initialize the file reader
    ------------------------------------------------- */
        String filename = conf.get("input.file").toString();
        try {
            this.fileReader = new FileReader(filename);
            this.reader = new BufferedReader(this.fileReader);
        } 
        catch (IOException e){
            e.printStackTrace();
        }
    // END

  }

  // Set input file path
  public FileReaderSpout withInputFileProperties(String inputFile) {
    this.inputFile = inputFile;
    return this;
  }

  @Override
  public void nextTuple() {

    /* ----------------------TODO-----------------------
    Task:
    1. read the next line and emit a tuple for it
    2. don't forget to add a small sleep when the file is entirely read to prevent a busy-loop
    ------------------------------------------------- */
        /*
        if(isReadComplete){
            try {
                Thread.sleep(1);
            }
            catch (InterruptedException e){
                // interruption is normal
            }
        }
		*/
		
        String line;
		
        try {
            //while ((line = reader.readLine()) != null){
            	line = reader.readLine();
            	if (line != null) {
                	line = line.trim();
                	if(line.length() > 0){
                    	this._collector.emit(new Values(line));
                	}
                }
                else {
                	isReadComplete = true;
                	try {
                		Thread.sleep(100);
                	}
                	catch (InterruptedException e){
                		// interruption is normal
            		}
                }
            //}
        }
        catch (IOException e){
            e.printStackTrace();
        }
        //finally{  
        //    isReadComplete = true;
        //}
    // END
  }

  @Override
  public void declareOutputFields(OutputFieldsDeclarer declarer) {
    /* ----------------------TODO-----------------------
    Task: define the declarer
    ------------------------------------------------- */
        declarer.declare(new Fields("word"));
    // END
  }

  @Override
  public void close() {
    /* ----------------------TODO-----------------------
    Task: close the file
    ------------------------------------------------- */
        try {
			if (this.fileReader != null) {
            	this.fileReader.close();
        	}
		} 
        catch (IOException e) {
			e.printStackTrace();
		}
 		
    // END

  }

  public void fail(Object msgId) {}

  public void ack(Object msgId) {}

  @Override
  public void activate() {}

  @Override
  public void deactivate() {}

  @Override
  public Map<String, Object> getComponentConfiguration() {
    return null;
  }
}
