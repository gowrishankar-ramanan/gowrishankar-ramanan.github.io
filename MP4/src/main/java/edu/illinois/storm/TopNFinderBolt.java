package edu.illinois.storm;

import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;
import java.util.*;
import java.util.PriorityQueue;
import org.apache.storm.task.OutputCollector;
import org.apache.storm.task.TopologyContext;
import org.apache.storm.topology.OutputFieldsDeclarer;
import org.apache.storm.topology.base.BaseRichBolt;
import org.apache.storm.tuple.Fields;
import org.apache.storm.tuple.Tuple;
import org.apache.storm.tuple.Values;

/** a bolt that finds the top n words. */
public class TopNFinderBolt extends BaseRichBolt {
  private OutputCollector collector;

  // Hint: Add necessary instance variables and inner classes if needed
	private int N;
	private Map<String, Integer> map;
	//private long intervalToReport = 20;
    //private long lastReportTime = System.currentTimeMillis();

  @Override
  public void prepare(Map conf, TopologyContext context, OutputCollector collector) {
    this.collector = collector;
    this.map = new HashMap<String, Integer>();
    /*
    this.map = new TreeMap<String, Integer>(new Comparator<Entry<String, Integer>>(){
            
            public int compare(Entry<String, Integer> o1, Entry<String, Integer> o2){
                return o2.getValue().compareTo(o1.getValue());
            }
        });
    */
  }
  
  /*
  public TopNFinderBolt(int N) {
        this.N = N;
    }
  */
  
  public TopNFinderBolt withNProperties(int N) {
    /* ----------------------TODO-----------------------
    Task: set N
    ------------------------------------------------- */
		this.N = N;
		// End
		return this;
  }

  @Override
  public void execute(Tuple tuple) {
    /* ----------------------TODO-----------------------
    Task: keep track of the top N words
		Hint: implement efficient algorithm so that it won't be shutdown before task finished
		      the algorithm we used when we developed the auto-grader is maintaining a N size min-heap
    ------------------------------------------------- */
        String s = tuple.getString(0);
        Integer i = tuple.getInteger(1);
        
        Integer val = map.get(s);
        if(val == null){
            map.put(s,i); 
        }
        else{
            map.put(s,i + val);
        }

        //reports the top N words periodically
        //if (System.currentTimeMillis() - lastReportTime >= intervalToReport) {
            collector.emit(new Values("top-N", printMap()));
        //    lastReportTime = System.currentTimeMillis();
        //}
		// End
  }

  @Override
  public void declareOutputFields(OutputFieldsDeclarer declarer) {
    /* ----------------------TODO-----------------------
    Task: define output fields
		Hint: there's no requirement on sequence;
					For example, for top 3 words set ("hello", "word", "cs498"),
					"hello, world, cs498" and "world, cs498, hello" are all correct
    ------------------------------------------------- */
	declarer.declare(new Fields("top-N", "wordstring"));
    // END
  }
  
    public String printMap() {
        StringBuffer sb = new StringBuffer();
        //sb.append("top-words = [ ");
        
        java.util.Vector<Entry<String, Integer>> vec = new java.util.Vector<Entry<String, Integer>>(map.entrySet());
        //PriorityQueue<String> minHeap = new PriorityQueue<>(this.N);
        
        Collections.sort(vec, new Comparator<Entry<String, Integer>>(){
            
            public int compare(Entry<String, Integer> o1, Entry<String, Integer> o2){
                return o1.getValue().compareTo(o2.getValue());
            }
        });
        
        int left = Math.max(vec.size() - N, 0);
        for(int i = left ; i < vec.size(); i++){
            //sb.append("(" + vec.get(i).getKey() + " , " + vec.get(i).getValue().toString() + ") , ");
            sb.append(vec.get(i).getKey() + ", ");
        }
        
        //System.out.println(sb.toString());
        
        /*
        HashMap<String, Integer> topNMap = 
        	map.entrySet()
       		.stream()
       		.sorted(Comparator.comparingByValue(Comparator.reverseOrder()))
       		.limit(this.N)
       		.collect(java.util.stream.Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue));
       		
       	for (Map.Entry<K,V> entry:topNMap.entrySet()) {
       		sb.append(entry.getKey() + " , ");
       	}
       	*/
       	/*
       	int count = 0;
        while (count < this.N){
            sb.append(vec.get(i).getKey() + " , ");
        }
       	*/
       	
        int lastCommaIndex = sb.lastIndexOf(", ");
        sb.deleteCharAt(lastCommaIndex + 1);
        sb.deleteCharAt(lastCommaIndex);
        //sb.append("]");
        
        return sb.toString();
    }

}
