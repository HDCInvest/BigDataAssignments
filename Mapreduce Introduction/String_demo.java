
public class String_demo {

	public static void main(String[] args) {
		  String line = new String("Hadoop is open source frame work,Hadoop is good framework for handling big data");
		  String newline = line.replace(',', ' ');
		  
		  String[] test = newline.split("\\W+");
		  
		  int i = 0;
		  for (String word : test) {
		      if (word.contains("Hadoop")) {
		    	  i++;
		      	}
		  }
	      System.out.print("Number of occurrence of word Hadoop : " + i );
	}

}
