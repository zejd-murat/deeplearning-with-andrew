from keras import ops
from neuralnet_framework import NaiveDense, NaiveSequential 

model = NaiveSequential([
    NaiveDense(input_size=28 * 28, output_size=512, activation=ops.relu),
    NaiveDense(input_size=512, output_size=10, activation=ops.softmax)
])

assert len(model.weights) == 4
