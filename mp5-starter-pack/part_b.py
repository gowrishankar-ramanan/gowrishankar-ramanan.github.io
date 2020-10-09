from pyspark import SparkContext
from numpy import array
from pyspark.mllib.clustering import KMeans, KMeansModel

############################################
#### PLEASE USE THE GIVEN PARAMETERS     ###
#### FOR TRAINING YOUR KMEANS CLUSTERING ###
#### MODEL                               ###
############################################

NUM_CLUSTERS = 4
SEED = 0
MAX_ITERATIONS = 100
INITIALIZATION_MODE = "random"

sc = SparkContext()


def get_clusters(data_rdd, num_clusters=NUM_CLUSTERS, max_iterations=MAX_ITERATIONS,
                 initialization_mode=INITIALIZATION_MODE, seed=SEED):
    # TODO:
    # Use the given data and the cluster pparameters to train a K-Means model
    # Find the cluster id corresponding to data point (a car)
    # Return a list of lists of the titles which belong to the same cluster
    # For example, if the output is [["Mercedes", "Audi"], ["Honda", "Hyundai"]]
    # Then "Mercedes" and "Audi" should have the same cluster id, and "Honda" and
    # "Hyundai" should have the same cluster id
    
    # Segregate the data into titles and points
    #titles = []
    #points = []
    #for x in data_rdd.collect():
    #    titles.append(x[0])
    #    points.append(x[1:])
    
    # Convert lists to RDD
    #titles_rdd = sc.parallelize(titles)
    #points_rdd = sc.parallelize(points)
    
    titles_rdd = data_rdd.map(lambda x: x[0])
    points_rdd = data_rdd.map(lambda x: x[1:])
    #for x in points_rdd.collect():
    #    print(x)
    
    # Build the model (cluster the data)
    clusters = KMeans.train(
        points_rdd, num_clusters, maxIterations=max_iterations, 
        initializationMode=initialization_mode, seed=seed)

    # Identify which cluster does each point belong to, and map it to respective titles
    cluster = clusters.predict(points_rdd).zip(titles_rdd).collect()
    #print(cluster)
    
    # Group the titles of each clusters and aggregate the titles
    from collections import defaultdict
    res = defaultdict(list)
    for k, v in cluster: res[k].append(v)
    
    result = [v for k,v in res.items()]
    #print(result)
    
    #new_rdd.filter(lambda r: r[1] == value).collect()
    #.filter(lambda x: x[1] in rownums).map(lambda x: x[0])
    #.toDF('cluster', 'title')
    #print(result_df)
    #for x in predict_rdd.collect():
    #    print(x)
        
    return result


if __name__ == "__main__":
    f = sc.textFile("dataset/cars.data")

    # TODO: Parse data from file into an RDD
    data_rdd = f.map(lambda line: line.split(","))
    #for x in data_rdd.collect():
    #    print(x[0])
    #    print(x[1:])
    clusters = get_clusters(data_rdd)

    for cluster in clusters:
        print(','.join(cluster))
