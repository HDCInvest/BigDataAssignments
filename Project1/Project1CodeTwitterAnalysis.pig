REGISTER '/home/acadgild/Project1/data/elephant-bird-hadoop-compat-4.1.jar'
REGISTER '/home/acadgild/Project1/data/elephant-bird-pig-4.1.jar'
REGISTER '/home/acadgild/Project1/data/json-simple-1.1.1.jar'
load_tweets = LOAD 'project1_data' USING com.twitter.elephantbird.pig.load.JsonLoader('-nestedLoad') AS myMap;
extract_details = FOREACH load_tweets GENERATE myMap#'id' as id,myMap#'text' as text;
tokens = FOREACH extract_details GENERATE id,text,FLATTEN(TOKENIZE(text)) as word;
dictionary = load 'pig_data/AFINN_New.txt' using PigStorage('\t') as(word:chararray,rating:int);
word_rating = join tokens by word left outer, dictionary by word using 'replicated';
describe = word_rating;
rating =  foreach word_rating generate tokens::id as id, tokens::text as text, dictionary::rating as rate;
describe rating;
word_group = group rating by (id,text);
avg_rate = foreach word_group generate group,AVG(rating.rate) as tweet_rating;
positive_tweets = filter avg_rate by tweet_rating >=0;
dump positive_tweets;

