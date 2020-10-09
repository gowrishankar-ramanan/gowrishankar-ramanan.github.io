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

import org.apache.hadoop.hbase.util.Bytes;

public class TablePartF{

   public static void main(String[] args) throws IOException {

	// TODO      
	// DON' CHANGE THE 'System.out.println(xxx)' OUTPUT PART
	// OR YOU WON'T RECEIVE POINTS FROM THE GRADER      
      
	// Instantiating Configuration class
      	Configuration config = HBaseConfiguration.create();
	// Create a HashMap object called colorMatches
    	//java.util.HashMap<String, Result[]> colorMatches = new java.util.HashMap<String, Result[]>();

      	// Instantiating HTable class
      	HTable table = new HTable(config, "powers");

      	// Instantiating the Scan class
      	Scan scan = new Scan();

      	// Scanning the required columns
      	scan.addColumn(Bytes.toBytes("professional"), Bytes.toBytes("name"));
      	scan.addColumn(Bytes.toBytes("personal"), Bytes.toBytes("power"));
	scan.addColumn(Bytes.toBytes("custom"), Bytes.toBytes("color"));

      	// Getting the scan result
      	ResultScanner scanner = table.getScanner(scan);
	
      	// Reading values from scan result
      	for (Result result = scanner.next(); result != null; result = scanner.next()) {
      		//System.out.println("Found row : " + result);
		String name = Bytes.toString(result.getValue(Bytes.toBytes("professional"), Bytes.toBytes("name")));
		String power = Bytes.toString(result.getValue(Bytes.toBytes("personal"), Bytes.toBytes("power")));
		String color = Bytes.toString(result.getValue(Bytes.toBytes("custom"), Bytes.toBytes("color")));
		//System.out.println(name + ", " + power + ", " + color);
		//colorMatches.put(color, result);
        	
		/*
		//Filter Criteria
        	FilterList list = new FilterList(FilterList.Operator.MUST_PASS_ALL);
        	SingleColumnValueFilter filter1 = new SingleColumnValueFilter(
               	 	"custom",
               	 	"color",
               	 	CompareOperator.EQUAL,
               	 	Bytes.toBytes(color)
        	);
        	list.add(filter1);

        	SingleColumnValueFilter filter2 = new SingleColumnValueFilter(
                	"professional",
                	"name",
                	CompareOperator.NOT_EQUAL,
                	Bytes.toBytes(name)
        	);
        	list.add(filter2);

        	scan.setFilter(list);
		*/

		//Scan scan1 = new Scan(result.getRow());
		Scan scan1 = new Scan();
		//System.out.println("After Scan1");
		ResultScanner scanner1 = table.getScanner(scan1);
		//System.out.println("After scanner1");
		for (Result result1 = scanner1.next(); result1 != null; result1 = scanner1.next()) {
	                String name1 = Bytes.toString(result1.getValue(Bytes.toBytes("professional"), Bytes.toBytes("name")));
        	        String power1 = Bytes.toString(result1.getValue(Bytes.toBytes("personal"), Bytes.toBytes("power")));
               		String color1 = Bytes.toString(result1.getValue(Bytes.toBytes("custom"), Bytes.toBytes("color")));
                	//System.out.println("Found row : " + result1);
			//System.out.println(name + ", " + power + ", " + color + ", " + name1 + ", " + power1 + ", "+color1);
			
			if (color1.equals(color) && !name1.equals(name))
				System.out.println(name + ", " + power + ", " + name1 + ", " + power1 + ", "+color);
		}
		//System.out.println("After Iteration");
		scanner1.close();
	}
      
	//closing the scanner
      	scanner.close();
	
	/*
	String name = ???;
	String power = ???;
	String color = ???;

	String name1 = ???;
	String power1 = ???;
	String color1 = ???;
	*/
	//System.out.println(name + ", " + power + ", " + name1 + ", " + power1 + ", "+color);

   }

}
