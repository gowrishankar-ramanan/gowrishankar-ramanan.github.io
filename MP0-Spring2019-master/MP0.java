import java.io.*;
import java.lang.reflect.Array;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.*;

public class MP0 {
    Random generator;
    String userName;
    String delimiters = " \t,;.?!-:@[](){}_*/";
    String[] stopWordsArray = {"i", "me", "my", "myself", "we", "our", "ours", "ourselves", "you", "your", "yours",
            "yourself", "yourselves", "he", "him", "his", "himself", "she", "her", "hers", "herself", "it", "its",
            "itself", "they", "them", "their", "theirs", "themselves", "what", "which", "who", "whom", "this", "that",
            "these", "those", "am", "is", "are", "was", "were", "be", "been", "being", "have", "has", "had", "having",
            "do", "does", "did", "doing", "a", "an", "the", "and", "but", "if", "or", "because", "as", "until", "while",
            "of", "at", "by", "for", "with", "about", "against", "between", "into", "through", "during", "before",
            "after", "above", "below", "to", "from", "up", "down", "in", "out", "on", "off", "over", "under", "again",
            "further", "then", "once", "here", "there", "when", "where", "why", "how", "all", "any", "both", "each",
            "few", "more", "most", "other", "some", "such", "no", "nor", "not", "only", "own", "same", "so", "than",
            "too", "very", "s", "t", "can", "will", "just", "don", "should", "now"};

    public MP0(String userName) {
        this.userName = userName;
    }


    public Integer[] getIndexes() throws NoSuchAlgorithmException {
        Integer n = 10000;
        Integer number_of_lines = 50000;
        Integer[] ret = new Integer[n];
        long longSeed = Long.parseLong(this.userName);
        this.generator = new Random(longSeed);
        for (int i = 0; i < n; i++) {
            ret[i] = generator.nextInt(number_of_lines);
        }
        return ret;
    }

    public String[] process() throws Exception{
    	String[] topItems = new String[20];
        Integer[] indexes = getIndexes();

    	//TO DO
		String[] allItems = new String[50000]; //To store index based list of all 50000 input lines
		ArrayList<String> stopWordsList = new ArrayList<String>(Arrays.asList(stopWordsArray)); //Convert array to list for easy manipulation
		SortedMap<String, Integer> frequency = new TreeMap<String, Integer>(); //Map with input lines as key and word count as its value
		
		int i = 0; //index
		Scanner in = new Scanner(System.in); //Scan input lines
		while (in.hasNext()) {
			allItems[i] = in.next(); //Store all input lines in index based array
			i++; //Increment index
		}
		
		for (int index: indexes) {
			StringTokenizer st = new StringTokenizer(allItems[index], delimiters, false); //Tokenize each line based on delimiters
			//Iterate each split token in the current line item
			while(st.hasMoreTokens()) {
				String searchToken = st.nextToken().toLowerCase().trim(); //Convert to lowercase and remove leading/trailing spaces
				//Ignore item processing if the token is part of stopWordsList
				if(! stopWordsList.contains(searchToken)) {
					//process if not in stopWordsList
					if (frequency.containsKey(searchToken)) {
						//if token already found, increment the word frequency count by 1
						frequency.put(searchToken, frequency.get(searchToken) + 1);
					}
					else {
						//add new token to Map structure with frequency count 1
						frequency.put(searchToken, 1);
					}
				}
				
			}
		}
		
		//Sort Map and extract only the word tokens with top 20 word count frequency
		Map<String, Integer> sorted = nLargest(frequency, 20);
		
		i = 0; //reset index to 0
		for (String key: sorted.keySet()) {
			//store the top ith token to ith index of topItems array
			topItems[i] = key;
			i++; //increment index
			
		}
		
		return topItems;
    }
	
	//Custom Utility Method that sorts the input map in descending order based on value,
	//and returns the entry sets with top n Largest values in a resulting map
	public Map<String, Integer> nLargest(SortedMap<String, Integer> map, int n) { //map and n largest values to search for

		Integer value;
		ArrayList<String> keys = new ArrayList<>(n); //to store keys of the n largest values
		ArrayList<Integer> values = new ArrayList<>(n); //to store n largest values (same index as keys)
		int index;
		for (String key : map.keySet()) { //iterate on all the keys (i.e. on all the values)
			value = map.get(key); //get the corresponding value
			index = keys.size() - 1; //initialize to search the right place to insert (in a sorted order) current value within the n largest values
			while (index >= 0 && value > values.get(index)) { //we traverse the array of largest values from smallest to biggest
				index--; //until we found the right place to insert the current value
			}
			index = index + 1; //adapt the index (come back by one)
			values.add(index, value); //insert the current value in the right place
			keys.add(index, key); //and also the corresponding key
			if (values.size() > n) { //if we have already found enough number of largest values
				values.remove(n); //we remove the last largest value (i.e. the smallest within the largest)
				keys.remove(n); //actually we store at most n+1 largest values and therefore we can discard just the last one (smallest)
			}
		}
		//Collections.sort(values, Collections.reverseOrder());
		HashMap<String, Integer> result = new HashMap<>(values.size());
		for (int i = 0; i < values.size(); i++) { //copy keys and value into an HashMap
			result.put(keys.get(i), values.get(i));
		}
		
		//First sort the result based on key for putting the words lexicographically
		Map<String, Integer> sortedResult = result
        .entrySet()
        .stream()
        .sorted(Map.Entry.comparingByKey())
        .collect(
            java.util.stream.Collectors.toMap(e -> e.getKey(), e -> e.getValue(), (e1, e2) -> e2,
                LinkedHashMap::new));
		
		//Then sort the result map based on value in descending order
		sortedResult = sortedResult
        .entrySet()
        .stream()
        .sorted(Map.Entry.comparingByValue(Comparator.reverseOrder()))
        .collect(
            java.util.stream.Collectors.toMap(e -> e.getKey(), e -> e.getValue(), (e1, e2) -> e2,
                LinkedHashMap::new));
		
		return sortedResult;
	}

    public static void main(String args[]) throws Exception {
    	if (args.length < 1){
    		System.out.println("missing the argument");
    	}
    	else{
    		String userName = args[0];
	    	MP0 mp = new MP0(userName);
	    	String[] topItems = mp.process();

	        for (String item: topItems){
	            System.out.println(item);
	        }
	    }
	}

}
