
set fuel;
set compartment;

param demand {fuel};
param max_capacity {compartment};

var assigned {fuel, compartment} binary;
var assigned_amount {fuel, compartment} >=0;
var total_fuel = sum {i in fuel, j in compartment} assigned_amount[i,j] * assigned[i,j];

minimize shortage: sum {i in fuel} demand[i] - total_fuel;

# The order needs to be delivered
subject to demand_constr {i in fuel}: 
sum {j in compartment} assigned_amount[i,j] <= demand[i];

# Each storage compartment can hold only one type of fuel
subject to compartment_constr {j in compartment}:
sum {i in fuel} assigned[i,j] <= 1;

# Amount of fuel cannot exceed the maximum capacity of each compartment
subject to capacity_constr {j in compartment}: 
sum {i in fuel} assigned_amount[i,j] <= max_capacity[j];
