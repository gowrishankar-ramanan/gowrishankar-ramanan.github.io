from pyspark.mllib.tree import RandomForest
from pyspark import SparkContext

sc = SparkContext()


def predict(training_data, test_data):
    # TODO: Train random forest classifier from given data
    # Result should be an RDD with the prediction of the random forest for each
    # test data point
    
    from pyspark.mllib.regression import LabeledPoint
    # Segregate the data into labels and features
    labeled_data = []
    for x in training_data.collect():
        labeled_data.append(LabeledPoint( x[len(x)-1], x[0:len(x)-1] ))
        #labels.append(x[len(x)-1])
        #features.append(x[0:len(x)-1])
    
    #print(labeled_data)
    
    numClasses = 2
    categoricalFeaturesInfo = {}
    numTrees = 4
    featureSubsetStrategy = "auto"
    impurity = "gini"
    maxDepth = 6
    maxBins = 32
    seed = 12345
    
    model = RandomForest.trainClassifier(sc.parallelize(labeled_data), 
        numClasses, categoricalFeaturesInfo, numTrees, featureSubsetStrategy,
        impurity, maxDepth, maxBins, seed)
        
    predict_rdd = model.predict(test_data)
    #print(predict_rdd)
    
    return predict_rdd


if __name__ == "__main__":
    raw_training_data = sc.textFile("dataset/training.data")
    raw_test_data = sc.textFile("dataset/test-features.data")

    # TODO: Parse RDD from raw training data
    training_data = raw_training_data.map(lambda line: line.split(","))

    # TODO: Parse RDD from raw test data
    test_data = raw_test_data.map(lambda line: line.split(","))

    predictions = predict(training_data, test_data)

    # You can take a look at dataset/test-labels.data to see if your
    # predictions were right
    for pred in predictions.collect():
        print(int(pred))
