import keras
from keras import ops
from typing import List, Callable, Optional, Union, TypeAlias

KOpsFunc: TypeAlias = Optional[Callable]

class NaiveDense:
    def __init__(self, input_size: int, output_size: int, activation: KOpsFunc = None):
        self.activation = activation
        self.W = keras.Variable(
            shape=(input_size, output_size), initializer="uniform")
        self.b = keras.Variable(
            shape=(output_size,), initializer="zeros")

    def __call__(self, inputs: np.ndarray) -> np.ndarray:
        """ Forward pass """
        x = ops.matmul(inputs, self.W)
        x = x + self.b
        if self.activation is not None:
            x = self.activation(x)
        return x

    @property
    def weights(self) -> List[keras.Variable]:
        return [self.W, self.b]
