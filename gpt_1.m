% Define the number of neurons in the input layer, hidden layer, and output layer
input_layer_size = 1;
hidden_layer_size = 3;
output_layer_size = 1;

% Initialize the weights and biases
W1 = rand(hidden_layer_size, input_layer_size);
b1 = rand(hidden_layer_size, 1);
W2 = rand(output_layer_size, hidden_layer_size);
b2 = rand(output_layer_size, 1);

% Define the activation function
sigmoid = @(x) 1 ./ (1 + exp(-x));

% Define the neural network function
nn = @(x) sigmoid(W2 * sigmoid(W1 * x + b1) + b2);

% Define the error function
error = @(x, y) (y - nn(x)).^2;

% Define the derivative of the activation function
dsigmoid = @(x) sigmoid(x) .* (1 - sigmoid(x));

% Define the backpropagation function
backprop = @(x, y) dsigmoid(W2 * sigmoid(W1 * x + b1) + b2) .* (y - nn(x));

% Define the learning rate
alpha = 0.1;

% Define the number of training iterations
num_iterations = 1000;

% Train the neural network
for i = 1:num_iterations
  % Generate a random training example
  x = rand;
  y = sin(x);
  
  % Backpropagate the error
  delta2 = backprop(x, y) .* sigmoid(W1 * x + b1);
  delta1 = (W2' * backprop(x, y)) .* dsigmoid(W1 * x + b1);
  
  % Update the weights and biases
  W1 = W1 + alpha * delta1 * x';
  b1 = b1 + alpha * delta1;
  W2 = W2 + alpha * delta2 * sigmoid(W1 * x + b1)';
  b2 = b2 + alpha * delta2;
end

% Test the neural network
x_test = linspace(0, 1, 100);
y_test = nn(x_test);

% Plot the results
plot(x_test, y_test, 'r-', x_test, sin(x_test), 'b-');
legend('Neural Network', 'True Function');