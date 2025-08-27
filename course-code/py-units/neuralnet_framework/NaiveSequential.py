import numpy as np
import keras
from .NaiveDense import NaiveDense
from keras import ops
from typing import List, Callable, Optional, Union, TypeAlias

class NaiveSequential:
    def __init__(self, layers: List[NaiveDense]):
        self.layers = layers

    def __call__(self, inputs: np.ndarray) -> np.ndarray:
        """ Forward propagation """
        x = inputs
        for layer in self.layers:
            x = layer(x) # The first usage of NaiveDense's __call__ dunder method
        return x

    @property
    def weights(self) -> List[keras.Variable]:
        weights: List[keras.Variable] = []
        for layer in self.layers:
            weights += layer.weights
        return weights
