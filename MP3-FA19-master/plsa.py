# -*- coding: utf-8 -*-
import numpy as np
import math
import re


def normalize(input_matrix):
    """
    Normalizes the rows of a 2d input_matrix so they sum to 1
    """

    row_sums = input_matrix.sum(axis=1)
    assert (np.count_nonzero(row_sums)==np.shape(row_sums)[0]) # no row should sum to zero
    new_matrix = input_matrix / row_sums[:, np.newaxis]
    return new_matrix

def normalize(v):
    """
    Normalizes the rows of a 1d array so they sum to 1
    """

    norm = np.linalg.norm(v)
    if norm == 0:
        return v
    return v / norm


class Corpus(object):

    """
    A collection of documents.
    """

    def __init__(self, documents_path):
        """
        Initialize empty document list.
        """
        self.documents = []
        self.vocabulary = []
        self.likelihoods = []
        self.documents_path = documents_path
        self.term_doc_matrix = None 
        self.document_topic_prob = None  # P(z | d)
        self.topic_word_prob = None  # P(w | z)
        self.topic_prob = None  # P(z | d, w)

        self.number_of_documents = 0
        self.vocabulary_size = 0

    def build_corpus(self):
        """
        Read document, fill in self.documents, a list of list of word
        self.documents = [["the", "day", "is", "nice", "the", ...], [], []...]
        
        Update self.number_of_documents
        """
        # #############################
        # your code here
        # #############################
        WORD_REGEX = "^[a-z']+$"
        with open(self.documents_path) as f:
            for line in f:
                #self.number_of_documents = self.number_of_documents + 1
                list_of_words = []
                for word in line.split():
                    if re.match(WORD_REGEX, word):
                        list_of_words.append(word)
                self.documents.append(list_of_words)
        self.number_of_documents = len(self.documents)
        #pass    # REMOVE THIS

    def build_vocabulary(self):
        """
        Construct a list of unique words in the whole corpus. Put it in self.vocabulary
        for example: ["rain", "the", ...]

        Update self.vocabulary_size
        """
        # #############################
        # your code here
        # #############################
        discrete_set = set()
        for document in self.documents:
            for word in document:
                discrete_set.add(word)
        self.vocabulary = list(discrete_set)
        self.vocabulary_size = len(self.vocabulary)
        print("Vocabulary size:" + str(self.vocabulary_size))
        print("Number of documents:" + str(self.number_of_documents))
        
        #pass    # REMOVE THIS

    def build_term_doc_matrix(self):
        """
        Construct the term-document matrix where each row represents a document, 
        and each column represents a vocabulary term.

        self.term_doc_matrix[i][j] is the count of term j in document i
        """
        # ############################
        # your code here
        # ############################
        self.term_doc_matrix = np.zeros([self.number_of_documents, self.vocabulary_size], dtype = np.int)
        for d_index, doc in enumerate(self.documents):
            term_count = np.zeros(self.vocabulary_size, dtype = np.int)
            for word in doc:
                if word in self.vocabulary:
                    w_index = self.vocabulary.index(word)
                    term_count[w_index] = term_count[w_index] + 1
            self.term_doc_matrix[d_index] = term_count
        
        #pass    # REMOVE THIS


    def initialize_randomly(self, number_of_topics):
        """
        Randomly initialize the matrices: document_topic_prob and topic_word_prob
        which hold the probability distributions for P(z | d) and P(w | z): self.document_topic_prob, and self.topic_word_prob

        Don't forget to normalize!
        HINT: you will find numpy’s random matrix useful [https://docs.scipy.org/doc/numpy-1.15.0/reference/generated/numpy.random.random.html]
        """
        # ############################
        # your code here
        # ############################
        print("Initializing randomly...")
        self.number_of_topics = number_of_topics
        self.document_topic_prob = np.random.random(size = (self.number_of_documents, self.number_of_topics))
        
        self.document_topic_prob = normalize(self.document_topic_prob)
        #for d_index in range(len(self.documents)):
        #    normalize(self.document_topic_prob[d_index])
            
        self.topic_word_prob = np.random.random(size = (self.number_of_topics, len(self.vocabulary)))
        
        self.topic_word_prob = normalize(self.topic_word_prob)
        #for z in range(self.number_of_topics):
        #    normalize(self.topic_word_prob[z])

        #pass    # REMOVE THIS
        

    def initialize_uniformly(self, number_of_topics):
        """
        Initializes the matrices: self.document_topic_prob and self.topic_word_prob with a uniform 
        probability distribution. This is used for testing purposes.

        DO NOT CHANGE THIS FUNCTION
        """
        self.document_topic_prob = np.ones((self.number_of_documents, number_of_topics))
        self.document_topic_prob = normalize(self.document_topic_prob)

        self.topic_word_prob = np.ones((number_of_topics, len(self.vocabulary)))
        self.topic_word_prob = normalize(self.topic_word_prob)

    def initialize(self, number_of_topics, random=False):
        """ Call the functions to initialize the matrices document_topic_prob and topic_word_prob
        """
        print("Initializing...")

        if random:
            self.initialize_randomly(number_of_topics)
        else:
            self.initialize_uniformly(number_of_topics)

    def expectation_step(self):
        """ The E-step updates P(z | w, d)
        """
        print("E step:")
        
        # ############################
        # your code here
        # ############################
        for d_index, document in enumerate(self.documents):
            for w_index in range(self.vocabulary_size):
                prob = self.document_topic_prob[d_index, :] * self.topic_word_prob[:, w_index]
                print ("d_index = " + str(d_index) + ",  w_index = " + str(w_index))
                print ("self.document_topic_prob[d_index, :] = " + str(self.document_topic_prob[d_index, :]))
                print ("self.topic_word_prob[:, w_index] = " + str(self.topic_word_prob[:, w_index]))
                print ("topic_prob[d_index][w_index] = " + str(prob))
                print ("test:" + str(np.linalg.norm(prob)))
                
                if sum(prob) == 0.0:
                    exit(0)
                else:
                    prob = normalize(prob)
                
                print ("normalized prob = " + str(prob))
                self.topic_prob[d_index][w_index] = prob
                
        self.topic_prob = normalize(self.topic_prob)
        #pass    # REMOVE THIS
            

    def maximization_step(self, number_of_topics):
        """ The M-step updates P(w | z)
        """
        print("M step:")
        
        # update P(w | z)
        
        # ############################
        # your code here
        # ############################
        for z in range(number_of_topics):
            for w_index in range(self.vocabulary_size):
                s = 0
                for d_index in range(len(self.documents)):
                    count = self.term_doc_matrix[d_index][w_index]
                    s = s + count * self.topic_prob[d_index, w_index, z]
                    
                self.topic_word_prob[z][w_index] = s
                
        #normalize(self.topic_word_prob[z])
        self.topic_word_prob = normalize(self.topic_word_prob)
        
        
        # update P(z | d)

        # ############################
        # your code here
        # ############################
        for d_index in range(len(self.documents)):
            for z in range(number_of_topics):
                s = 0
                for w_index in range(self.vocabulary_size):
                    count = self.term_doc_matrix[d_index][w_index]
                    s = s + count * self.topic_prob[d_index, w_index, z]
                    
            self.document_topic_prob[d_index][z] = s
            
        #normalize(self.document_topic_prob[d_index])
        self.document_topic_prob = normalize(self.document_topic_prob)
        
        #pass    # REMOVE THIS


    def calculate_likelihood(self, number_of_topics):
        """ Calculate the current log-likelihood of the model using
        the model's updated probability matrices
        
        Append the calculated log-likelihood to self.likelihoods

        """
        # ############################
        # your code here
        # ############################
        L = 0.0
        for d_index in range(len(self.documents)):
            for z in range(number_of_topics):
                comb_prob = 0
                for w_index in range(self.vocabulary_size):
                    comb_prob += self.topic_word_prob[z][w_index] * self.document_topic_prob[d_index][z]
                    if comb_prob > 0:
                        L = L + self.term_doc_matrix[d_index][w_index] * np.log(comb_prob)
                        
        self.likelihoods.append(L)
        return L

    def plsa(self, number_of_topics, max_iter, epsilon):

        """
        Model topics.
        """
        print ("EM iteration begins...")
        
        # build term-doc matrix
        self.build_term_doc_matrix()
        
        # Create the counter arrays.
        # P(z | d)
        self.document_topic_prob = np.zeros([self.number_of_documents, number_of_topics], dtype=np.float)
        # P(w | z)
        self.topic_word_prob = np.zeros([number_of_topics, len(self.vocabulary)], dtype=np.float)
        # P(z | d, w)
        self.topic_prob = np.zeros([self.number_of_documents, self.vocabulary_size, number_of_topics], dtype=np.float)

        # P(z | d) P(w | z)
        self.initialize(number_of_topics, random=True)

        # Run the EM algorithm
        current_likelihood = 0.0
        self.likelihoods.append(current_likelihood)

        for iteration in range(max_iter):
            print("Iteration #" + str(iteration + 1) + "...")

            # ############################
            # your code here
            # ############################
            self.expectation_step()
            self.maximization_step(number_of_topics)
            new_likelihood = self.calculate_likelihood(number_of_topics)
            print("New Likelihood: " + str(new_likelihood))
            
            if(current_likelihood != 1 and new_likelihood - current_likelihood < epsilon):
                break
            current_likelihood = new_likehood

            #pass    # REMOVE THIS



def main():
    documents_path = 'data/test.txt'
    corpus = Corpus(documents_path)  # instantiate corpus
    corpus.build_corpus()
    corpus.build_vocabulary()
    print(corpus.vocabulary)
    print("Vocabulary size:" + str(len(corpus.vocabulary)))
    print("Number of documents:" + str(len(corpus.documents)))
    number_of_topics = 2
    max_iterations = 50
    epsilon = 0.001
    corpus.plsa(number_of_topics, max_iterations, epsilon)



if __name__ == '__main__':
    main()
