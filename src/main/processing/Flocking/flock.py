add_library('sound')
    
def average(lst): 
    return sum(lst) / len(lst) 

# The Flock (a list of Boid objects)
class Flock(object):

    def __init__(self):
        self.boids = []  # Initialize a list for all the boids.
    
    def run(self, ch_1, ch_2):
        for b in self.boids:
            # Pass the entire list of boids to each boid individually.
            b.run(self.boids)
        x_list = [b.location[0] for b in self.boids]
        x_avg = average(x_list)
        
        x_velocity_list = [b.velocity[0] for b in self.boids]
        x_velocity_avg = average(x_velocity_list)
        x_add = x_velocity_avg 
        
        y_velocity_list = [b.velocity[1] for b in self.boids]
        y_velocity_avg = average(y_velocity_list)
        y_add = y_velocity_avg 
        
        pos = (x_avg / 640) * 2 - 1
        ch_1.set(x_avg, 1, x_add, pos)
        y_list = [b.location[1] for b in self.boids]
        y_avg = average(y_list)
        ch_2.set(y_avg, 1, y_add, pos)    
    
    def addBoid(self, b):
        self.boids.append(b)
    
