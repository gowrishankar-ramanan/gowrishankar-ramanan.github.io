import java.io.IOException;

import org.apache.hadoop.conf.Configuration;

import org.apache.hadoop.hbase.HBaseConfiguration;
import org.apache.hadoop.hbase.HColumnDescriptor;
import org.apache.hadoop.hbase.HTableDescriptor;

import org.apache.hadoop.hbase.TableName;

import org.apache.hadoop.hbase.client.HBaseAdmin;
import org.apache.hadoop.hbase.client.HTable;
import org.apache.hadoop.hbase.client.Put;
import org.apache.hadoop.hbase.client.Result;
import org.apache.hadoop.hbase.client.ResultScanner;
import org.apache.hadoop.hbase.client.Scan;
import org.apache.hadoop.hbase.client.Get;


import org.apache.hadoop.hbase.util.Bytes;

public class TablePartD{

   public static void main(String[] args) throws IOException {

	// TODO      
	// DON' CHANGE THE 'System.out.println(xxx)' OUTPUT PART
	// OR YOU WON'T RECEIVE POINTS FROM THE GRADER 

	// Instantiating Configuration class
      	Configuration config = HBaseConfiguration.create();

      	// Instantiating HTable class
      	HTable table = new HTable(config, "powers");

	Result row1 = getResult(table, "row1");

	String hero = getValue(row1, "personal", "hero");
	String power = getValue(row1, "personal", "power");
	String name = getValue(row1, "professional", "name");
	String xp = getValue(row1, "professional", "xp");
	String color = getValue(row1, "custom", "color");
	System.out.println("hero: "+hero+", power: "+power+", name: "+name+", xp: "+xp+", color: "+color);

	Result row19 = getResult(table, "row19");
	hero = getValue(row19, "personal", "hero");
	color = getValue(row19, "custom", "color");
	System.out.println("hero: "+hero+", color: "+color);

	hero = getValue(row1, "personal", "hero");
	name = getValue(row1, "professional", "name");
	color = getValue(row1, "custom", "color");
	System.out.println("hero: "+hero+", name: "+name+", color: "+color); 
   }

   private static Result getResult(HTable table, String rowKey) throws IOException {
	//Get Row Data
	Result result = table.get(new Get(Bytes.toBytes(rowKey)));
	return result;
   }

   private static String getValue(Result result, String colFamily, String colName) {
	// Reading values from Result class object
 	byte [] value = result.getValue(Bytes.toBytes(colFamily),Bytes.toBytes(colName));
        String str = Bytes.toString(value);
	return (str);
   }
}

