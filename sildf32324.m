function updateLocation(state, satellite1, satellite2, satellite3)
% Function to update the vehicle's location based on the distances to 3 satellites

% Calculate the distance from the vehicle to each satellite
distance1 = getSatelliteDistance(state, satellite1);
distance2 = getSatelliteDistance(state, satellite2);
distance3 = getSatelliteDistance(state, satellite3);

% Use triangulation to calculate the intersection of the circles
% centered at the satellite positions with radii equal to the distances
A = 2.0 * (satellite2.x - satellite1.x); % Calculate A
B = 2.0 * (satellite2.y - satellite1.y); % Calculate B
C = distance2 * distance2 - distance1 * distance1 - satellite2.x * satellite2.x + satellite1.x * satellite1.x - satellite2.y * satellite2.y + satellite1.y * satellite1.y; % Calculate C
D = 2.0 * (satellite3.x - satellite1.x); % Calculate D
E = 2.0 * (satellite3.y - satellite1.y); % Calculate E
F = distance3 * distance3 - distance1 * distance1 - satellite3.x * satellite3.x + satellite1.x * satellite1.x - satellite3.y * satellite3.y + satellite1.y * satellite1.y; % Calculate F

% Calculate the intersection of the circles
state.x = (C * E - F * B) / (E * A - B * D);
state.y = (C * D - A * F) / (B * D - A * E);
end

function distance = getSatelliteDistance(state, satellite)
% Function to calculate the distance from the vehicle to a satellite

% Calculate the distance using the Pythagorean theorem
dx = satellite.x - state.x;
dy = satellite.y - state.y;
distance = sqrt(dx * dx + dy * dy);
end

% Initialize the vehicle's state
state.x = 0.0;
state.y = 0.0;
state.heading = 0.0;

% Initialize the satellite data
satellite1.x = 100.0;
satellite1.y = 0.0;
satellite1.range = 1000.0;

satellite2.x = 0.0;
satellite2.y = 100.0;
satellite2.range = 2000.0;

satellite3.x = 100.0;
satellite3.y = 100.0;
satellite3.range = 1500.0;

% Update the vehicle's location based on the distances to the 3 satellites
updateLocation(state, satellite1, satellite2, satellite3);

% Print the updated location
fprintf('Updated location: (%f, %f)\n', state.x, state.y);