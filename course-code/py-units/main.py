from keras import ops
from keras.datasets import mnist
from neuralnet_framework import NaiveDense, NaiveSequential 
from typing import Tuple
import numpy as np
import math
import tensorflow as tf

learning_rate = 1e-3

class BatchGenerator:
    def __init__(self, images: np.ndarray, labels: np.ndarray, batch_size: int =128):
        assert len(images) == len(labels)
        self.index = 0
        self.images = images
        self.labels = labels
        self.batch_size = batch_size
        self.num_batches = math.ceil(len(images) / batch_size)

    def next(self) -> Tuple[np.ndarray, np.ndarray]:
        images = self.images[self.index : self.index + self.batch_size]
        labels = self.labels[self.index : self.index + self.batch_size]
        self.index += self.batch_size
        return images, labels
    
def update_weights(gradients, weights):
    for g, w in zip(gradients, weights):
        w.assign(w - g * learning_rate)

def one_training_step(model: NaiveSequential, images_batch: np.ndarray, labels_batch: np.ndarray) -> tf.Tensor:
    with tf.GradientTape() as tape:
        predictions = model(images_batch)
        loss = ops.sparse_categorical_crossentropy(labels_batch, predictions)
        average_loss = ops.mean(loss)
    
    gradients = tape.gradient(average_loss, model.weights)
    update_weights(gradients, model.weights)
    return average_loss

def fit(model: NaiveSequential, images: np.ndarray, labels: np.ndarray, epochs, batch_size=128):
    for epoch_counter in range(epochs):
        print(f"Epoch {epoch_counter}")
        batch_generator = BatchGenerator(images, labels)
        for batch_counter in range(batch_generator.num_batches):
            images_batch, labels_batch = batch_generator.next()
            loss = one_training_step(model, images_batch, labels_batch)
            if batch_counter % 100 == 0:
                print(f"loss at batch {batch_counter}: {loss:.2f}")

model = NaiveSequential([
    NaiveDense(input_size=28 * 28, output_size=512, activation=ops.relu),
    NaiveDense(input_size=512, output_size=10, activation=ops.softmax)
])

assert len(model.weights) == 4

(train_images, train_labels), (test_images, test_labels) = mnist.load_data()

train_images = train_images.reshape((60000, 28*28))
train_images = train_images.astype("float32") / 255
test_images = test_images.reshape((10000, 28 * 28))
test_images = test_images.astype("float32") / 255

fit(model, train_images, train_labels, epochs=10, batch_size=128)

