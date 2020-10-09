package edu.illinois.storm;

import org.apache.storm.topology.BasicOutputCollector;
import org.apache.storm.topology.OutputFieldsDeclarer;
import org.apache.storm.topology.base.BaseBasicBolt;
import org.apache.storm.tuple.Fields;
import org.apache.storm.tuple.Tuple;
import org.apache.storm.tuple.Values;

/** a bolt that split sentences */
public class SplitSentenceBolt extends BaseBasicBolt {

    public static String[] splitSentence(String sentence) {
        if (sentence != null) {
            //return sentence.split("\\s+");
            return sentence.split("[^0-9a-zA-Z-]");
        }
        return null;
    }

  @Override
  public void execute(Tuple tuple, BasicOutputCollector collector) {
    /* ----------------------TODO-----------------------
    Task: split sentence and emit words
		Hint: split on "[^a-zA-Z0-9]"
    ------------------------------------------------- */
		for (String word : splitSentence(tuple.getString(0))) {
			word = word.trim();
			if(!word.equals("")) {
            	collector.emit(new Values(word));
            }
        }
		// End
  }

  @Override
  public void declareOutputFields(OutputFieldsDeclarer declarer) {
    /* ----------------------TODO-----------------------
    Task: declare output fields
    ------------------------------------------------- */
		declarer.declare(new Fields("word"));
		// End
  }
}